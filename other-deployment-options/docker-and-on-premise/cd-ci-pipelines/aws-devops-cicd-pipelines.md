# AWS DevOps CICD Pipelines

{% hint style="info" %}
This page provides a basic example of how to create pipelines with DecisionRules and AWS. For more advanced or customized pipelines tailored to specific use cases, please refer to **DecisionRules Consulting** for expert guidance and support.
{% endhint %}

## Introduction

This tutorial will guide you through setting up two CI/CD pipelines using AWS Code build  to automate the management of business rules in DecisionRules. The first pipeline will handle moving business rules from one DecisionRules space to another, even across different environments (e.g., from development to production). The second pipeline will focus on Restore-in-Time Recovery, allowing you to revert to a previous state of your business rules when necessary.

## Prerequisites

For the following steps you will need access to

* AWS Account
  * AWS Code build - Used to orchestrate the migration of the rules
  * S3 - Used to store backups of your rules



## Setting up Migration pipeline

This pipeline will be able to export rules from one selected space into another destination space

### GCP Cloud Storage Setup

First we need to setup the storage that will be used to backup the rules. In your Google cloud navigate to Cloud Storage and execute the following steps

1. Navigate to S3 -> Buckets
2. Click Create Bucket
3.
   1. Choose a name for the bucket
   2. All the other setting can be left as defaults
   3. Create Buckets



Now you should have everything you need in the S3



### GCP Cloud Build setup

Now that we have the beckup storage prepared we can go and configure the migration pipeline itself. Execute the following steps

1. Navigate to Code build ( using search bar )
2. Navigate to Build Projects
3. Create Project
   1. Fill in name, description etc.
   2. Buildspec - Insert build commands - Paste the following code&#x20;

```yaml
version: 0.2

phases:
  install:
    commands:
      - echo "starting"
      - mkdir decisionRules
      - cd decisionRules
      - git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
      - cd decisionrules-cicd-tools
      - npm install
      - mkdir export
      - echo "start export of SOURCE space"
      - npm run export export/export.json ${ENV_URL_SRC} ${SRC_ENV} 
      - echo "end export of SOURCE space"
      - echo "start export of DESTINATION space"
      - npm run export export/exportDestination.json ${ENV_URL_DEST} ${DEST_ENV} 
      - echo "end export of DESTINATION space"
      - echo "clear destination space"
      - npm run clear ${ENV_URL_DEST} ${DEST_ENV}  
      - echo "start import"
      - npm run import export/export.json ${ENV_URL_DEST} ${DEST_ENV} 
      - echo "end import"
      - echo "END"
artifacts:
  files:
    - 'decisionRules/decisionrules-cicd-tools/export/*'
  name: backup-$(date +%Y-%m-%dT%H:%M:%S) 
  discard-paths: yes

```



1. Under Environment - Environment variables add the following
   1. BRANCH\_NAME (plaintext)
      1. Fill in the name of your storage bucket that will be used to store backups
   2. ENV\_URL\_DEST and \__ENV\__&#x55;RL\_SRC (plaintext)
      1. URL for your DR API ( [https://api.decisionrules.io](https://api.decisionrules.io) as an example for public cloud )
   3. SRC\_ENV (plaintext)
      1. Management API key of the Source space
   4. DEST\_ENV (plaintext)
      1. Management API key of the Destination space
2. Under Artifact 1 primary&#x20;
   1. Select Amazon S3
   2. Put your buckets name
3. Create build project
4. Open the newly created project and click Start build
5. After the Build is successfully finished, the destination space should now contain a copy of the rule in the Source space and a backup file for both should now be available in the selected Bucket

<br>

<br>

## Setting up a rollback pipeline

This pipeline will be able to restore your space to a previous state based on the backups created by the migration pipeline, stored in Cloud Storage

<br>

### GCP Cloud storage setup

The storage bucket was already created for the previous pipeline, If you are not using it follow its instructions to create the bucket<br>

### GCP Cloud build setup

The setup closely resembles the setup of the previous pipeline

1.

    1. Fill in name, description etc.
    2. Buildspec - Insert build commands - Paste the following code&#x20;

    Create Project

    Navigate to Cloud Build ( using search bar )
2. Navigate to triggers - +Create Trigger\
   a. Fill in name, description etc.\
   b. Event - Select Manual Invocation\
   c. Configuration - select Inline\
   d. Open editor - Paste the following code

```yaml
version: 0.2

phases:
  install:
    commands:
      - echo "starting"
      - mkdir decisionRules
      - cd decisionRules
      - git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
      - cd decisionrules-cicd-tools
      - npm install
      - mkdir export
      - mkdir backup
      - aws s3 cp s3://${BUCKET_NAME}/${FOLDER_NAME}/${FILE_NAME} backup
      - echo "start export of DESTINATION space"
      - npm run export export/exportDestination.json ${ENV_URL_DEST} ${DEST_ENV} 
      - echo "end export of DESTINATION space"
      - echo "clear destination space"
      - npm run clear ${ENV_URL_DEST} ${DEST_ENV}  
      - echo "start import"
      - npm run import backup/exportDestination.json ${ENV_URL_DEST} ${DEST_ENV} 
      - echo "end import"
      - echo "END"
artifacts:
  files:
    - 'decisionRules/decisionrules-cicd-tools/export/*'
  name: rollbackBackup-$(date +%Y-%m-%dT%H:%M:%S) 
  discard-paths: yes

```



4\. Under Environment - Environment variables add the following\
&#x20;

* BUCKET\_NAME
  * Fill in the name of your storage bucket that will be used to\
    store backups
* ENV\_URL\_DEST
  * URL for your DR API ( https://api.decisionrules.io as an\
    example for public cloud )
* DEST\_ENV
  * Management API key of the Destination space\
    iv.&#x20;
* FOLDER\_NAME
  * Address of the folder used to store the backup of space that is\
    rolled back ( eg. env-back-ups/Rollback-backup )
* FILE\_NAME
  * Name of the file that is being rolled back to ( should be in th&#x65;_&#x42;RANCH\_NAME bucket ) e.g. destinationBackup-_\
    _20250506T1220_.json

5. Click Create Project

### Running the pipeline

\
In this pipeline we want to choose for each execution the specific backup file that we are\
rolling back to, this can be achieved two ways

#### Running the trigger manually ("Start build with overrrides" button)

\
a. In this case we first have to go to edit the trigger variables

b. Change the FILE\_NAME and FOLDER\_NAME variable to contain the required backup\
file name\
d. Click Start build

#### &#x20;Running Trigger using AWS console

a. Start the build via a commandline "codebuild start-build" using the `--environment-variables-override`

{% hint style="info" %}
As described here [**https://docs.aws.amazon.com/cli/latest/reference/codebuild/start-build.html**](https://docs.aws.amazon.com/cli/latest/reference/codebuild/start-build.html)
{% endhint %}

After running the command you should be able to monitor the process in Code build
