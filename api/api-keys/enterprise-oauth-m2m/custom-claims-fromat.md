# Custom Claims Fromat

### Creating the Custom Scope Claim for DecisionRules Solver API

To correctly set up the **OAuth M2M flow**, the Access Token must contain a custom scope claim that specifically identifies the organization, space, and target API (Solver) the client is authorized to access.

This claim ensures the token is restricted and valid only for the intended resources within your DecisionRules instance.

{% hint style="success" %}
First OAuth setup is done with the deployment with **DecisionRules Engineers.**&#x20;
{% endhint %}

#### Custom Scope Format

The required format for the custom scope claim is a colon-separated string that must start with `decisionrules`.

**The structure is as follows:**

$$\text{decisionrules}:\text{orgid}:\langle\text{Organization ID}\rangle:\text{spaceid}:\langle\text{Space ID}\rangle:\langle\text{scope}\rangle$$

**example:**

`decisionrules:orgid:12b057b4-865b-4545-81c4-8899d1da3537:spaceid:8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6:solver`

| **Component**       | **Description**                                                | **Example Value**                                                          |
| ------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------- |
| `decisionrules`     | Mandatory prefix indicating the target service.                | `decisionrules`                                                            |
| `orgid`             | Fixed identifier for the Organization ID key.                  | `orgid`                                                                    |
| `<Organization ID>` | The unique identifier of your DecisionRules Organization.      | `12b057b4-865b-4545-81c4-8899d1da3537`                                     |
| `spaceid`           | Fixed identifier for the Space ID key.                         | `spaceid`                                                                  |
| `<Space ID>`        | The unique identifier of the Space within the Organization.    | `8ba6bac9-08a8-e648-8a2c-0b3992a9b4d6`                                     |
| `scope`             | The specific API resource scope you are authorizing access to. | <p>Currently only supported scope is <code>solver</code> </p><p>      </p> |
|                     |                                                                |                                                                            |
