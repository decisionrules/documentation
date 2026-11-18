---
description: >-
  Licence, MongoDB replica set and the last-resort environment variable for
  self-hosted deployments.
---

# Self-Hosted Requirements

Space Versioning on a Docker or on-premise deployment needs two things the default setup may not have: a licence that includes the feature and a MongoDB that supports transactions.

### Licence

Space Versioning is switched on by your licence, like the other licence-driven limits. Without it, the **Enable Versioning** button in **Space → Settings → Revision Settings** is disabled with _"Space Versioning is not available on your current plan."_ and the **Revisions** section shows _"Your licence does not include Space Versioning yet. Contact us to add it."_ Ask us to add the feature to your licence. With an online licence the server picks up the change at its next licence check, within 8 minutes; with an offline licence, restart the DecisionRules Server after the licence has been updated.

{% hint style="info" %}
Only users with the **Change Versioning Settings** permission see the **Enable Versioning** button. The **Revision Settings** tab exists only on spaces that belong to an organization.
{% endhint %}

The licence can also cap the number of revisions. The cap counts every revision in every state, archived ones included, across all spaces of the account that owns the space (the space owner, or the organization's billing account). Once it is reached, creating a draft or forking is refused until an old revision is deleted; rolling back is not limited by the cap. By default there is no limit.

### MongoDB with Transactions

Every revision operation — enabling, creating a draft, saving a rule into a draft, publishing, rolling back — writes several documents at once and does so in a MongoDB transaction, so a crash in the middle can never leave a space with half a revision. MongoDB supports transactions only on a **replica set** (a single-node replica set is enough) or on a compatible service that supports multi-document transactions, such as Azure DocumentDB / Cosmos DB vCore (`DB_TYPE=COSMOSDB_VCORE`).

A standalone `mongod` — which is what the [Docker Showcase](../../other-deployment-options/docker-and-on-premise/setup/showcase-client-server-app/) `docker-compose.yml` starts — does not support transactions. On such a database enabling Space Versioning is refused:

> Space Versioning requires MongoDB transaction support (a replica set or a transaction-capable service such as Cosmos DB vCore). This deployment's MongoDB does not support multi-document transactions, so revision writes could be left half-applied by a crash. Convert the database to a (single-node) replica set and restart. Last resort: SPACE\_VERSIONING\_ALLOW\_NON\_TRANSACTIONAL\_WRITES=true runs revision writes without atomicity — a crash mid-write can then leave a space's revisions inconsistent.

{% hint style="info" %}
The UI shows this message in a notification when the enable request is refused.
{% endhint %}

#### Converting a standalone MongoDB to a single-node replica set

Your data stays where it is; nothing is migrated. You can convert the database while still running 1.27.x and upgrade afterwards. Back up the database first, as before any change.

**Docker Compose.** Add `command` and `healthcheck` to the MongoDB service and let the server wait for it. The healthcheck initiates the replica set once and reports healthy when the node is primary. Keep the MongoDB version you run now; do not pull a newer image in the same step.

```yaml
services:
  server:
    depends_on:
      mongodb:
        condition: service_healthy

  mongodb:
    image: mongo:8.0 # the version you run now
    command: ["mongod", "--replSet", "rs0", "--bind_ip_all"]
    healthcheck:
      test: ["CMD", "mongosh", "--quiet", "--eval", "try { rs.status() } catch (e) { rs.initiate({ _id: 'rs0', members: [{ _id: 0, host: 'mongodb:27017' }] }) }; quit(db.hello().isWritablePrimary ? 0 : 1)"]
      interval: 5s
      timeout: 10s
      retries: 30
      start_period: 5s
```

Then run `docker compose up -d` and `docker compose restart server`.

If your MongoDB requires a username and password, use this `mongodb` service instead. A password-protected replica set also needs a key file, which its members use to authenticate each other; this variant creates one in the data volume on the first start:

```yaml
  mongodb:
    image: mongo:8.0 # the version you run now
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin # your existing user
      MONGO_INITDB_ROOT_PASSWORD: secret # and its password
    entrypoint: ["bash", "-c", "[ -f /data/db/keyfile ] || { openssl rand -base64 756 > /data/db/keyfile && chmod 400 /data/db/keyfile && chown 999:999 /data/db/keyfile; }; exec docker-entrypoint.sh mongod --replSet rs0 --bind_ip_all --keyFile /data/db/keyfile"]
    healthcheck:
      test: ["CMD-SHELL", "mongosh --quiet -u \"$$MONGO_INITDB_ROOT_USERNAME\" -p \"$$MONGO_INITDB_ROOT_PASSWORD\" --authenticationDatabase admin --eval \"try { rs.status() } catch (e) { rs.initiate({ _id: 'rs0', members: [{ _id: 0, host: 'mongodb:27017' }] }) }; quit(db.hello().isWritablePrimary ? 0 : 1)\""]
      interval: 5s
      timeout: 10s
      retries: 30
      start_period: 5s
    # keep your existing volumes entry for /data/db
```

**Other installations.** Start `mongod` with `--replSet rs0` (with a password, also with a key file: `--keyFile`). Run once `mongosh --eval 'rs.initiate({ _id: "rs0", members: [{ _id: 0, host: "mongodb.example.internal:27017" }] })'` with the host name the DecisionRules Server uses, and restart the server.

From version 1.28.0, the server's health check `GET /health-check` reports the result under `optionalChecks.transactions`: `"supported"` once the conversion worked, `"unsupported"` on a database without transactions, and `"unknown"` when the check could not decide. The server checks this once, when it starts, so restart it after converting. Optional checks are informational and never change the HTTP status of the health check; the same section also reports `apiUrl`, the result of the startup check of `API_URL`.

{% hint style="warning" %}
* Always give `rs.initiate()` the host name. Without it MongoDB stores the container ID or pod name, and the replica set has no primary once the container is recreated.
* Every application that uses the same database (Business Intelligence, backups) must reach that host name too, or add `directConnection=true` to its connection string.
{% endhint %}

Once a server process has detected that the database does not support transactions, it stops trying until the server is restarted — always restart the server after converting the database.

#### Last resort: running without transactions

For evaluation only, the server can be told to run revision writes without atomicity:

<table data-full-width="true"><thead><tr><th width="360">Variable name</th><th>Description</th><th width="108">Version</th><th>Example value</th></tr></thead><tbody><tr><td>SPACE_VERSIONING_ALLOW_NON_TRANSACTIONAL_WRITES</td><td>Allows Space Versioning on a MongoDB without multi-document transactions. Revision writes then run as plain sequential writes; a crash in the middle of one can leave a space's revisions inconsistent. Only read at start-up. Do not use in production.</td><td>>= 1.28.0</td><td>true</td></tr></tbody></table>

When the variable is set and the database turns out not to support transactions, enabling Space Versioning succeeds and each server process logs one error-level line saying that revision writes now run without atomicity (with `WORKERS_NUMBER` above 1, one line per worker). Unset the variable and restart once the database has been converted.

{% hint style="danger" %}
Without transactions a crash or a lost connection in the middle of a publish, a rollback or a disable can leave a space in an inconsistent state that has to be repaired by hand. Use a replica set for anything but a throw-away evaluation.
{% endhint %}

### Multiple Server Instances

All DecisionRules Server instances of a deployment must share the same MongoDB and the same Redis. A revision published through one instance is served by every instance immediately.

### Upgrading to 1.28.0

* The first start of version 1.28.0 creates the collections and indexes Space Versioning needs. No existing data is changed.
* The first start also replaces the indexes of the Service Logs (request log) and Event Logs collections with new ones. On large log collections this first start can take noticeably longer.
* Existing spaces stay exactly as they are until someone enables Space Versioning on them. Spaces created after the upgrade inside an organization are versioned from the start when the licence includes the feature and the database supports transactions. Otherwise the space is created unversioned — the creation itself never fails — and Space Versioning can be enabled later in **Space → Settings → Revision Settings**; on a standalone MongoDB the server logs a warning for each such space.
* Integrations are not affected until a space is enabled; from then on its Management API calls have to name a revision — see [API and Integrations](api-and-integrations.md).

### Kafka Solver API

The Kafka Solver API evaluates the published revision only; it does not accept a revision identifier.
