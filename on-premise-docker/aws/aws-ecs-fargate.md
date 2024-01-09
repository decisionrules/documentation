---
description: >-
  This article goes over the deployment process for On-Premise solution of
  DecisionRules using AWS Fargate.
cover: ../../.gitbook/assets/aws-fargate (1).webp
coverY: 73.36533333333333
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

# AWS ECS/Fargate

This tutorial uses MongoDB for it's database, we're going to secure this connection using VPC peering. If your use-case doesn't call for strict security you can allow your MongoDB to be accessible from anywhere and skip this step, lowering the difficulty and making the deployment itself faster.

Following steps might differ depending on your level of security and sofistication of your existing AWS environment.

Note: It is possible to follow this tutorial without prior AWS experience although basic AWS knowledge is recommended.

## Prerequisites and Recommendations

To follow this article successfully you will need the following things:

* An active AWS account.
* Sufficient permissions as specified in the `AdministratorAccess` IAM policy. This includes abilities to create service roles and manage AWS resources.
* A Mongo Atlas account with a database created.

## List of Topics

Below are the steps our deployment will follow.

1. [Provisioning a VPC](aws-ecs-fargate.md#id-1.-provisioning-a-vpc)
2. [Provisioning ElastiCache](aws-ecs-fargate.md#id-2.-provisioning-elasticache)
3. [Peering MongoDB into the VPC](aws-ecs-fargate.md#id-3.-peering-mongo-atlas-into-the-vpc)
4. [Creating the ECS Cluster](aws-ecs-fargate.md#id-4.-creating-the-ecs-cluster)
5. [Creating LoadBalancers](aws-ecs-fargate.md#id-5.-creating-load-balancers)
6. [Creating Task Definitions](aws-ecs-fargate.md#id-6.-creating-task-definitions)
7. [Creating the Services](aws-ecs-fargate.md#id-7.-creating-the-services)
8. [Accessing the Application](aws-ecs-fargate.md#id-8.-accessing-the-application)
9. [Additional Steps](aws-ecs-fargate.md#id-9.-additional-steps)



## The Deployment

### **1. Provisioning a VPC**

Begin with creating a Virtual Private Cloud (VPC) in the AWS Management Console. The VPC serves as the foundational network environment for your application.&#x20;

Select **Create VPC** and choose **VPC and more.**

Choose to deploy to 2 AZs and for simplicity we're going to create a VPC without private subnets. Choose **None** for NAT gateways and VPC endpoints.

Importantly choose **Enable DNS hostnames and resolution.**

<figure><img src="../../.gitbook/assets/image (326).png" alt=""><figcaption></figcaption></figure>

Check your settings and hit **Create VPC.**

#### Creating needed Security groups

Navigate to **VPC / Security / Security groups** and click **Create security group**. Give your security group a name and choose your newly created VPC in the selection box.

Now depending on your level of security you might want to specify where the traffic may flow into your app from. For the purposes of this tutorial however I choose to allow traffic from anywhere using the HTTP, HTTPS and SSH types.

<figure><img src="../../.gitbook/assets/image (320).png" alt=""><figcaption></figcaption></figure>

***

### **2. Provisioning ElastiCache**

This part is the same as when deploying to Amazon Elastic Kubernetes Service. All of the necessary information on the provisioning itself and the cache's settings can be found in our [Cache - Amazon ElastiCache article](cache-amazon-elasticache.md).

***

### **3. Peering Mongo Atlas into the VPC**

For your Mongo Atlas database to be able to communicate with your Fargate application you're going to have to peer the database's VPC to your VPC. To do so, navigate to your Mongo Atlas account and under **Security / Network Access / Peering** click **Add peering connection**. Choose AWS as your Cloud provider and fill in the information required (Account ID, VPC ID, VPC CIDR and region). Once you've clicked **Initiate Peering** it will only take a couple of minutes until AWS asks for approval of the new peering connection.&#x20;

To approve the connection navigate to **VPC / Virtual private cloud / Peering connections**. You should see a connection Pending acceptance. Select it and under **Actions** click **Accept request.**

<figure><img src="../../.gitbook/assets/image (323).png" alt=""><figcaption></figcaption></figure>

***

### **4. Creating the ECS Cluster**

Navigate to the Amazon ECS section in the AWS Console and hit **Create cluster**.&#x20;

Give your cluster a name and keep the rest of the settings default (make sure **AWS Farget is enabled** in the Infrastructure window).

***

### **5. Creating Load Balancers**

We're going to be creating three Load Balancers. One for the Server, one for the Client and (optionally) one for the Business Intelligence app. These will serve as entry points to the containers of our app. For each of the Load Balancers the procedure is very similar.

* **Open EC2 Dashboard**: Go to the Load Balancers section in the EC2 dashboard.
* **Select Load Balancer Type**: Choose between Application Load Balancer (ALB) or Network Load Balancer (NLB)
* **Configure Settings**: Define load balancer name, VPC, and security groups.
* **Create a Listener target group**: Under Listeners and routing click **Create target group**
  * **Target type**: IP Addresses
  * **Protocol**: NLB - TCP or ALB - HTTP
  * **VPC**: Your created VPC

Below is a table with the necessary settings for each Load Balancer.&#x20;

<table><thead><tr><th width="162">Attribute</th><th>Server</th><th width="175">Client</th><th>Business Intelligence</th></tr></thead><tbody><tr><td>LB Type</td><td>NLB</td><td>ALB</td><td>NLB</td></tr><tr><td>Scheme</td><td>Internet-facing</td><td>Internet-facing</td><td>Internet-facing</td></tr><tr><td>LB VPC / Target group VPC</td><td>Your project VPC</td><td>Your project VPC</td><td>Your project VPC</td></tr><tr><td>Target group - target type</td><td>IP Addresses</td><td>IP Addresses</td><td>IP Addresses</td></tr><tr><td>Target group - Protocol:Port</td><td>TCP:80</td><td>HTTP:80</td><td>TCP:80</td></tr></tbody></table>

***

### **6. Creating Task Definitions**

* **Access Task Definitions in ECS**: In the ECS console, choose 'Task Definitions' and 'Create new Task Definition'.
* **Configure Task**: Give your task a name and select the Fargate launch type. Define the task with container specifications, including Docker image, CPU, memory, health-checks.

Below is a table of settings for each container

<table><thead><tr><th width="156">Attribute</th><th>Server</th><th width="195">Client</th><th>Business Intelligence</th></tr></thead><tbody><tr><td>Minimum requirements</td><td>1 vCPU; 2 GB Memory</td><td>0.25 vCPU; 0.5 GB Memory</td><td>1 vCPU; 2 GB Memory</td></tr><tr><td>Task role*</td><td>None</td><td>None</td><td>None</td></tr><tr><td>Task execution role</td><td>Create new role</td><td>Create new role</td><td>Create new role</td></tr><tr><td>Container name</td><td>Any</td><td>Any</td><td>Any</td></tr><tr><td>Image URI</td><td>decisionrules/server:&#x3C;YOUR_PREFFERED_VERSION></td><td>decisionrules/client:&#x3C;YOUR_PREFFERED_VERSION></td><td>decisionrules/business-intelligence:&#x3C;YOUR_PREFFERED_VERSION></td></tr><tr><td>Protocol</td><td>TCP</td><td>TCP</td><td>TCP</td></tr><tr><td>Port</td><td>8080</td><td>80</td><td>8082</td></tr></tbody></table>

&#x20;\* - You can define Task roles that fit your use case

<figure><img src="../../.gitbook/assets/image (317).png" alt=""><figcaption><p>Server task example</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (318).png" alt=""><figcaption><p>Server task example</p></figcaption></figure>

The rest of the settings can be kept default or set up in a way that fits your use case - except for the **HealthCheck** setting. Set the **HealthCheck Command** field for each Task to their corresponding string listed below.

{% code title="Client HealthCheck" %}
```bash
CMD-SHELL, curl -s --fail http://localhost/ || exit 1
```
{% endcode %}

{% code title="Server HealthCheck" %}
```bash
CMD-SHELL, curl -s --fail http://localhost:8080/health-check || exit 1
```
{% endcode %}

{% code title="BI HealthCheck" %}
```bash
MD-SHELL, curl -s --fail http://localhost:8082/health-check || exit 1
```
{% endcode %}

|   Variable   | Recommended value |
| :----------: | :---------------: |
|   Interval   |         30        |
|    Timeout   |         5         |
| Start period |         30        |
|    Retries   |         3         |

#### Environment variable

An important part of creating Task definitions is providing each Task definition with necessary environment variables. Each of the containers (Server, client and BI) have a set of mandatory environment variables that have to be provided for your application to run properly. Read about them [here](../containers-environmental-variables.md).

<figure><img src="../../.gitbook/assets/image (325).png" alt=""><figcaption><p>Example of a server task with necessary environment variables.</p></figcaption></figure>

***

### **7. Creating the Services**

Navigate to your previously created cluster and under **Services** click **Create**. Select your Task which you would like to create the Service for, give it a name, and under Desired Tasks i recommend you input atleast 2.

<figure><img src="../../.gitbook/assets/image (319).png" alt=""><figcaption></figcaption></figure>

Next in the **Networking** section choose your VPC, it's subnets and the your custom security group. In the Load Balancing section choose the Load Balancer you've created specifically for the service you're creating (i.e.: Server NLB for the Server service etc.) and importantly **set the Health check grace period to 30 seconds.** Next in the Listener part of your Networking settings choose **Use an existing listener** and pick the one you'd created previously. When creating the Server or BI services, fill in the **Health check path** with '/health-check', leave it empty for the client container.

<figure><img src="../../.gitbook/assets/image (321).png" alt=""><figcaption><p>Load Balancer section settings example - server container</p></figcaption></figure>

Lastly the **Service auto scaling** section. This is especially important for use cases which an be expected to put a significant load unto the server. I would recommend setting it to minimum of 2, maximum of 10 tasks. For the policy use ECSServiceAverageCPUUtilization and set the target value depending on your use case.

<figure><img src="../../.gitbook/assets/image (322).png" alt=""><figcaption><p>Example of the server service's auto scaling settings</p></figcaption></figure>

***

### **8. Accessing the Application**

* **Locate Load Balancer DNS Name**: Once the service is active, go to the EC2 dashboard, find your client load balancer, and note its DNS name.
* **Test the Application**: Enter the load balancer’s DNS name in a web browser to access your deployed application.

***

### **9. Additional Steps**

* **Create SSL/TLS Certificates**: Using AWS Certificate Manager (or a 3rd party service) and your DNS provider it is recommended you create certificates for each of the load balancer's DNS names. This way you can use your custom domain as an entry point into the application as well as have the connection secure.
* **Set Up Monitoring**: Use Amazon CloudWatch to monitor your application's performance and set up alarms.
* **Implement Security Measures**: Ensure your AWS resources are secured with proper security groups and IAM roles.
* **Backup and Recovery Plans**: Establish strategies for data backup and disaster recovery for your application and databases.

***

## **Conclusion**

This tutorial provides a comprehensive pathway for deploying a DecisionRules application on AWS Fargate. Each step, from establishing network infrastructure to making the application accessible, plays a vital role in ensuring a successful cloud deployment.&#x20;

***

**Notes**: This guide is intended for informational purposes. Users should refer to the latest AWS documentation for any recent updates or changes to the service offerings or procedures.



