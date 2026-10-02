---
description: >-
  How to connect a MongoDB Atlas cluster privately to your AWS, Azure or Google
  Cloud network with VPC / VNet peering, so DecisionRules reaches the database
  over private IP addresses.
---

# MongoDB Atlas Network Peering

By default, a MongoDB Atlas cluster is reached over the public internet, protected by TLS and the Atlas IP access list. With network peering, the Atlas network is connected directly to your own VPC (AWS, Google Cloud) or VNet (Azure). DecisionRules then connects to the database over private IP addresses, and Atlas does not have to allow any public IP address.

This tutorial covers:

* [AWS](mongodb-atlas-network-peering.md#aws), for Amazon EKS and ECS Fargate
* [Azure](mongodb-atlas-network-peering.md#azure), for AKS, Azure Red Hat OpenShift and Azure Container Apps in your own VNet
* [Google Cloud](mongodb-atlas-network-peering.md#google-cloud), for GKE

{% hint style="info" %}
MongoDB also offers **private endpoints** (AWS PrivateLink, Azure Private Link, Google Cloud Private Service Connect) and recommends them for new production projects. See [Peering or private endpoint?](mongodb-atlas-network-peering.md#peering-or-private-endpoint) at the end of this page before you decide.
{% endhint %}

## Before you start

* **A dedicated Atlas cluster (M10 or larger).** Free (M0) and Flex clusters do not support network peering.
* **The same cloud provider on both sides.** An Atlas cluster on AWS can only be peered with an AWS VPC, and so on.
* **Atlas permissions:** Organization Owner, Project Owner or Project Network Access Manager.
* **Permissions in your cloud account** to accept peerings and change route tables (AWS), to create a role and a role assignment (Azure), or to create VPC peerings (Google Cloud, Compute Network Admin).
* **The address ranges of your network:** the VPC / VNet CIDR and, for Kubernetes, the node and Pod ranges.

### Plan the Atlas CIDR block

Atlas places your cluster nodes into its own network, whose address range (the Atlas CIDR block) you choose when you set up the first peering. Choose it carefully, because it is hard to change later.

* It must be a private (RFC 1918) range, for example from `192.168.0.0/16` or `172.16.0.0/12`.
* It must **not overlap** with your VPC / VNet or any other network you want to peer, including Kubernetes Pod and Service ranges.
* **AWS and Azure:** a `/24` to `/21` block, one per Atlas region. It is locked once a dedicated cluster or a peering exists in that region.
* **Google Cloud:** at least a `/18` block in the Atlas UI, one for the whole project. It is locked once a dedicated cluster or a peering exists in the project.

{% hint style="warning" %}
If a dedicated cluster already exists in the project, Atlas may have chosen the CIDR block for you. Check it on the Peering tab before you plan your own network ranges.
{% endhint %}

### How it works

The procedure is the same on every cloud, only the details differ:

1. **Start the peering in Atlas.** In your project, go to **Security → Database & Network Access → Peering** and add a new peering connection (depending on your Atlas UI version and cloud provider, the button is labelled **Add outbound connection**, **New Peering Connection** or **Add Peering Connection**).
2. **Complete it on the cloud side:** accept the request (AWS), grant Atlas permission (Azure) or create the peering from your side (Google Cloud).
3. **Allow the traffic:** routes and security rules, where needed.
4. **Add your network to the Atlas IP access list.** Peering does not open access by itself.
5. **Use the right connection string** in DecisionRules.
6. **Verify** the connection from inside your network.

## AWS

### 1. Prepare the VPC

Enable **DNS hostnames** and **DNS resolution** on your VPC (**VPC console → Your VPCs → select the VPC → Actions → Edit VPC settings**), or with the AWS CLI:

```bash
aws ec2 modify-vpc-attribute --vpc-id vpc-xxxx --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id vpc-xxxx --enable-dns-hostnames "{\"Value\":true}"
```

### 2. Start the peering in Atlas

On the **Peering** tab, add a new connection, choose **AWS** and fill in:

| Field                  | Value                                                                                       |
| ---------------------- | ------------------------------------------------------------------------------------------- |
| Account ID             | Your 12-digit AWS account ID                                                                |
| VPC ID                 | The VPC your EKS cluster or ECS tasks run in (`vpc-...`)                                    |
| VPC CIDR               | The CIDR block of that VPC                                                                  |
| Application VPC Region | The region of your VPC                                                                      |
| Atlas VPC Region       | The region of your Atlas cluster (usually the same)                                         |
| Atlas CIDR             | See [Plan the Atlas CIDR block](mongodb-atlas-network-peering.md#plan-the-atlas-cidr-block) |

You can tick **Add this CIDR block to my IP access list** to cover step 5 right away. Click **Initiate Peering**. After a few minutes, AWS receives a peering request.

### 3. Accept the request and add routes

1. In the AWS console, switch to the region of your VPC and go to **VPC → Peering connections**.
2. Select the connection in the `Pending acceptance` state and choose **Actions → Accept request**. The request expires after 7 days.
3. Add a route to the Atlas CIDR block through the peering connection to **every route table** used by the subnets of your EKS nodes or ECS tasks. EKS VPCs often have one private route table per availability zone.

```bash
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-xxxx

aws ec2 create-route --route-table-id rtb-xxxx \
  --destination-cidr-block <ATLAS_CIDR> \
  --vpc-peering-connection-id pcx-xxxx
```

### 4. Allow outbound traffic

If the security groups of your nodes or tasks restrict outbound traffic, allow **TCP 27015-27017** to the Atlas CIDR block. The default security group rules allow all outbound traffic.

### 5. Add your network to the IP access list

In Atlas, go to **Security → Database & Network Access → IP Access List** and add the range the traffic comes from:

| Workload                              | Source address seen by Atlas                                                   | Add to the access list                                                        |
| ------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| EKS with the Amazon VPC CNI (default) | Node IP. Traffic to addresses outside your VPC is translated to the node's IP. | The VPC CIDR or the node subnets                                              |
| EKS with external SNAT enabled        | Pod IP                                                                         | The Pod subnets. They must also be inside the VPC CIDR you entered in step 2. |
| ECS Fargate (`awsvpc` network mode)   | Task IP                                                                        | The task subnets or the VPC CIDR                                              |

As an alternative to a CIDR, you can add an AWS **security group** as an access list entry. This works only for peerings in the same AWS region, and not in projects with peerings in several regions.

### 6. Use the connection string

On AWS, the standard connection string (`mongodb+srv://cluster0.xxxxx.mongodb.net`) resolves to private IP addresses from inside the peered VPC, so you can use it as it is. Only if your VPC uses a custom DNS server, enable **Using Custom DNS on AWS with VPC Peering** in the Atlas **Project Settings** and use the private connection string (with `-pri` in the hostname).

## Azure

On Azure, Atlas creates the peering itself. You only give the Atlas service principal permission to manage peerings on your VNet.

### 1. Start the peering in Atlas

On the **Peering** tab, add a new connection, choose **Azure** and fill in:

| Field               | Value                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------- |
| Subscription ID     | The subscription of your VNet                                                               |
| Directory ID        | Your Microsoft Entra tenant ID                                                              |
| Resource Group Name | The resource group of your VNet                                                             |
| VNet Name           | The VNet your AKS cluster, OpenShift cluster or Container Apps environment runs in          |
| Atlas CIDR          | See [Plan the Atlas CIDR block](mongodb-atlas-network-peering.md#plan-the-atlas-cidr-block) |
| Atlas VNet Region   | The region of your Atlas cluster                                                            |

Click **Next**. Atlas shows the commands for the next step, already filled in with your values.

### 2. Grant Atlas permission to peer with your VNet

Run the commands in Azure Cloud Shell or with the Azure CLI.

Create the service principal for the MongoDB Atlas application (once per tenant). If it already exists, the command reports a conflict and you can continue.

```bash
az ad sp create --id e90a1407-55c3-432d-9cb1-3638900a9d22
```

Create a custom role that can manage peerings on your VNet. Save this as `peering-role.json` and replace the placeholders:

{% code title="peering-role.json" %}
```json
{
  "Name": "AtlasPeering/<azureSubscriptionId>/<resourceGroupName>/<vnetName>",
  "IsCustom": true,
  "Description": "Grants MongoDB access to manage peering connections on network /subscriptions/<azureSubscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/virtualNetworks/<vnetName>",
  "Actions": [
    "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/read",
    "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write",
    "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/delete",
    "Microsoft.Network/virtualNetworks/peer/action"
  ],
  "AssignableScopes": [
    "/subscriptions/<azureSubscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/virtualNetworks/<vnetName>"
  ]
}
```
{% endcode %}

Create the role and assign it to the Atlas service principal:

```bash
az role definition create --role-definition peering-role.json

az role assignment create \
  --role "AtlasPeering/<azureSubscriptionId>/<resourceGroupName>/<vnetName>" \
  --assignee "e90a1407-55c3-432d-9cb1-3638900a9d22" \
  --scope "/subscriptions/<azureSubscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/virtualNetworks/<vnetName>"
```

{% hint style="info" %}
Creating the service principal may require a Microsoft Entra administrator. Creating and assigning the role requires the Owner or User Access Administrator role on the VNet. You can remove the role assignment once the peering is established.
{% endhint %}

### 3. Validate and initiate the peering

Back in Atlas, click **Validate** and then **Initiate Peering**. Wait until the peering shows **Available**. If your Atlas cluster spans several regions, create a peering for each Atlas region.

### 4. Allow outbound traffic

The default network security group rules allow traffic to peered VNets. Only if you added rules that deny outbound traffic, allow the Atlas CIDR block.

### 5. Add your network to the IP access list

In Atlas, go to **Security → Database & Network Access → IP Access List** and add the range the traffic comes from. The simplest option is the whole VNet address space. For AKS, the source address depends on the network plugin:

| AKS network plugin                    | Source address seen by Atlas | Add to the access list |
| ------------------------------------- | ---------------------------- | ---------------------- |
| Azure CNI Overlay                     | Node IP                      | The node subnet        |
| Azure CNI with a dedicated Pod subnet | Pod IP                       | The Pod subnet         |
| Azure CNI (node subnet, legacy)       | Node IP                      | The node subnet        |
| kubenet (legacy)                      | Node IP                      | The node subnet        |

For Azure Red Hat OpenShift, add the worker subnet. For Azure Container Apps, add the subnet of the Container Apps environment.

### 6. Use the private connection string

On Azure you **must** use the private connection string. In Atlas, open **Connect** on your cluster and choose **Private IP for Peering**. The hostname contains `-pri`, for example `mongodb+srv://cluster0-pri.xxxxx.mongodb.net`. The standard connection string resolves to public IP addresses and does not use the peering.

## Google Cloud

### 1. Start the peering in Atlas

On the **Peering** tab, add a new connection, choose **Google Cloud** and fill in:

| Field      | Value                                                                                                        |
| ---------- | ------------------------------------------------------------------------------------------------------------ |
| Project ID | The Google Cloud project of your VPC                                                                         |
| VPC Name   | The VPC network your GKE cluster runs in                                                                     |
| Atlas CIDR | See [Plan the Atlas CIDR block](mongodb-atlas-network-peering.md#plan-the-atlas-cidr-block) (at least `/18`) |

Click **Initiate Peering**. The Peering tab then shows the **Atlas GCP Project ID** and the **Atlas VPC Name**. You need both in the next step.

### 2. Create the peering in Google Cloud

In the Google Cloud console, go to **VPC network → VPC network peering → Create connection** and fill in:

* **Name:** for example `atlas-peering`
* **Your VPC network:** the VPC of your GKE cluster
* **Peered VPC network:** **In another project**, with the Atlas GCP Project ID and the Atlas VPC Name from step 1
* Leave importing and exporting of custom routes turned off. Atlas does not accept custom routes, and subnet routes (including GKE Pod ranges) are always exchanged.

Or with `gcloud`:

```bash
gcloud compute networks peerings create atlas-peering \
  --network=<YOUR_VPC> \
  --peer-project=<ATLAS_GCP_PROJECT_ID> \
  --peer-network=<ATLAS_VPC_NAME>

gcloud compute networks peerings list
```

Wait until the peering is `ACTIVE` in Google Cloud and **Available** in Atlas.

### 3. Allow outbound traffic

Google Cloud allows all outbound traffic by default. Only if you added egress deny firewall rules, allow **TCP 27015-27017** to the Atlas CIDR block.

### 4. Add your network to the IP access list

{% hint style="warning" %}
This is the most common reason why DecisionRules on GKE cannot reach Atlas. GKE does not translate Pod addresses when Pods talk to private ranges, so Atlas sees the **Pod IP addresses**, not the node addresses.
{% endhint %}

In Atlas, go to **Security → Database & Network Access → IP Access List** and add both:

* the cluster's **Pod IPv4 range**, and
* the **node subnet** range.

You can find both on the cluster's details page in the Google Cloud console (**Networking** section), or with `gcloud`:

```bash
# Pod IPv4 range
gcloud container clusters describe <CLUSTER_NAME> --region <REGION> --format='value(clusterIpv4Cidr)'

# Node subnet range
gcloud compute networks subnets describe <SUBNET_NAME> --region <REGION> --format='value(ipCidrRange)'
```

Network peering works only with **VPC-native** GKE clusters. This is the default for new Standard clusters, and Autopilot clusters are always VPC-native. If you added more Pod ranges to the cluster later, add them as well.

### 5. Use the private connection string

On Google Cloud you **must** use the private connection string. In Atlas, open **Connect** on your cluster and choose **Private IP for Peering**. The hostname contains `-pri`, for example `mongodb+srv://cluster0-pri.xxxxx.mongodb.net`. The private connection string appears only after the peering is **Available**.

{% hint style="info" %}
Clients connected to your VPC through Cloud VPN or Cloud Interconnect (for example an on-premises network) cannot reach Atlas through the peering, because peering is not transitive. Use a private endpoint if you need that.
{% endhint %}

## Configure DecisionRules

Use the connection string from the steps above for both databases DecisionRules needs, typically as two databases on the same Atlas cluster:

| Variable          | Example                                                                              |
| ----------------- | ------------------------------------------------------------------------------------ |
| `MONGO_DB_URI`    | `mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules`       |
| `BI_MONGO_DB_URI` | `mongodb+srv://<user>:<password>@cluster0-pri.xxxxx.mongodb.net/decisionrules-audit` |

Create a database user in **Security → Database & Network Access → Database Users** with read and write access to both databases. Store the connection strings as secrets, for example in the Kubernetes Secret used by the [OpenShift](kubernetes-setup/helm-charts/openshift-helm-chart.md) and [GKE](kubernetes-setup/helm-charts/gke-helm-chart.md) Helm charts. See [Environment Variables](../containers-environmental-variables.md) for all database settings.

## Verify the connection

Test from inside your network, not from your own computer. From a Kubernetes cluster, start a temporary Pod with the MongoDB shell:

```bash
kubectl run mongosh --rm -it --restart=Never --image=mongo:8.0 -- \
  mongosh "mongodb+srv://cluster0-pri.xxxxx.mongodb.net/" --username <user> --eval "db.runCommand({ ping: 1 })"
```

The command asks for the password and prints `{ ok: 1 }` when the connection works. To check that the name resolves to a private address inside the Atlas CIDR block:

```bash
kubectl run nettest --rm -it --restart=Never --image=nicolaka/netshoot -- \
  dig +short cluster0-shard-00-00-pri.xxxxx.mongodb.net
```

Use the hostname of one of your cluster nodes. You can find it in Atlas when you open the cluster's metrics or the **Connect** dialog with the standard (non-SRV) connection string.

## Troubleshooting

If DecisionRules logs a timeout while connecting to MongoDB, check these in order:

* **Peering status.** Atlas shows **Available**, and the cloud side shows the peering as active.
* **IP access list.** The range your traffic comes from is listed. On GKE this is the Pod range, on AKS with a Pod subnet it is the Pod subnet.
* **Connection string.** On Azure and Google Cloud, the hostname must contain `-pri`.
* **Routes (AWS).** Every route table of your node or task subnets has a route to the Atlas CIDR block through the peering connection.
* **Overlapping ranges.** The Atlas CIDR block does not overlap with your VPC / VNet, Pod or Service ranges.
* **Expired request (AWS).** Peering requests that are not accepted within 7 days expire. Create a new one.
* **Multi-region clusters (AWS, Azure).** Each Atlas region needs its own peering.
* **Transitive paths.** Networks connected to yours through VPN, Direct Connect, ExpressRoute, Interconnect or a hub network cannot reach Atlas through the peering.

## Automation

The same setup can be scripted:

* **Atlas CLI:** `atlas networking peering create aws|azure|gcp ...`, then `atlas networking peering watch <peerId>`.
* **Terraform:** the `mongodbatlas_network_container` and `mongodbatlas_network_peering` resources, together with `aws_vpc_peering_connection_accepter` (AWS) or `google_compute_network_peering` (Google Cloud), and `mongodbatlas_project_ip_access_list`.

## Peering or private endpoint?

|                                              | Network peering                                      | Private endpoint                    |
| -------------------------------------------- | ---------------------------------------------------- | ----------------------------------- |
| Cost                                         | No extra Atlas charge                                | Charged per endpoint                |
| Address planning                             | Atlas CIDR block must not overlap with your networks | No address planning                 |
| Direction                                    | Both networks can initiate connections               | Only your side can connect to Atlas |
| Access from VPN, on-premises or hub networks | Not possible (not transitive)                        | Possible                            |
| IP access list                               | You add your ranges yourself                         | Handled by Atlas                    |
| Cluster tier                                 | M10 and larger                                       | M10 and larger                      |

Peering is simpler and cheaper for a single application network. Private endpoints limit the trust boundary and work across connected networks, which is why MongoDB recommends them for new production projects. For setup details, see the MongoDB documentation on [network peering](https://www.mongodb.com/docs/atlas/security-vpc-peering/) and [private endpoints](https://www.mongodb.com/docs/atlas/security-private-endpoint/).

**Note:** The Atlas and cloud consoles change over time. Always check the latest MongoDB Atlas and cloud provider documentation if a screen looks different.
