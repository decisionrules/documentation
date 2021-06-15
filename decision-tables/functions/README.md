# List of Functions

### Intro

A list of functions is a feature that can be used in the [Decision Tables ](../decision-table-designer.md)to create functions both in input and output.

![](../../.gitbook/assets/image%20%28136%29.png)

There are 4 types of functions in the list that can be used in the Decision Tables:

| [**Math**](math.md)\*\*\*\* | [**Logical**](logical.md)\*\*\*\* | [**Date and Time**](date-and-time.md)\*\*\*\* | [**Text**](text.md)\*\*\*\* |
| :---: | :---: | :---: | :---: |
| SUM | EQUAL | NOW | UPPERCASE |
| MIN | GREATER | CURDATE | LOWER\_CASE |
| MAX | GREATER\_EQUAL | CURTIME | REPLACE |
| AVG | LESS | DATE | LEN |
| COUNT | LESS\_EQUAL | DATEDIFF | CONCAT |
| MEDIAN | NOT\_EQUAL | DATE\_COMPUTE | CONCAT\_WS  |
| CEILING | BETWEEN |  |  |
| FLOOR | AND |  |  |
| ROUND | OR |  |  |
|  | REGEXP |  |  |

{% hint style="success" %}
Each function can be **embedded** by the logical structure. Such as:

ROUND\(SUM\(1,2\)\)

MEDIAN\(AVG\(1,2,3\), MIN\(4,5\)\)

OR\(EQ\(10,10\),EQ\(10,15\)\)

AND\(EQ\(10,SUM\(7,3\)\),LT\(10,MAX\(5,20\)\)\)
{% endhint %}

{% hint style="warning" %}
Attributes from the input or output model can also be used as parameters in the functions in the following format:

{**ATTRIBUTE**} --&gt; the attribute always must be in {}
{% endhint %}

### Condition \(input\)

{% hint style="danger" %}
The condition \(input\) can only have functions returning **BOOLEAN** values TRUE or FALSE.

Therefore always the input must start with one of the [**LOGICAL** ](logical.md)functions, then there can be the other functions embedded in it.
{% endhint %}

![Example of how the input must be.](../../.gitbook/assets/image%20%28134%29.png)

After the execution of the row, the test bench condition is not shown in the test bench as input but in the **CONSOLE** if the debug mode is on. See an example below:

This is how the test bench looks like:

![](../../.gitbook/assets/image%20%28133%29.png)

This is shown in the console:

![](../../.gitbook/assets/image%20%28132%29.png)

### Result \(output\)

{% hint style="success" %}
The result \(output\) can be any data type to return. All the functions can be used without any exception.
{% endhint %}

![Example of how the output can look like.](../../.gitbook/assets/rsz_1%20%281%29.png)

