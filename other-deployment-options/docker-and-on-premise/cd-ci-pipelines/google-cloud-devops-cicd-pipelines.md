# Google Cloud DevOps CICD Pipelines

{% hint style="info" %}
This page provides a basic example of how to create pipelines with DecisionRules and Google Cloud Platform. For more advanced or customized pipelines tailored to specific use cases, please refer to **DecisionRules Consulting** for expert guidance and support.
{% endhint %}

### Introduction

This tutorial will guide you through setting up two CI/CD pipelines using Google Cloud Build to automate the management of business rules in DecisionRules. The first pipeline will handle moving business rules from one DecisionRules space to another, even across different environments (e.g., from development to production). The second pipeline will focus on Point-in-Time Recovery, allowing you to revert to a previous state of your business rules when necessary.

### Prerequisites

For the following steps you will need access to

* **Google Cloud account**
  * **Google Cloud Build** – Used to orchestrate the migration of the rules
  * **Google Cloud Storage** – Used to store backups of your rules

### Setting up the Migration pipeline

This pipeline will be able to export rules from one selected space into another destination space.

#### GCP Cloud Storage Setup

First we need to set up the storage that will be used to back up the rules. In your Google Cloud account navigate to Cloud Storage and execute the following steps:

1. Navigate to **Cloud Storage → Buckets**
2. Click **+ Create**
   1. Choose a name for the bucket
   2. Select a location type
   3. Set the default storage class – Coldline or Archive are suitable for data accessed infrequently (note: Archive has a 365-day minimum storage duration, so prefer Nearline/Coldline if you create backups frequently)
   4. Select access control (default: Uniform)
   5. Select data protection as necessary
   6. Click **Create**

Now you should have everything you need in Cloud Storage.

#### GCP Cloud Build setup

Now that we have the backup storage prepared we can go and configure the migration pipeline itself. Execute the following steps:

1. Navigate to **Cloud Build** (using the search bar)
2. Navigate to **Triggers → + Create trigger**
   1. Fill in name, description, etc.
   2. **Event** – Select _Manual invocation_
   3. **Configuration** – select _Inline_
   4. **Open editor** – Paste the following code:

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
      - 'gs://${_BUCKET_NAME}'
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
    script: |
      #!/usr/bin/env bash
      cd decisionrules-cicd-tools/export
      cp destinationExport.json destinationBackup-$(date -u +%Y%m%dT%H%M_$SHORT_SHA).json
  - name: gcr.io/cloud-builders/gcloud
    args:
      - storage
      - cp
      - export/destinationBackup*
      - 'gs://${_BUCKET_NAME}'
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

1.
2. Click **Done**
3. Click **+ Add variable** for each of the following variables:
   1. **\_BUCKET\_NAME**
      * Fill in the name of your storage bucket that will be used to store backups
   2. **\_ENV\_URL\_SRC** and **\_ENV\_URL\_DEST**
      * URL for your DR API (`https://api.decisionrules.io` as an example for public cloud)
   3. **\_SRC\_ENV**
      * Management API key of the Source space
   4. **\_DEST\_ENV**
      * Management API key of the Destination space
4. Select the Service account
5. Click **Save**
6. Clicking **Run** will execute the build, whose progress can be seen through the popup at the bottom of the screen or in **History**
7. After the build is successfully finished, the destination space should now contain a copy of the rules in the source space, and a backup file for both should now be available in the selected bucket.

<br>

<br>

### Setting up a rollback pipeline

This pipeline will be able to restore your space to a previous state based on the backups created by the migration pipeline, stored in Cloud Storage.

#### GCP Cloud Storage setup

The storage bucket was already created for the previous pipeline. The suggestion is to create a folder in the bucket (e.g. `Rollback-backup`) for storing the backup of the space that is being rolled back.

#### GCP Cloud Build setup

The setup closely resembles the setup of the previous pipeline.

1. Navigate to **Cloud Build** (using the search bar)
2. Navigate to **Triggers → + Create trigger**
   1. Fill in name, description, etc.
   2. **Event** – Select _Manual invocation_
   3. **Configuration** – select _Inline_
   4. **Open editor** – Paste the following code:

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
    script: |
      #!/usr/bin/env bash
      cd decisionrules-cicd-tools/export
      cp destinationExport.json destinationBackup-$(date -u +%Y%m%dT%H%M_$SHORT_SHA).json
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
      - 'gs://${_BUCKET_NAME}/${_BACKUP_FILE_NAME}'
      - .
    dir: decisionrules-cicd-tools/export
    id: Download rollback backup file
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

3. Click **Done**
4. Click **+ Add variable** for each of the following variables:
   * **\_BUCKET\_NAME**
     * Fill in the name of your storage bucket that holds the backups to roll back from
   * **\_ENV\_URL**
     * URL for your DR API (`https://api.decisionrules.io` as an example for public cloud)
   * **\_DEST\_ENV**
     * Management API key of the Destination space
   * **\_BACKUP\_LOCATION**
     * Address of the folder used to store the pre-rollback backup of the space that is being rolled back (e.g. `env-back-ups/Rollback-backup`)
   * **\_BACKUP\_FILE\_NAME**
     * Name of the file that is being rolled back to (should be in the `_BUCKET_NAME` bucket), e.g. `destinationBackup-20250506T1220_a1b2c3d.json`
5. Select the Service account
6. Click **Save**

### Executing the trigger

In this trigger we want to choose, for each execution, the specific backup file that we are rolling back to. This can be achieved two ways.

#### Running the trigger manually (the "Run" button in Cloud Build → Triggers)

1. First, go to edit the trigger.
2. Change the **\_BACKUP\_FILE\_NAME** variable to contain the required backup file name.
3. Save the trigger.
4. Click **Run**.

#### Running the trigger using the Google Cloud console

1. Top right, click **Activate Cloud Shell**.
2. Wait for the terminal to open.
3. Run the following command (you have to provide the name of your pipeline and the name of your backup file):

```

gcloud builds triggers run YOUR_PIPELINE_NAME_HERE
--region=global
--substitutions=_BACKUP_FILE_NAME=YOUR_FILE_NAME_HERE

```

After running the command you should be able to monitor the process in Cloud Build /\
History
