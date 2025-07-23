# Google Cloud DevOps CICD Pipelines

{% hint style="info" %}
This page provides a basic example of how to create pipelines with DecisionRules and Google Cloud Platform. For more advanced or customized pipelines tailored to specific use cases, please refer to **DecisionRules Consulting** for expert guidance and support.
{% endhint %}

## Introduction

This tutorial will guide you through setting up two CI/CD pipelines using Azure DevOps CICD PipelinesGoogle Cloud Build  to automate the management of business rules in DecisionRules. The first pipeline will handle moving business rules from one DecisionRules space to another, even across different environments (e.g., from development to production). The second pipeline will focus on Restore-in-Time Recovery, allowing you to revert to a previous state of your business rules when necessary.

## Prerequisites

For the following steps you will need access to

* Google cloud account
  * Google Cloud Build - Used to orchestrate the migration of the rules
  * Google Cloud Storage - Used to store backups of your rules



## Setting up Migration pipeline

This pipeline will be able to export rules from one selected space into another destination space

### GCP Cloud Storage Setup

First we need to setup the storage that will be used to backup the rules. In your Google cloud navigate to Cloud Storage and execute the following steps

1. Navigate to Cloud Storage -> Buckets
2. Click +Create
3.
   1. Choose a name for the bucket
   2. Select location type
   3. Set Default Class - Archive ( data stored for long periods accessed infrequently )
   4. Select access control ( default Uniform )
   5. Select data protection as necessary
   6. Create



Now you should have everything you need in the Cloud storage



### GCP Cloud Build setup

Now that we have the beckup storage prepared we can go and configure the migration pipeline itself. Execute the following steps

1. Navigate to Cloud Build ( using search bar )
2. Navigate to triggers - +Create Trigger
3.
   1. Fill in name, description etc.
   2. Event - Select Manual Invocation
   3. Configuration - select Inline
   4. Open editor - Paste the following code

```yaml
steps:
  - name: gcr.io/cloud-builders/git
    args:
      - clone
      - 'https://github.com/decisionrules/decisionrules-cicd-tools.git'
    id: Prepare Decisionrules CI/CD tools
  - name: node
    args:
      - install
    dir: decisionrules-cicd-tools
    id: install requirements
    entrypoint: npm
  - name: bash
    id: create export folder and prepare date for backup
    script: |
      #!/usr/bin/env bash
      cd decisionrules-cicd-tools
      mkdir export
  - name: node
    args:
      - run
      - export
      - export/export.json
      - '${_ENV_URL_SRC}'
      - '${_SRC_ENV}'
    dir: decisionrules-cicd-tools
    id: export source space
    entrypoint: npm
  - name: bash
    id: prepare Source backup
    script: |
      #!/usr/bin/env bash
      cd decisionrules-cicd-tools/export
      cp export.json sourceBackup-$(date -u +%Y%m%dT%H%M_$SHORT_SHA).json
  - name: gcr.io/cloud-builders/gcloud
    args:
      - storage
      - cp
      - export/sourceBackup*
      - 'gs://${_BRANCH_NAME}'
    dir: decisionrules-cicd-tools
    id: Create source backup
  - name: node
    args:
      - run
      - export
      - export/destinationExport.json
      - '${_ENV_URL_DEST}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: export destination space
    entrypoint: npm
  - name: bash
    id: prepare Destination backup
    script: >
      #!/usr/bin/env bash


      cd decisionrules-cicd-tools/export


      cp destinationExport.json destinationBackup-$(date -u
      +%Y%m%dT%H%M_$SHORT_SHA).json
  - name: gcr.io/cloud-builders/gcloud
    args:
      - storage
      - cp
      - export/destinationBackup*
      - 'gs://${_BRANCH_NAME}'
    dir: decisionrules-cicd-tools
    id: Create destination backup
  - name: node
    args:
      - run
      - clear
      - '${_ENV_URL_DEST}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: clear target space
    entrypoint: npm
  - name: node
    args:
      - run
      - import
      - export/export.json
      - '${_ENV_URL_DEST}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: Import rules to Destination environment
    entrypoint: npm
options:
  logging: CLOUD_LOGGING_ONLY

```

