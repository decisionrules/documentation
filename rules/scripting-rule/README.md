# Scripting Rule

## Introduction <a href="#introduction" id="introduction"></a>

Scripting Rule is another type of rule that you can use in DecisionRules to create your rules and conditions. However, it differs fundamentally from the others in that it does not have a graphical editor, it uses the _Monaco code editor_ instead.

Just like the other rules, it has a unified Rule Settings form that is the same across all rule types.

So when you are creating a rule, the procedure is exactly the same, first, you create an input and output structure in Rule Settings. You can also create your own [Rule Variables](https://docs.decisionrules.io/doc/other/rule-variables).

Next, you move to the Scripting Rule Designer and create the rule and all the logic using JavaScript.

The Scripting Rule Designer uses the standard and well-known _Monaco editor_ from _VS Code_ to help the user with code creation and editing. Of course, it also includes all the Functions and Operators that are available in Decision Table or Decision Tree.

_Below you can find example file with Scripting Rule. This rule contains a function that return random number from given range._

{% file src="../../.gitbook/assets/RandomNumber.json" %}
Scripting rule example
{% endfile %}

{% hint style="info" %}
_What is important to note is that you should always have “return output;” in the last line of your Scripting rule._
{% endhint %}

## Intended Users and Use of the Scripting Rule <a href="#intended-users-and-use-of-the-scripting-rule" id="intended-users-and-use-of-the-scripting-rule"></a>

Although DecisionRules is a No-code & Low-code solution, in some cases it is useful to take advantage of the flexibility that using the code offers. In particular the ability to create your own function or copy it from already created code. Using Scripting Rule is mainly meant for Developers, Analysts or anyone who is capable and willing to use JavaScript.

One of the most popular use cases is when a developer creates a generic script that processes data. This script then changes very little, because all the parameterization of that script happens in the Decision Table or Decision Tree, where it is already being modified by people from the business or product teams.

### **Rule Orchestration**

Although Rule Flow was primarily intended for rule orchestration, with using Scripting Rule for rule orchestration, it is possible to enrich such orchestration with custom and more advanced features. An example of orchestration using Scripting Rule is the use of the [DR.solve function](https://docs.decisionrules.io/doc/scripting-rules/call-embedded-rules-in-sr), which calls the required rules from code and can further manipulate the data that such rules return as output.

## GitHub <a href="#github" id="github"></a>

The Scripting Rule, like other rules in DecisionRules, has its own versioning and change history. But what you can do more in the case of Scripting Rule is to use GitHub. Thanks to [the Management API](https://docs.decisionrules.io/doc/api/management-api), you can connect your GitHub to DecisionRules and use GitHub to manage code edits, versioning and merging of unique versions.

_Whenever you make a change to a rule, save it with the Save button._

## Summary <a href="#summary" id="summary"></a>

Thanks to Scripting Rules, DecisionRules can have the Best of Both Worlds.

The sheer flexibility offered by the code and the user-friendly interface of Decision Table or Decision Tree that can easily be used by a non-technical person. The key is to use the [solve function](https://docs.decisionrules.io/doc/scripting-rules/call-embedded-rules-in-sr). Where Scripting Rule takes care of advanced data manipulation and uses the solve function to parameterize the Decision Table or Scripting Rule.

Scripting Rule allows you to create custom functions, make advanced data manipulation, aggregations, iterations. You can also very easily copy functions and code that you have already created in JavaScript.

In the following sections you can find more details about Scripting rule features.

{% content-ref url="custom-functions-in-scripting-rules.md" %}
[custom-functions-in-scripting-rules.md](custom-functions-in-scripting-rules.md)
{% endcontent-ref %}

{% content-ref url="calling-external-api-within-scriptingrules.md" %}
[calling-external-api-within-scriptingrules.md](calling-external-api-within-scriptingrules.md)
{% endcontent-ref %}

{% content-ref url="use-rule-variables-in-scripting-rules.md" %}
[use-rule-variables-in-scripting-rules.md](use-rule-variables-in-scripting-rules.md)
{% endcontent-ref %}

{% content-ref url="call-embedded-rules-in-sr.md" %}
[call-embedded-rules-in-sr.md](call-embedded-rules-in-sr.md)
{% endcontent-ref %}

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

{% content-ref url="tips.md" %}
[tips.md](tips.md)
{% endcontent-ref %}
