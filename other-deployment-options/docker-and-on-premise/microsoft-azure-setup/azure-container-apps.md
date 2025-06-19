---
description: >-
  This article goes over the deployment process for On-Premise solution of
  DecisionRules using Azure Container Apps.
cover: ../../../.gitbook/assets/acapps.webp
coverY: 94.8212824010914
layout:
  cover:
    visible: true
    size: hero
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Azure Container Apps

This tutorial uses Private Endpoints to communicate with the database, the cache and our key vault where we will keep secrets like certificates, license keys and other. If your deployment has no need for such security measures you can provision your resources as public, lowering the difficulty and making the deployment itself faster.

Following steps might differ depending on your level of security and sofistication of your existing Azure Cloud environment.



## Prerequisites and Recommendations

To follow this article successfully you will need the following things:

* An Azure account with a Subscription
* Permissions to create and manage the resources we're going to be using
* Permissions to manage Microsoft Entra ID, groups and RBAC (for SSO and Key Vault setup)

It is also recommended to have these prepared:

* Resource groups that fit with your conventions

## List of Topics

Below are the steps our deployment will follow.

1. [Creating a Virtual Network](azure-container-apps.md#id-1.-creating-a-virtual-network)
2. [Provisioning an Azure Cache for Redis and it's Private Endpoint](azure-container-apps.md#id-2.-provisioning-an-azure-cache-for-redis-and-its-private-endpoint)
3. [Provisioning a Cosmos DB database and it's Private Endpoint](azure-container-apps.md#id-3.-provisioning-a-cosmosdb-database-and-its-private-endpoint)
4. [Setting up our Enterprise Application for SSO](azure-container-apps.md#id-4.-setting-up-our-enterprise-application-for-sso)
5. [Creating a Key Vault, it's Private Endpoint](azure-container-apps.md#id-5.-creating-a-key-vault-its-private-endpoint)
   1. [Populating the key vault with our secrets](azure-container-apps.md#id-1.-populating-the-key-vault-with-our-secrets)
6. [Creating the Server, Client and BI containers](azure-container-apps.md#id-6.-creating-the-server-client-and-bi-containers)
   1. [Creating the Container Apps Environment](azure-container-apps.md#id-1.-creating-the-container-apps-environment)
   2. [Giving our Server container access to our key vault](azure-container-apps.md#id-2.-giving-our-server-and-bi-containers-access-to-our-key-vault)
7. [Advanced container settings](azure-container-apps.md#id-7.-advanced-container-settings)
8. [Containers Environment variables](azure-container-apps.md#id-8.-containers-environment-variables)&#x20;

[Last checks & Troubleshooting](azure-container-apps.md#last-checks-and-troubleshooting)



## The Deployment

Please note this tutorial follows a naming convention similar to the one [proposed by Microsoft](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming). This is not necessary but is considered best practice.

### 1. Creating a Virtual Network

Navigate to **Virtual networks -> Create virtual network**

Fill in your Resource group, name and Region.

<figure><img src="../../../.gitbook/assets/image (283).png" alt=""><figcaption></figcaption></figure>

When creating the vnet consider creating a dedicated subnet for the Container Apps Environment - althogh this can be done later when creating the environment itself.&#x20;

Depending on your provisioned resources these values might look a lot different.

<figure><img src="../../../.gitbook/assets/image (302).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The minimum size of the subnet dedicated to the Container Apps Environment depends on what we later choose for the Environment type. Workload profiles have a minimum subnet size of /27 whereas Consumption only types need at least /23.

Read more in [Microsofts Documentation](https://learn.microsoft.com/en-us/azure/container-apps/networking?tabs=workload-profiles-env%2Cazure-cli#environment-selection).&#x20;
{% endhint %}

Leave the rest of the options default (unless specified otherwise). You may want to provide tags for easier management. Create the Virtual Network.

***

### 2. Provisioning an Azure Cache for Redis and it's Private Endpoint

This part is the same as when deploying to Azure's Kubernetes Services. All of the necessary information on the provisioning itself and the cache's settings can be found in our [Cache - Azure Cache for Redis article](cache-azure-cache-for-redis.md).&#x20;

***

### 3. Provisioning a CosmosDb database and it's Private Endpoint

This part is the same as when deploying to Azure's Kubernetes Services. All of the necessary information on the provisioning itself and the database's settings can be found in our [Database - Azure CosmosDB article](database-azure-cosmosdb.md).&#x20;

***

### 4. Setting up our Enterprise Application for SSO

This part is the same as when deploying to Azure's Kubernetes Services. All of the necessary information on the provisioning itself and the Enterprise applications' settings can be found in our [Set up Microsoft Entra ID SSO article](../setting-up-sso/set-up-microsoft-entra-id-sso.md).&#x20;

***

### 5. Creating a Key Vault and it's Private Endpoint

Storing your connection strings, license key and SAML Certificate in a key vault is optional but highly recommended.

Navigate to **Key vaults -> Create key vault**. Fill in the required fields, for Recovery options you can choose whatever suits your use-case best.

<figure><img src="../../../.gitbook/assets/image (296).png" alt=""><figcaption><p>Basic key vault configuration</p></figcaption></figure>

In Access configuration the recommended approach is to use Azure RBAC. If, however, you don't have permissions to manage the RBAC policies of your company's cloud, you can go with Vault access policy.

In networking I choose to disable public access and create a Private Endpoint.&#x20;

<figure><img src="../../../.gitbook/assets/image (297).png" alt=""><figcaption><p>Network configuration</p></figcaption></figure>

Review the key vault settings and create.

#### &#x20;   1. Populating the key vault with our secrets

{% hint style="info" %}
Depending on your level of access to your organizations IAM settings you might not be able to assign yourself permissions to create/view secrets. If that is the case you can temporarily open the key vault to the public by going to Settings / Networking and temporarily allowing access from all networks. It is important to disable this later for security.
{% endhint %}

In the newly created key vault, navigate to Objects / Secrets. Click Generate/Import and name your secrets in recognizable ways and provide the values.&#x20;

I recommend creating 4 secrets:

* The license key for DecisionRules
* The certificate for SAML-based authentication
* The connection string for Cosmos DB
* The connection string for Azure Cache for Redis

If you have a key rotation schedule you can implement it while creating the secrets by setting activation/expiration dates.

<figure><img src="../../../.gitbook/assets/image (298).png" alt=""><figcaption><p>Populated key vault</p></figcaption></figure>

***

### 6. Creating the Server, Client and BI containers

Navigate to Container Apps and hit Create. You will be presented with a familiar settings screen. First we have to create the Container Apps Environment.

#### &#x20;   1. Creating the Container Apps Environment

In the **Basics** section of the Container Apps Creation screen under **Container Apps Environment** hit Create new. &#x20;

<figure><img src="../../../.gitbook/assets/image (301).png" alt=""><figcaption></figcaption></figure>

In the Basics part of the Container Apps Environment screen provide the environment with a name. Select **Workload Profiles** for the Environment type and choose your preferred settings for Zone redundancy.

Workload profiles tab will stay default and for Monitoring you can choose whatever your use-case needs. Keep in mind not having logs will be a hinderance if you ever need to debug the infrastrucure.

In the Networking tab select **Yes** to use your own virtual network. &#x20;

<figure><img src="../../../.gitbook/assets/image (305).png" alt=""><figcaption></figcaption></figure>

Assign your virtual network and either provide your previosly created subnet or click Create new to provision it now. Virtual IP settings should be kept **External**. If you decide to go with Internal for security reasons the accessibilty of the DecisionRules application will be extremely limited. Also keep in mind you will atleast have to create an outbound Firewall rule for the server containers calls to our license server.

{% hint style="info" %}
If you do not want application containers to have public IP addresses, you need to set Virtual IP to **Internal**.

Unfortunately, this setting cannot be changed later.
{% endhint %}

Create the environment.

#### Continuing with creating the Container App itself we get to the Container tab of the settings.

Deselect Use quickstart image and give your container a name. For Image source select **Docker Hub or other registries** and for Image type select **Public.**

The Image and tag are going to be the following:

* Client container: decisionrules/client:\<YOUR\_PREFFERED\_VERSION>
* Server container: decisionrules/server:\<YOUR\_PREFFERED\_VERSION>
* BI container: decisionrules/business-intelligence:\<YOUR\_PREFFERED\_VERSION>

Container resource allocation:

* Client container: min. 0.5 CPU cores, 1 Gi memory
* Server container: min. 1 CPU cores, 2 Gi memory
* BI container: min. 1 CPU cores, 2 Gi memory

{% hint style="info" %}
Providing the container with a version is optional though It is considered best-practice.

When not provided, latest image will be used.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (303).png" alt=""><figcaption></figcaption></figure>

Keep the Bindings tab default and continue to the **Ingress** part of our setup.&#x20;

Ingress has to be enabled for all of the containers. Traffic should be accepted from anywhere using the HTTP type. Ignore Client certificate mode.

Target ports for containers:

* Client container: 80
* Server container: 8080
* BI container: 8082

<figure><img src="../../../.gitbook/assets/image (306).png" alt=""><figcaption></figcaption></figure>

Create all of your containers using the settings outlined unless your use-case demands otherwise.

At this point your Container Apps should look something like this:

<figure><img src="../../../.gitbook/assets/image (307).png" alt=""><figcaption><p>The business-intelligence container is optional</p></figcaption></figure>

#### &#x20;  2. Giving our Server and BI containers access to our key vault

Navigate to the container's **Settings / Identity**. Turn **Status to On.** This has to be done for containers that need access to our key vault.

When that's finished applying, go to your key vault's Access control (IAM) and add a role assignment. Choose **Key Vault Secrets User** and assign this role to the Server and optionally the BI containers.&#x20;

<figure><img src="../../../.gitbook/assets/image (309).png" alt=""><figcaption></figcaption></figure>

Navigate to the key vaults **Objects / Secrets** and click on one of the secrets. Click on the secret's verison and notice the created Secrets in our vault have a **Secret Identifier** which is basically a URL that tells authorized Secrts Users where to find the Secret's value. Make a note of each Secret's Identifier.

We will now give the containers access to each of the secrets individually. Go back to Container Apps and navigate to your Server's/BI's **Settings / Secrets.** Click on Add and give the key a name, choose **Key Vault reference** for the type and **fill in the secret URL with the Secret Identifier**. For Managed Identity choose **System assigned**. After you've done this for each of the secrets let's use them for the environment variables.

<figure><img src="../../../.gitbook/assets/image (310).png" alt=""><figcaption></figcaption></figure>

* The server container needs access to the DB, Cache, License key and SAML Certificate secrets.
* The BI container needs access only to the DB secret.

***

### 7. Advanced container settings

Under **Application / Containers** in our server Container App hit Edit and deploy.

Here we have to do a couple of things for the:

* Under Scale, choose the Min / Max replicas to best fit your use-case. Mine are:
  * Server: 2-10
  * Client: 1-2
  * BI: 1-4
* Click on the container image's name under Container / Container Image.
* **Following applies only for the Server and BI containers** - Here in Health probes we will provide two of them, a Liveness probe and a Startup probe
  * Liveness probe:
    * Path: /health-check
    * Initial delay seconds: 10
    * Period seconds: 10
    * Additional settings / Failure Threshhold: 2
    * Keep the rest default
  * Startup probe:
    * Path: /health-check
    * Initial delay seconds: 5
    * Period seconds: 3
    * Additional settings / Failure Threshhold: 20
    * Keep the rest default
* Add a Scale rule for **the Server Container** and provide it these exact values (the Rule name can be anything). You can of course create your own values and types of scaling but I recommend using these ones as they've been proven to be most effective for mid-range loads.

<figure><img src="../../../.gitbook/assets/image (308).png" alt=""><figcaption></figcaption></figure>

***

### 8. Container's Environment variables

**Server Container Environment variables example:**

**Provide the Server container with the following environment variables**

* REDIS\_URL
* MONGO\_DB\_URI
* LICENSE\_KEY
* CLIENT\_URL (trailing '/#' is mandatory)
* DB\_TYPE
* API\_URL (the address of the server itself)
* Optionally the following:
  * ALLOWLIST - to control what email domains can be used in Email/Password Auth
  * SAML\_ENTRY\_POINT - for SSO
  * SAML\_ISSUER - for SSO
  * SAML\_CERT - for SSO
  * SAML\_CALLBACK\_URL - for SSO

<figure><img src="../../../.gitbook/assets/image (312).png" alt=""><figcaption></figcaption></figure>

**Client Container Environment variables example:**

<figure><img src="../../../.gitbook/assets/image (314).png" alt=""><figcaption></figcaption></figure>

**BI Container Environment variables example:**

<figure><img src="../../../.gitbook/assets/image (313).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
All of the necessary information and more about Environment variables can be found on our [Environment variables documentation page](../containers-environmental-variables.md).&#x20;
{% endhint %}

Your environment should be running now. It goes without saying that this is just one of numerous ways to structure your DecisionRules architecture on Azure.

***

## Last checks & Troubleshooting

Incorrectly following the steps listed above can result in your application not running properly. There are also a few things you might want to check after everything has been set up. Below is a list of known problems and checks you might want to know about.

#### Server Container not starting or crashing repeatedly

Troubleshooting an error this broad can be difficult so we try to populate our software with clear error messages that should let you know what's wrong. To see them, go to your server container and navigate to Monitoring / Log stream ( You could also look up your container's log history in Monitoring / Logs ).&#x20;

#### Client takes a long time to load after a period of inactivity

This is usually cause by the Client container's scaling settings. If they've been set improperly, no client containers might be live when you first try to access the site after a period of inactivity. Set the Client container's scaling to have a minimum of 1 replica running.

#### Error - Redis Client WRONGPASS

Some Azure Cache for Redis deployments require the connection string to contain the user and not only the access key. The default user is '**default**' so the final connection string would have the following format: `redis(s)://default:<access_key>@<hostname>:<port>`

#### Error - Redis Client Disconnected

Azure Cache for Redis has a 10 minute idle timeout. This means that if the Cache hasn't been used in ten minutes it goes into sleep mode disconnecting itself. This can be prevented by setting the REDIS\_PING\_INTERVAL Environment variable. This variable is set in milliseconds and should be set to a time less than ten minutes. ( 300000 recommended )

#### Login through SSO is not working

If the Login via SSO button takes you to your provider but after inputting credentials you're getting an error there are two items you should check. Make sure the CLIENT\_URL environment variable has a trailing '/#' in your server container. If the error persists check the SAML\_CERT environment variable and it's correctness- It being one-line without ---BEGIN/END Certificate---.

#### Private connection

To check whether the connection from your server container to your cache and database is private, navigate to Monitoring / Console in your server container and try to ping the name of your cache and database. If the connection is private this address name will resolve into a private IP address instead of a public one ( i.e. \[10.x.x.x] or \[172.x.x.x] or \[192.x.x.x] )

**Note**: Adaptations might be required based on Azure updates. Always refer to the latest Microsoft documentation for current practices and configurations.
