# Migration Strategies

## **Creating new rule**

![](../.gitbook/assets/create\_rule\_1.png)

### **Getting a rule model from a source environment**

You can get your current rule model by HTTP GET method with path **/api/rule/{ruleId}/{?version}** or with the **getRule** method by SDK.

Another option is to get the rule model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule with ruleId and version as a response.

More information about the HTTP GET methods can be found here: [#get-rule](../api/management-api.md#get-rule "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### Modify rule model

After you get the current rule model you have to modify it before you will create a new rule on a target environment.

If you want to have a rule version from 1, you have to change the rule version to 1 or delete the version from the model.

#### **Source and target environment on the same database**

In this case, you have to delete ruleId and baseId from the model.

#### **Source and target environment on the different database**

In this case, if you want to have the same ruleId, you do not make any changes. If you want to have a different ruleId than it is in the current environment, you have to delete ruleId and baseId from the model.

### **Create a new rule for a target environment**

After you modify the rule model, you can create it in the target environment by HTTP POST method with path **/api/rule** or with _**createRule**_ method by SDK.

As a response, you get a new rule model with newly generated ruleId, baseId, and version.

More information about the HTTP POST method can be found here: **** [#create-rule](../api/management-api.md#create-rule "mention")****

## **Create a new rule version**

![](../.gitbook/assets/new\_version\_rule.png)

### Getting a rule model from a source environment

You can get your current rule model by HTTP GET method with path **/api/rule/{ruleId}/{?version}** or with the **getRule** method by SDK.

Another option is to get the rule model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule with ruleId and version as a response.

More information about the HTTP GET methods can be found here: [#get-rule](../api/management-api.md#get-rule "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### Modify rule model

After you get the current rule model you have to modify it. You have to change ruleId, baseId to a ruleId which version you want to a create. Next, you have to change the version to a new version that you want.

### Create a new rule version for a target environment

After you modify the rule model, you can create it in the target environment by HTTP POST method with path **/api/rule** or with _**createRule**_** ** method by SDK.

As a response, you get a new rule model with newly generated ruleId, baseId, and version.

More information about the HTTP POST method can be found here: **** [#create-rule](../api/management-api.md#create-rule "mention")****

## **Update rule**

![](<../.gitbook/assets/update\_rule (1).png>)

### Getting a rule model from a source environment

You can get your current rule model by HTTP GET method with path **/api/rule/{ruleId}/{?version}** or with the **getRule** method by SDK.

Another option is to get the rule model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule with ruleId and version as a response.

More information about the HTTP GET methods can be found here: [#get-rule](../api/management-api.md#get-rule "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### Modify rule model

After you get the current rule model you have to modify it. You have to delete baseId from the rule model.

### Update rule with the specific version on the target environment

After you modify the rule model, you can create it in the target environment by HTTP PUT method with path **/api/rule/{ruleId}/{?version}** or with **updateRule** method by SDK.

As a response, you get a updated rule model.

More information about the HTTP PUT method can be found here: [#update-rule](../api/management-api.md#update-rule "mention")

## **Create a separate rule flow**

![](../.gitbook/assets/create\_ruleflowdrawio.png)

### Getting a rule flow model from a source environment

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/{ruleFlowId}/{?version}** or with **getRuleFlow** method by SDK.

Another option is to get the rule flow model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule flow with ruleFlowId and version as a response.

More information about the HTTP GET method can be found here: [#get-rule-flow](../api/management-api.md#get-rule-flow "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### **Modify rule flow model**

If you want to have a rule version from 1, you have to change the rule version to 1 or delete the version from the model.

#### Source and target environment on the same database

In this case, you have to delete compositionId and baseId from the model.

#### Source and target environment on different database

In this case, if you want to have the same ruleId, you do not make any changes. If you want to have a different ruleId than it is in the current environment, you have to delete ruleId and baseId from the model.

### Create a new rule flow for a target environment

After you modify the rule flow model, you can create it in the target environment by HTTP POST method with path **/api/rule-flow** or with **createRuleFlow** method by SDK.

As a response, you get a new rule flow model with newly generated compositionId, baseId, and version.

More information about the HTTP POST method can be found here: **** [#create-rule-flow](../api/management-api.md#create-rule-flow "mention")****

## **Create a new separate rule flow version**

![](<../.gitbook/assets/new\_version\_ruleflow (1) (1).png>)

### Getting a rule flow model from a source environment

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/{ruleFlowId}/{?version}** or with **getRuleFlow** method by SDK.

Another option is to get the rule flow model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule flow with ruleFlowId and version as a response.

More information about the HTTP GET method can be found here: [#get-rule-flow](../api/management-api.md#get-rule-flow "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### **Modify rule flow model**

After you get the current rule model you have to modify it. You have to change compositionId, baseId to a compositionId which version you want to a create. Next, you have to change the version to a new version that you want.

### Create a new rule flow version for a target environment

After you modify the rule flow model, you can create it in the target environment by HTTP POST method with path **/api/rule-flow** or with **createRuleFlow** method by SDK.

As a response, you get a new rule flow model with newly generated compositionId, baseId, and version.

More information about the HTTP POST method can be found here: **** [#create-rule-flow](../api/management-api.md#create-rule-flow "mention")****

## Update separate rule flow

![](../.gitbook/assets/update\_ruleflow.png)

### Getting a rule flow model from a source environment

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/{ruleFlowId}/{?version}** or with **getRuleFlow** method by SDK.

Another option is to get the rule flow model using a tag. The HTTP GET method **/api/tags/items** or **getRulesByTags** method by SDK is used for this purpose.

You get a current model of the specified rule flow with ruleFlowId and version as a response.

More information about the HTTP GET method can be found here: [#get-rule-flow](../api/management-api.md#get-rule-flow "mention")

More information about the HTTP GET tag methods can be found here: [#get-rules-rule-flows-by-tags](../api/management-api.md#get-rules-rule-flows-by-tags "mention")

### **Update rule flow with the specific version on the target environment**

You can create it in the target environment by HTTP PUT method with path **/api/rule-flow/{compositionId}/{?version}** or with **updateRule** method by SDK. ****&#x20;

As a response, you get a updated rule flow model.

More information about the HTTP PUT method can be found here: [#update-rule-flow](../api/management-api.md#update-rule-flow "mention")

## **Create a rule flow with rules**

![](../.gitbook/assets/create\_whole\_ruleflow.png)

### **Getting a rule flow model  with rules from a source environment**

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/export/{ruleFlowId}/{?version}** or with **exportRuleFlow** method by SDK.

You get a current model of the specified rule flow with all rules as a response.

More information about the HTTP GET method can be found here: **** [#export-rule-flow-with-all-rules](../api/management-api.md#export-rule-flow-with-all-rules "mention")****

### **Create a new rule flow with rules for a target environment**

You can create it in the target environment by HTTP POST method with path **/api/rule-flow/import** or with **importRuleFlow** method by SDK.

As a response, you get a new rule flow model with all rules.

More information about the HTTP POST method can be found here: **** [#import-rule-flow-with-all-rules](../api/management-api.md#import-rule-flow-with-all-rules "mention")****

## **Create a new rule flow version with rules**

![](../.gitbook/assets/new\_version\_whole\_ruleflow.png)

### Getting a rule flow model with rules from a source environment

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/export/{ruleFlowId}/{?version}** or with **exportRuleFlow** method by SDK.

You get a current model of the specified rule flow with all rules as a response.

More information about the HTTP GET method can be found here: **** [#export-rule-flow-with-all-rules](../api/management-api.md#export-rule-flow-with-all-rules "mention")****

### Create a new rule flow version with rules for a target environment

You can create it in the target environment by HTTP POST method with path **/api/rule-flow/import** or with **importRuleFlow** method by SDK. You have to call this method with the parameter **new-version** with a value of **compositionId** which new version you want to create.

As a response, you get a new rule flow model with all rules.

More information about the HTTP POST method can be found here: **** [#import-rule-flow-with-all-rules](../api/management-api.md#import-rule-flow-with-all-rules "mention")****

## **Update rule flow with rules**

![](../.gitbook/assets/update\_whole\_ruleflow.png)

### Getting a rule flow model with rules from a source environment

You can get your current rule flow model by HTTP GET method with path **/api/rule-flow/export/{ruleFlowId}/{?version}** or with **exportRuleFlow** method by SDK.

You get a current model of the specified rule flow with all rules as a response.

More information about the HTTP GET method can be found here: **** [#export-rule-flow-with-all-rules](../api/management-api.md#export-rule-flow-with-all-rules "mention")****

### Update a rule flow with rules for a target environment

After you modify the rule flow model, you can create it in the target environment by HTTP POST method with path **/api/rule-flow/import** or with i**mportRuleFlow** method by SDK. You have to call this method with the parameter **overwrite** with a value of **compositionId** and parameter **version** with **the value of the version** which rule flow you want to update.

As a response, you get a updated rule flow model with all rules.

More information about the HTTP POST method can be found here: **** [#import-rule-flow-with-all-rules](../api/management-api.md#import-rule-flow-with-all-rules "mention")****
