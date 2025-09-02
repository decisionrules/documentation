---
description: >-
  Guide to encrypting sensitive data in DecisionRules, including setting up
  keys, rotating them, and using the key rotation API.
icon: key
---

# Encrypting Sensitive Data

DecisionRules allows you to encrypt sensitive data in your application. Examples of sensitive data include:

* Database passwords
* Webhook keys
* API tokens
* Other credentials

By default, sensitive data is **not encrypted**. To enable encryption, you need to define the following environment variables:

* `ENCRYPTION_KEY_VERSION`
* `ENCRYPTION_KEY_[VERSION]`

### Setting Up Encryption

1. **Define your encryption key version**\
   The value of `ENCRYPTION_KEY_VERSION` can be any string (for example, `1`).
2. **Define the actual encryption key**\
   The encryption key must be exactly **32 characters long**.
3. **Example environment variables**:

```env
ENCRYPTION_KEY_VERSION=1
ENCRYPTION_KEY_1=21dsadas4examplekeystringof32char
```

{% hint style="info" %}
If sensitive data was already filled **before** setting these environment variables, all existing data will be **rotated and encrypted** once the variables are configured.
{% endhint %}

***

### Rotating Encryption Keys

To rotate data with a new encryption key:

1. **Keep the old key** for the previous version (e.g., `ENCRYPTION_KEY_1`).
2. **Set a new version and key**:

```env
ENCRYPTION_KEY_VERSION=2
ENCRYPTION_KEY_2=etertasddterexamplekeystringof32char
```

* This tells DecisionRules that all **newly created data** will use version `2`.
* Existing data with version `1` will still use the old key until rotation is performed.

#### Rotating Existing Data

To re-encrypt all existing data to the new key version:

1. Call the endpoint:
2. After the rotation, all data will use the **current encryption key version**.
3. You can then safely remove the old key environment variable (e.g., `ENCRYPTION_KEY_1`).

{% openapi-operation spec="rotate-key" path="/service/rotate-keys" method="patch" %}
[OpenAPI rotate-key](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/da0c327b444df6ac0f774f8b09ecc1695b2790e6a84ca6b193e3993dd74f89bb.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250902%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250902T110442Z&X-Amz-Expires=172800&X-Amz-Signature=7f4265697f75948d1bdfc4a8024dbaac183d1429e8ff3d65b5f5f429c5bc5236&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

***

### Best Practices

* Always **keep old keys** until all data is rotated.
* Use **strong, random keys** exactly 32 characters long.
* Rotate keys regularly to improve security.
* Only authorized services should access the key rotation endpoint.
