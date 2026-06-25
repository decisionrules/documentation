# AWS DevOps CICD Pipelines

{% hint style="info" %}
This page provides a basic example of how to create pipelines with DecisionRules and AWS. For more advanced or customized pipelines tailored to specific use cases, please refer to **DecisionRules Consulting** for expert guidance and support.
{% endhint %}

### Introduction

This tutorial will guide you through setting up two CI/CD pipelines using AWS CodeBuild to automate the management of business rules in DecisionRules. The first pipeline will handle moving business rules from one DecisionRules space to another, even across different environments (e.g., from development to production). The second pipeline will focus on Point-in-Time Recovery, allowing you to revert to a previous state of your business rules when necessary.

### Prerequisites

For the following steps you will need access to

* **AWS Account**
  * **AWS CodeBuild** – Used to orchestrate the migration of the rules
  * **S3** – Used to store backups of your rules

### Setting up the Migration pipeline

This pipeline will be able to export rules from one selected space into another destination space.

#### AWS S3 Setup

First we need to set up the storage that will be used to back up the rules. In your AWS account navigate to S3 and execute the following steps:

1. Navigate to **S3 → Buckets**
2. Click **Create bucket**
   1. Choose a name for the bucket
   2. All the other settings can be left as defaults
   3. Click **Create bucket**

Now you should have everything you need in S3.

#### AWS CodeBuild setup

Now that we have the backup storage prepared we can go and configure the migration pipeline itself. Execute the following steps:

1. Navigate to **CodeBuild** (using the search bar)
2. Navigate to **Build projects**
3. Click **Create build project**
   1. Fill in name, description, etc.
   2. **Buildspec** – Insert build commands – select _Insert build commands_ and paste the following code:

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



4. Under **Environment → Environment variables** add the following:
   1. **BUCKET\_NAME** (plaintext)
      * Fill in the name of your storage bucket that will be used to store backups
   2. **ENV\_URL\_SRC** and **ENV\_URL\_DEST** (plaintext)
      * URL for your DR API (`https://api.decisionrules.io` as an example for public cloud)
   3. **SRC\_ENV** (plaintext)
      * Management API key of the Source space
   4. **DEST\_ENV** (plaintext)
      * Management API key of the Destination space
5. Under **Artifacts → Artifact 1 – Primary**
   1. Select **Amazon S3**
   2. Put in your bucket's name
6. Click **Create build project**
7. Open the newly created project and click **Start build**
8. After the build is successfully finished, the destination space should now contain a copy of the rules in the source space, and a backup file for both should now be available in the selected bucket.

### Setting up a rollback pipeline

This pipeline will be able to restore your space to a previous state based on the backups created by the migration pipeline, stored in S3.

#### AWS S3 setup

The storage bucket was already created for the previous pipeline. If you are not using it, follow its instructions to create the bucket.

#### AWS CodeBuild setup

The setup closely resembles the setup of the previous pipeline.

1. Navigate to **CodeBuild** (using the search bar)
2. Navigate to **Build projects**
3. Click **Create build project**
   1. Fill in name, description, etc.
   2. **Buildspec** – Insert build commands – select _Insert build commands_ and paste the following code:

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
      - npm run import backup/${FILE_NAME} ${ENV_URL_DEST} ${DEST_ENV}
      - echo "end import"
      - echo "END"
artifacts:
  files:
    - 'decisionRules/decisionrules-cicd-tools/export/*'
  name: rollbackBackup-$(date +%Y-%m-%dT%H:%M:%S)
  discard-paths: yes
```



4. Under **Environment → Environment variables** add the following:
   * **BUCKET\_NAME**
     * Fill in the name of your storage bucket that is used to store backups
   * **ENV\_URL\_DEST**
     * URL for your DR API (`https://api.decisionrules.io` as an example for public cloud)
   * **DEST\_ENV**
     * Management API key of the Destination space
   * **FOLDER\_NAME**
     * Path of the folder used to store the backup of the space that is being rolled back (e.g. `backup-2025-05-06T12:20:00`)
   * **FILE\_NAME**
     * Name of the file that is being rolled back to (should be in the **BUCKET\_NAME** bucket), e.g. `exportDestination.json`
5. Click **Create build project**

### Running the pipeline

In this pipeline we want to choose, for each execution, the specific backup file that we are rolling back to. This can be achieved two ways.

#### Running the build manually ("Start build with overrides" button)

1. Open the project and click **Start build with overrides**.
2. Under **Environment variables**, change the **FOLDER\_NAME** and **FILE\_NAME** variables to contain the required backup file.
3. Click **Start build**.

#### Running the build using the AWS CLI

Start the build from the command line using `aws codebuild start-build` with the `--environment-variables-override` option, as described here: [https://docs.aws.amazon.com/cli/latest/reference/codebuild/start-build.html](https://docs.aws.amazon.com/cli/latest/reference/codebuild/start-build.html)

After running the command you should be able to monitor the process in CodeBuild.
