# Azure DevOps CICD Pipelines

## Using Azure DevOps CICD Pipelines with DecisionRules Business Rules Engine



{% hint style="info" %}
This page provides a basic example of how to create pipelines with DecisionRules and Azure DevOps. For more advanced or customized pipelines tailored to specific use cases, please refer to **DecisionRules Consulting** for expert guidance and support.
{% endhint %}

#### Introduction

This tutorial will guide you through setting up two CI/CD pipelines using **Azure DevOps** CICD Pipelines to automate the management of business rules in **DecisionRules**. The first pipeline will handle moving business rules from one DecisionRules space to another, even across different environments (e.g., from development to production). The second pipeline will focus on **Restore-in-Time Recovery**, allowing you to revert to a previous state of your business rules when necessary.

#### Prerequisites

Before starting, ensure the following:

* **Azure DevOps** account and project set up.
* **DecisionRules** account with API access.
* A **Git** repository with your DecisionRules configurations and rules.
* [DecisionRules Pipeline Tools basics on Github](https://github.com/decisionrules/decisionrules-cicd-tools)
* Access to a **Service Principal** with appropriate permissions in Azure DevOps.

<figure><img src="../../../.gitbook/assets/image (341).png" alt=""><figcaption><p>Example of two standard pipeline use cases in Azure DevOps Pipelines</p></figcaption></figure>

#### Pipeline 1: Moving DecisionRules Business Rules Between Spaces/Environments

This pipeline will automate moving business rules from one space in DecisionRules to another, supporting deployment across different environments such as development, staging, and production.

**Step 1: Create a New Azure DevOps Pipeline**

1. Navigate to your Azure DevOps project.
2. Go to **Pipelines** in the side panel, then select **Create Pipeline**.
3. Choose where your code is hosted (e.g., GitHub, Azure Repos).
4. Select the repository where your DecisionRules configuration and rules are stored.
5. Choose the **Starter Pipeline** or define a YAML pipeline.

**Step 2: Configure YAML Pipeline for DecisionRules Deployment**

**Optional: Comparison of Source and Destionation Spaces**

If you want more control over what is being overwritten in the destination space you can compare the exports of both spaces. Using the pipeline in the [appendix](azure-devops-cicd-pipelines.md#pipeline-example-with-comparison-of-space)

The YAML configuration below automates the transfer of business rules between spaces:

```yaml
trigger: none

#External parameters of this YAML pipeline. You can select source environment and target environment
parameters:
- name: srcEnv
  displayName: "Source Environment"
  type: string
  default: "TEST"
  values: [ "PRODUCTION", "TEST" ]
- name: destEnv
  displayName: "Target Environment"
  type: string
  default: "PRODUCTION"
  values: [ "PRODUCTION", "TEST" ]

variables:
- group: dr-var

pool:
  vmImage: ubuntu-latest



steps:
# Get DecisionRules CDCI Pipeline tools from Github
- script: |
    git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
    cd decisionrules-cicd-tools
    npm install
  displayName: 'Prepare DecisionRules CICD tools'

# Create branchName variable which represents branch in github repo
- script: |
    echo "##vso[task.setvariable variable=branchName;]$(date '+%Y-%m-%d-%H-%M-%S')"
  displayName: 'Set variables'

# Create project folder
- script: |
    cd decisionrules-cicd-tools
    mkdir export
  displayName: 'Creating project folder'

# Export source space from source environment
- script: |
    cd decisionrules-cicd-tools
    npm run export export/export.json $(${{parameters.srcEnv}}_ENV_URL) $(${{parameters.srcEnv}}_SPACE_MANAGEMENT_APIKEY) 
  displayName: 'Storing source project'

# Create repository, create branch for backup, commit and push exported space to git repository
- script: |
    mkdir repository && cd repository
    git clone $(GIT_REPO) .
    git config --global user.email "release@decisionrules.io"
    git config --global user.name "Release Pipeline Agent" 
    git checkout -b release/$(branchName)
    cp ../decisionrules-cicd-tools/export/export.json .
    git add .
    git commit -a -m 'Storing release'
    git push --set-upstream origin release/$(branchName) --force
  displayName: 'Storing data to git'
  
# Also attach deployment artifact to the pipeline.
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: 'decisionrules-cicd-tools/export/export.json'
    artifact: 'Exported Space'
    publishLocation: 'pipeline'
  displayName: 'Attach deployment artifact to the pipeline'

# Prepare target space for new import
- script: |
    cd decisionrules-cicd-tools
    npm run clear $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
  displayName: 'Preparing target project'

# Upload tada to target space
- script: |
    cd decisionrules-cicd-tools
    npm run import export/export.json $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
  displayName: 'Migrating to target project'
```

**Step 3: Set Up Variables**

1. In Azure DevOps, navigate to **Pipelines** > **Library** > **Variable Groups**.
2. Create Variable group **dr-var**

<figure><img src="../../../.gitbook/assets/image (351).png" alt=""><figcaption></figcaption></figure>

1.  Add the following variables:

    * `GIT_REPO`: Git repository where backups are stored
    * `*_ENV_URL`: URL of environment endpoint. This endpoint can be named i.e. as PRODUCTION, DEV, TEST, etc. This prefix is then selected in pipelines parameters section:

    ```
    parameters:
    - name: srcEnv
      displayName: "Source Environment"
      type: string
      default: "TEST"
      values: [ "PRODUCTION", "TEST" ]
    - name: destEnv
      displayName: "Target Environment"
      type: string
      default: "PRODUCTION"
      values: [ "PRODUCTION", "TEST" ]
    ```

    * `*_SPACE_MANAGEMENT_KEY`: Decision Rules Management API key that identifies the space on DecisionRules environment

**Step 4: Trigger and Monitor the Pipeline**

<figure><img src="../../../.gitbook/assets/image (344).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (347).png" alt=""><figcaption><p>Run pipeline</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (350).png" alt=""><figcaption></figcaption></figure>

Once set up, you can trigger this pipeline through code commits or manually and monitor the status from the **Pipelines** page.

***

#### Pipeline 2: Restore-in-Time Recovery Pipeline

This pipeline will allow you to revert to a previous version of a business rule, enabling a restore-in-time recovery for DecisionRules.

**Step 1: Create a New Pipeline for Recovery**

1. Follow the same steps as above to create a new pipeline in Azure DevOps.
2. Name it something like **Restore-In-Time Pipeline**.

**Step 2: Configure YAML Pipeline for Rule Restoration**

Here’s the YAML configuration for the restore pipeline:

```yaml
trigger: none

#External parameters of this YAML pipeline. You select target environment and source branch you want to restore.
parameters:
- name: destEnv
  displayName: "Target Environment"
  type: string
  default: "PRODUCTION"
  values: [ "PRODUCTION", "TEST" ]
- name: sourceBranch
  displayName: "Select source branch"
  type: string
  default: ""

#Definition of variable group in Azure DevOps.
variables:
- group: dr-var

pool:
  vmImage: ubuntu-latest


steps:
# Get DecisionRules CDCI Pipeline tools from Github
- script: |
    git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
    cd decisionrules-cicd-tools
    npm install
  displayName: 'Prepare DecisionRules CICD tools'
  
# Checkout git branch you want to restore. The branch is pushed to this YAML as sourceBranch parameter
- script: |
    mkdir repository && cd repository
    git clone --branch ${{parameters.sourceBranch}} --single-branch $(GIT_REPO) .
    git config --global user.email "release@decisionrules.io"
    git config --global user.name "Release Pipeline Agent"
  displayName: 'Storing data to git'
  

# Prepare DecisionRules space
- script: |
    cd decisionrules-cicd-tools
    npm run clear $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
  displayName: 'Preparing target project'

# Import data from git repository to DecisionRules space
- script: |
    cd decisionrules-cicd-tools
    npm run import ../repository/export.json $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
  displayName: 'Restoring target project'
```

**Step 4: Trigger and Monitor the Pipeline**

<figure><img src="../../../.gitbook/assets/image (348).png" alt=""><figcaption><p>Parameters of Restore space in time pipeline</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (349).png" alt=""><figcaption><p>Successful pipeline run</p></figcaption></figure>

### Appendix

#### Pipeline Example with comparison of Space

To add comparison of spaces and a manual review requirement we need to add environments to our pipelines.&#x20;

&#x20;How to:

1. Navigate to your Azure DevOps project.
2. Go to **Pipelines/Environments** in the side panel.
3. Create two new environments named DecisionRules-PRODUCTION and DecisionRules-TEST.
4. Open each of the envrionments and under **Approvals and Checks** add a manual review and the necessary reviewers

<figure><img src="../../../.gitbook/assets/image (371).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (372).png" alt=""><figcaption></figcaption></figure>

Then use the following pipeline. This pipeline will export both source and destination spaces, compare them and give you an overview (also available as a .json artifact) of what rules have changed between the environments. You can then go over those rules to look for suspicious or unrecognised changes.

<figure><img src="../../../.gitbook/assets/Screenshot 2025-09-09 at 10.50.27.png" alt=""><figcaption></figcaption></figure>

The reviewers will be notified via email to review the pipeline. The review approval is necessary for the pipeline to continue and overwrite the destination Space.

<figure><img src="../../../.gitbook/assets/image (373).png" alt=""><figcaption></figcaption></figure>

```yaml
trigger: none

# External parameters of this YAML pipeline
parameters:
- name: srcEnv
  displayName: "Source Environment"
  type: string
  default: "TEST"
  values: [ "PRODUCTION", "TEST" ]
- name: destEnv
  displayName: "Target Environment"
  type: string
  default: "PRODUCTION"
  values: [ "PRODUCTION", "TEST" ]

variables:
- group: dr-var

stages:
- stage: CompareEnvironments
  displayName: 'Compare Environments'
  pool:
    vmImage: ubuntu-latest
  jobs:
  - job: CompareAndExport
    displayName: 'Export and Compare Spaces'
    steps:
    # Get DecisionRules CICD Pipeline tools from Github
    - script: |
        git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
        cd decisionrules-cicd-tools
        npm install
      displayName: 'Prepare DecisionRules CICD tools'

    # Create directories
    - script: |
        cd decisionrules-cicd-tools
        mkdir -p export
        mkdir -p comparison
      displayName: 'Create directories'

    # Export source environment
    - script: |
        cd decisionrules-cicd-tools
        npm run export export/source_export.json $(${{parameters.srcEnv}}_ENV_URL) $(${{parameters.srcEnv}}_SPACE_MANAGEMENT_APIKEY)
      displayName: 'Export source environment (${{parameters.srcEnv}})'

    # Export destination environment
    - script: |
        cd decisionrules-cicd-tools
        npm run export export/destination_export.json $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
      displayName: 'Export destination environment (${{parameters.destEnv}})'

    # Run comparison
    - script: |
        cd decisionrules-cicd-tools
        echo "======================================"
        echo "COMPARING ENVIRONMENTS"
        echo "======================================"
        echo "Source: ${{parameters.srcEnv}}"
        echo "Destination: ${{parameters.destEnv}}"
        echo "======================================"
        
        # Run comparison using npm script
        npm run compare export/source_export.json export/destination_export.json comparison/comparison_results.json
      displayName: 'Compare spaces'

    # Display comparison results
    - script: |
        cd decisionrules-cicd-tools
        echo ""
        echo "======================================"
        echo "COMPARISON RESULTS:"
        echo "======================================"
        cat comparison/comparison_results.json | python3 -m json.tool
        echo "======================================"
      displayName: 'Display comparison results'

    # Publish artifacts
    - task: PublishPipelineArtifact@1
      inputs:
        targetPath: 'decisionrules-cicd-tools/export/source_export.json'
        artifact: 'SourceExport'
      displayName: 'Publish source export'

    - task: PublishPipelineArtifact@1
      inputs:
        targetPath: 'decisionrules-cicd-tools/export/destination_export.json'
        artifact: 'DestinationExport'
      displayName: 'Publish destination export'

    - task: PublishPipelineArtifact@1
      inputs:
        targetPath: 'decisionrules-cicd-tools/comparison/comparison_results.json'
        artifact: 'ComparisonResults'
      displayName: 'Publish comparison results'

- stage: Migration
  displayName: 'Migration (Requires Approval)'
  dependsOn: CompareEnvironments
  pool:
    vmImage: ubuntu-latest
  jobs:
  - deployment: MigrateToTarget
    displayName: 'Migrate to Target Environment'
    environment: 'DecisionRules-${{parameters.destEnv}}'
    strategy:
      runOnce:
        deploy:
          steps:
          # Get DecisionRules CICD Pipeline tools from Github
          - script: |
              git clone https://github.com/decisionrules/decisionrules-cicd-tools.git
              cd decisionrules-cicd-tools
              npm install
            displayName: 'Prepare DecisionRules CICD tools'

          # Download source export artifact
          - download: current
            artifact: 'SourceExport'
            displayName: 'Download source export'

          # Prepare export file
          - script: |
              cd decisionrules-cicd-tools
              mkdir -p export
              cp "$(Pipeline.Workspace)/SourceExport/source_export.json" export/export.json
            displayName: 'Prepare export'

          # Clear destination
          - script: |
              cd decisionrules-cicd-tools
              npm run clear $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
            displayName: 'Clear destination (${{parameters.destEnv}})'

          # Import to destination
          - script: |
              cd decisionrules-cicd-tools
              npm run import export/export.json $(${{parameters.destEnv}}_ENV_URL) $(${{parameters.destEnv}}_SPACE_MANAGEMENT_APIKEY)
            displayName: 'Import to destination (${{parameters.destEnv}})'

          # Final message
          - script: |
              echo "======================================"
              echo "✅ MIGRATION COMPLETED"
              echo "======================================"
              echo "Source: ${{parameters.srcEnv}}"
              echo "Destination: ${{parameters.destEnv}}"
              echo "Timestamp: $(date)"
              echo "======================================"
            displayName: 'Migration complete'
```

***

#### Conclusion

By setting up these two Azure DevOps pipelines—one for moving business rules between spaces (optionally comparing them) and the other for time-based recovery—you can effectively automate rule management in DecisionRules. These pipelines will help you maintain consistent deployments, streamline environment management, and offer the ability to quickly revert to a previous rule state when needed.
