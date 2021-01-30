---
description: Description of all operators used in decision tables
---

# Operators

## Information

Every condition cell in [decision table](decision-table-designer.md) can have a different operator.

![](../.gitbook/assets/image%20%288%29.png)

## Equals Operator \(=\)

Compares two scalar values. The equal operator compares mainly:

* String
* Number
* Boolean

#### Equal Operator examples:

```javascript
[request value] = [table value]
3 = 3             //true
"3" = "3"         //true
"3" = 3           //false
true = true       //true
```

## IS IN Operator \(IN\)

The IS IN operator \( ****`in` \) returns `true` if the right operand contains the left operand, and `false` otherwise. 

* The right operand has to be ****an **array `[]`**
* The input string value is **not converted** from string to number

#### IS IN Operator examples:

```javascript
[request value] IN [table value]
3 IN [1, 2, 3]            //true
4 IN [1, 2, 3]            //false
"a" IN ["a", "b", "c"]    //true
"d" IN ["a", "b", "c"]    //false
"3" IN [1, 2, 3]          //false
3 IN ["1", "2", "3"]      //false
```

## NOT IN Operator \(NOT IN\)

The NOT IN operator \( ****`not in` \) returns `true` if the right operand does not contain the left operand, and `false` otherwise. 

* The right operand has to be ****an **array `[]`**
* The input string value is **not converted** from string to number

#### NOT IN Operator examples:

```javascript
[request value] NOT IN [table value]
3 NOT IN [1, 2, 3]            //false
4 NOT IN [1, 2, 3]            //true
"a" NOT IN ["a", "b", "c"]    //false
"d" NOT IN ["a", "b", "c"]    //true
"3" NOT IN [1, 2, 3]          //true
3 NOT IN ["1", "2", "3"]      //true
```

## Higher OR Equal Operator \(&gt;=\)

The higher or equal operator \(`>=`\) returns `true` if the left operand is greater than or equal to the right operand, and `false` otherwise.

* Numbers can be decimal or integer
* The input string value is **not converted** from string to number
  * String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Greater_than_or_equal). 
* Boolean values are compared as number values
  * `true = 1`
  * `false = 0`

#### Higher OR Equal Operator examples:

```javascript
[request value] >= [table value]
5 >= 3              // true
3.1 >= 2.1          // true
"b" >= "a"          // true
"a" >= "a"          //true
true >= true        // true
true >= false       // true
```

## Higher Operator \(&gt;\)

The higher operator \(`>`\) returns `true` if the left operand is greater than the right operand, and `false` otherwise.

* Numbers can be decimal or integer
* The input string value is **not converted** from string to number
  * String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Greater_than). 
* Boolean values are compared as number values
  * `true = 1`
  * `false = 0`

#### Higher Operator examples:

```javascript
[request value] > [table value]
5 > 3              // true
3.1 > 2.1          // true
"b" > "a"          // true
true > true        // false
true > false       // true

```

## Lower OR Equal Operator \(&lt;=\)

The lower or equal operator \(`<=`\) returns `true` if the left operand is less than or equal to the right operand, and `false` otherwise.

* Numbers can be decimal or integer
* The input string value is **not converted** from string to number
  * String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Less_than_or_equal). 
* Boolean values are compared as number values
  * `true = 1`
  * `false = 0`

#### Lower OR Equal Operator examples:

```javascript
[request value] <= [table value]
3 <= 5              // true
3 <= 3              // true
2.1 <= 3.1          // true
"a" <= "a"          // true
"a" <= "b"          // true
true <= true        // true
false <= true       // true

```

## Lower Operator \(&lt;\)

The lower operator \(`<`\) returns `true` if the left operand is less than the right operand, and `false` otherwise.

* Numbers can be decimal or integer
* The input string value is **not converted** from string to number
  * String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Less_than). 
* Boolean values are compared as number values
  * `true = 1`
  * `false = 0`

#### Lower Operator examples:

```javascript
[request value] < [table value]
3 < 5              // true
2.1 < 3.1          // true
"a" < "b"          // true
true < true        // false
false < true       // true

```



## Not Equal Operator \(&lt;&gt;\)

Compares two scalar values. The not equal operator compares mainly:

* String
* Number
* Boolean

#### Not Equal Operator examples:

```javascript
[request value] <> [table value]
3 <> 3             //false
"3" <> "3"         //false
"3" <> 3           //true
true <> false      //true
```

## Anything Operator \(anything\)

The anything operator \(anything\) returns  `true` always.

## Contains Text Operator \(containsText\)

The contains text operator \(`containsText`\) returns `true` if the left operand contains in the right operand, and `false` otherwise.

* The left operand can be Number, String, or Boolean.
* The right operand has to be String

#### Contains Text Operator examples:

```javascript
[request value] containsText [table value]
1 containsText "This is example 1 with true."        //true
"1" containsText "This is example 1 with true."      //true
"is" containsText "This is example 1 with true."     //true
true containsText "This is example 1 with true."     //true
"test" containsText "This is example 1 with true."   //false
```