1. Click Done
2. +Add Variable for the following variables
3.
   1. \_BRANCH\_NAME
      1. Fill in the name of your storage bucket that will be used to store backups
   2. \_ENV\_URL\_DEST and \__ENV\__&#x55;RL\_SRC
      1. URL for your DR API ( [https://api.decisionrules.io](https://api.decisionrules.io) as an example for public cloud )
   3. \_SRC\_ENV
      1. Management API key of the Source space
   4. \_DEST\_ENV
      1. Management API key of the Destination space
4. Select the Service account
5. Click Save
6. Clicking Run will execute the build whose progress can be seen through the popup at the bottom of the screen or in History
7. After the Build is successfully finished, the destination space should now contain a copy of the rule in the Source space and a backup file for both should now be available in the selected Bucket

\


\


## Setting up a rollback pipeline

This pipeline will be able to restore your space to a previous state based on the backups created by the migration pipeline, stored in Cloud Storage

\


### GCP Cloud storage setup

The storage bucket was already created for the previous pipeline, suggestion is to create a\
folder in the bucket ( e.g. Rollback-backup ) for storing backup of the space that is being\
rolled back

### GCP Cloud build setup

The setup closely resembles the setup of the previous pipeline

1. Navigate to Cloud Build ( using search bar )
2. Navigate to triggers - +Create Trigger\
   a. Fill in name, description etc.\
   b. Event - Select Manual Invocation\
   c. Configuration - select Inline\
   d. Open editor - Paste the following code

```yaml
steps:
  - name: gcr.io/cloud-builders/git
    args:
      - clone
      - 'https://github.com/decisionrules/decisionrules-cicd-tools.git'
    id: Prepare Decisionrules CI/CD tools
  - name: node
    args:
      - install
    dir: decisionrules-cicd-tools
    id: install requirements
    entrypoint: npm
  - name: bash
    id: create export folder and prepare date for backup
    script: |
      #!/usr/bin/env bash
      cd decisionrules-cicd-tools
      mkdir export
  - name: node
    args:
      - run
      - export
      - export/destinationExport.json
      - '${_ENV_URL}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: export destination space
    entrypoint: npm
  - name: bash
    id: prepare Destination backup
    script: >
      #!/usr/bin/env bash

      cd decisionrules-cicd-tools/export

      cp destinationExport.json destinationBackup-$(date -u
      +%Y%m%dT%H%M_$SHORT_SHA).json
  - name: gcr.io/cloud-builders/gcloud
    args:
      - storage
      - cp
      - export/destinationBackup*
      - 'gs://${_BACKUP_LOCATION}'
    dir: decisionrules-cicd-tools
    id: Create destination backup
  - name: gcr.io/cloud-builders/gcloud
    args:
      - storage
      - cp
      - 'gs://${_BRANCH_NAME}/${_BACKUP_FILE_NAME}'
      - .
    dir: decisionrules-cicd-tools/export
  - name: node
    args:
      - run
      - clear
      - '${_ENV_URL}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: clear target space
    entrypoint: npm
  - name: node
    args:
      - run
      - import
      - 'export/${_BACKUP_FILE_NAME}'
      - '${_ENV_URL}'
      - '${_DEST_ENV}'
    dir: decisionrules-cicd-tools
    id: Rollback the destination space
    entrypoint: npm
options:
  logging: CLOUD_LOGGING_ONLY

```

3\. Click Done\
4\. +Add Variable for the following variables\
&#x20;

* \_BRANCH\_NAME
  * Fill in the name of your storage bucket that will be used to\
    store backups
* \_ENV\_URL
  * URL for your DR API ( https://api.decisionrules.io as an\
    example for public cloud )
* \_DEST\_ENV
  * Management API key of the Destination space\
    iv.&#x20;
* \_BACKUP\_LOCATION
  * Address of the folder used to store the backup of space that is\
    rolled back ( eg. env-back-ups/Rollback-backup )
* \_BACKUP\_FILE\_NAME
  * Name of the file that is being rolled back to ( should be in th&#x65;_&#x42;RANCH\_NAME bucket ) e.g. destinationBackup-_\
    _20250506T1220_.json

5. Select the Service account
6. Click Save

### Executing the trigger

\
In this trigger we want to choose for each execution the specific backup file that we are\
rolling back to, this can be achieved two ways

#### Running the trigger manually ( “Run” button is CloudBuild/Triggers )

\
a. In this case we first have to go to edit the trigger

b. Change the \_BACKUP\_FILE\_NAME variable to contain the required backup\
file name\
c. Save the trigger\
d. Click Run

#### &#x20;Running Trigger using Gloud console

a. Top right click activate cloud shell\
b. Wait for the terminal to open\
c. Run the following command ( you have to provide the name of your pipeline\
and the name of your backup file )

```

gcloud builds triggers run YOUR_PIPELINE_NAME_HERE
--region=global
--substitutions=_BACKUP_FILE_NAME=YOUR_FILE_NAME_HERE

```

After running the command you should be able to monitor the process in Cloud Build /\
History
