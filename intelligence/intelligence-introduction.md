# Intelligence Introduction

The Intelligence section helps you monitor, inspect, and analyze rule executions using audit logs. It gives you access to both individual execution records and aggregated statistics, so you can understand how your rules are used, what results they produce, and where potential issues may occur.

## Enable or disable audit logging

Audit log creation can be enabled or disabled in **Rule Settings**, which are available from the left menu in the Designer tab of each rule.

<figure><img src="../.gitbook/assets/Screenshot 2026-07-09 at 13.02.59 (1).png" alt=""><figcaption></figcaption></figure>

When Audit Logging is turned on, executions of the rule are stored as audit logs and can be reviewed later in the Intelligence section. When it is turned off, new executions of the rule are not saved as audit logs.

You can also configure related audit log settings here:

* Debug Data&#x20;
* Propagate Audit to children
* Audit Lifespan

{% hint style="info" %}
### **Propagate Audit to children**

This option allows audit logging to be applied automatically to rules that are executed as part of a rule chain.

This means you do not need to enable audit logging separately for every rule that may be called by another rule, such as a rule executed from a Business Rule node in a Decision Flow or a rule solved from code in a Scripting Rule.

If audit logging is enabled both through propagation and directly on an individual child rule, the execution may be logged twice: once from the parent rule propagation and once from the child rule’s own audit logging settings.
{% endhint %}
