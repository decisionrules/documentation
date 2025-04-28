---
description: Description of general operators used in decision tables
---

# Basic operators

## List of Basic Operators

Each condition cell in the decision table allows you to select a different operator. Below is an example of some available basic operators:

![Basic operators modal](<../../../.gitbook/assets/operators (1).png>)

{% hint style="danger" %}
Input values (left operands) are **auto-casted** to the necessary data type, and right-side operands are **also auto-casted**. No quotes are needed in table values.
{% endhint %}

### Equals (`=`)

Compares scalar values like strings, numbers, and booleans.

<pre class="language-javascript"><code class="lang-javascript"><strong>// [request value] = [table value]
</strong><strong>
</strong><strong>3 = 3                 // true
</strong>"3" = 3               // true
true = true           // true
"true" = true         // true
</code></pre>

### Anything (`ANY`)

The **Anything** operator is the simplest operator available in decision tables. It always returns `true`, regardless of the input. This operator is typically used in cases where a condition needs to pass for every possible input value, or where the specific value is irrelevant to the rule’s outcome.

The Anything operator does not perform any comparison; it simply returns `true` for any input.

{% hint style="success" %}
The operator is useful in scenarios where you want a rule to be triggered without considering the specific content of the condition.
{% endhint %}

### Is in (`IN`)

Returns `true` if the left operand is in the right operand's set, which must be an array. Members of the set can be separated by **pipe** (`|`), **comma** (`,`), **semicolon** (`;`)

```javascript
// [request value] IN [table value]

3     IN 1|2|3             // true
"a"   IN "a"|"b"|"c"       // true
"3"   IN 1|2|3             // true
"la"  IN "la-la"|"blah"    // false
```

{% hint style="warning" %}
Only exact matches.
{% endhint %}

### Not in  (`!IN`)

Returns `true` if the left operand is **not** in the right operand's set. Members of the set can be separated by **pipe** (`|`), **comma** (`,`), **semicolon** (`;`)

```javascript
// [request value] NOT IN [table value]

3   NOT IN 1|2|3              //false
4   NOT IN 1|2|3              //true
"a" NOT IN "a"|"b"|"c"        //false
"d" NOT IN "a"|"b"|"c"        //true
"3" NOT IN 1|2|3              //false
```

### Greater than or equal (`>=`)

Compares numbers or strings; returns `true` if the left operand is greater than or equal to the right operand.

* Numbers can be decimal or integer.
* String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Greater_than_or_equal).

```javascript
// [request value] >= [table value]

5 >= 3              // true
3.1 >= 2.1          // true
"b" >= "a"          // true
"a" >= "a"          // true
true >= true        // true
true >= false       // true
```

### Greater than (`>`)

Returns `true` if the left operand is greater than the right operand.

* Numbers can be decimal or integer.
* String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Greater_than).

```javascript
// [request value] > [table value]

5 > 3              // true
5 > 5              // false
3.1 > 2.1          // true
"b" > "a"          // true
true > true        // false
true > false       // true
```

### Less than or equal (`<=`)

Returns `true` if the left operand is less than or equal to the right operand.

* Numbers can be decimal or integer.
* String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Less_than_or_equal).

```javascript
// [request value] <= [table value]

3 <= 5              // true
3 <= 3              // true
2.1 <= 3.1          // true
"a" <= "a"          // true
"a" <= "b"          // true
true <= true        // true
false <= true       // true
```

### Less than (`<`)

Returns `true` if the left operand is less than the right operand.

* Numbers can be decimal or integer.
* String comparison is [similar to JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Less_than).

```javascript
// [request value] < [table value]

3 < 5              // true
3 < 3              // false
2.1 < 3.1          // true
"a" < "b"          // true
true < true        // false
false < true       // true
```

### Not equal (`!=`)

Compares scalar values and returns `true` if they are not equal.

```javascript
// [request value] != [table value]

3    != 3           //false
"3"  != 3           //false
3    != 4           //true
true != false       //true
```

### **Between** (`BTW`)

Returns `true` if the left operand is between or equal to the two values specified in the right operand, which must be an array of two values. This operator can be used to compare **Numbers**, **Strings**, or **Booleans**.

* The operator evaluates whether the left operand falls within the inclusive range defined by the two values in the right operand array.

```javascript
// [request value] BTW [table value 1 AND table value 2]

4     BTW [3 AND 5]            // true
3     BTW [3 AND 5]            // true
4.0   BTW [3.0 AND 5.5]        // true
3.5   BTW [3.0 AND 5.5]        // true
"b"   BTW ["a" AND "c"]        // true
"a"   BTW ["a" AND "c"]        // true
true  BTW [true AND false]     // false
true  BTW [true AND true]      // true
```

{% hint style="warning" %}
The left operand can be a number, string, or boolean, and the right operand must be an array of two values.
{% endhint %}

### Between left open (`BTW LO`)

Returns `true` if the left operand falls within the range defined by two values in the right operand, **excluding** the lower limit (left value) and **including** the upper limit (right value). If the left operand is equal to the lower limit, the result will be `false`.

```javascript
// [request value] BTW LO [table value 1 AND table value 2]

4     BTW LO [3 AND 5]           // true
3     BTW LO [3 AND 5]           // false
5.5   BTW LO [3.0 AND 5.5]       // true
3.0   BTW LO [3.0 AND 5.5]       // false
"b"   BTW LO ["a" AND "c"]       // true
"a"   BTW LO ["a" AND "c"]       // false
true  BTW LO [false AND true]    // true
false BTW LO [false AND true]    // false
```

{% hint style="warning" %}
The left operand can be a number, string, or boolean, and the right operand must be an array of two values.
{% endhint %}

### Between right open (`BTW RO`)

Returns `true` if the left operand falls within the range defined by two values in the right operand, **including** the lower limit (left value) and **excluding** the upper limit (right value). If the left operand is equal to the upper limit, the result will be `false`.

```javascript
// [request value] BTW RO [table value 1 AND table value 2]

4      BTW RO [3 AND 5]          // true
5      BTW RO [3 AND 5]          // false
3.0    BTW RO [3.0 AND 5.5]      // true
5.5    BTW RO [3.0 AND 5.5]      // false
"b"    BTW RO ["a" AND "c"]      // true
"c"    BTW RO ["a" AND "c"]      // false
true   BTW RO [false AND true]   // false
false  BTW RO [false AND true]   // true
```

{% hint style="warning" %}
The left operand can be a number, string, or boolean, and the right operand must be an array of two values.
{% endhint %}

### Not between (`!BTW`)

Returns `true` if the left operand does **not** fall within the range defined by two values in the right operand. This operator effectively checks if the left operand is outside the specified interval.

```javascript
// [request value] !BTW [table value 1 AND table value 2]

4     !BTW [3 AND 5]         // false
2     !BTW [3 AND 5]         // true
"b"   !BTW ["a" AND "c"]     // false
"d"   !BTW ["a" AND "c"]     // true
true  !BTW [false AND true]  // false
false !BTW [false AND true]  // false
```

{% hint style="warning" %}
The left operand can be a number, string, or boolean, while the right operand must be an array containing two values.
{% endhint %}

### Is null (`NULL`)

Returns `true` if the value being evaluated is empty. It does not accept any specific table values for comparison.

{% hint style="info" %}
The request value is checked against various types of empty values.
{% endhint %}

```javascript
// [request value] NULL [table value is empty]

null    NULL           // true
{}      NULL           // true
[]      NULL           // true
"a"     NULL           // false
3       NULL           // false
""      NULL           // false
0       NULL           // false
```

{% hint style="success" %}
This operator is useful for validating whether a value has been provided or is absent.
{% endhint %}

### Is not null (`!NULL`)

Returns `true` if the value being evaluated is not empty. It does not accept any specific table values for comparison.

{% hint style="info" %}
The request value is assessed to determine if it holds any non-empty data.
{% endhint %}

```javascript
// [request value] !NULL [table value is empty]

"a"      !NULL          //true
3        !NULL          //true
""       !NULL          //true
null     !NULL          //false
{}       !NULL          //false
[]       !NULL          //false
```

{% hint style="success" %}
This operator is useful for confirming that a value has been provided or exists in the dataset.
{% endhint %}

### Contains text (`C TXT`)

The operator checks if the left operand includes a value specified in the right operand, returning `true` if a match is found and `false` otherwise.

{% hint style="info" %}
The operator matches not only exact values but also substrings.
{% endhint %}

* Members of the set can be separated by pipe (`|`), comma (`,`), or semicolon (`;`).
* The left operand can be of type Number, String, Boolean, or an Array containing these types.

```javascript
// [request value] C TXT [table value]

[1,2,3]                             C TXT "1"             //true
[11,2,3]                            C TXT "1"             //true
[2,3,4]                             C TXT "1"             //false
"This is example 1,2,3 with true."  C TXT "1,2,3"         //true
"This is example false or true."    C TXT "true or false" //false
"This is example true with false."  C TXT true            //true
```

{% hint style="success" %}
This operator is particularly useful for scenarios where partial matches or the presence of specific elements within a collection need to be identified.
{% endhint %}

### Contains in (`C IN`)

Returns `true` if any of the values in the right operand are present in the left operand. This operator checks for both exact matches and substrings, returning `false` if no match is found.

{% hint style="info" %}
The operator matches not only exact values but also substrings.
{% endhint %}

* Members of the set in the right operand can be separated by pipe (`|`), comma (`,`), or semicolon (`;`).
* The left operand can be a Number, String, Boolean, or an Array of these types.

```javascript
// [request value] C IN [table value]

"This is example 1 with true." C IN 1|2|3          //true
"This is example 1 with true." C IN 1|true|"ok"    //true
"This is example 1 with true." C IN "is"|2|true    //true
"This is example 1 with true." C IN true|3         //true
[1,2,3]                        C IN true|3         //true
["true or falseee", "haha"]    C IN true|false     //true
"This is example 1 with true." C IN "test"|2       //false
```

{% hint style="success" %}
This operator is effective for verifying the existence of one or more elements from a list within a string or array.
{% endhint %}

### Not contains in (`!C IN`)

Returns `true` if none of the elements in the right operand are present in the left operand. This operator checks both exact values and substrings, returning `false` if any match is found.

* Members of the set in the right operand can be separated by pipe (`|`), comma (`,`), or semicolon (`;`).
* The left operand can be a Number, String, Boolean, or an Array containing these types.
* It returns `true` only when there are no matches found.

```javascript
// [request value] !C IN [table value]

"This is example 1 with true." !C IN 2|3|4          //true
"This is example 1 with true." !C IN 2|false|"ok"   //true
"This is example 1 with true." !C IN "are"|2|false  //true
"This is example 1 with true." !C IN false|3        //true
[1,2,3]                        !C IN true|3         //false
["true or falseee", "haha"]    !C IN "hello"|"bye"  //true
"This is example 1 with true." !C IN "test"|1       //false
```

{% hint style="success" %}
This operator is useful when you want to confirm that none of a given set of elements is present in a string or array.
{% endhint %}

### Equal array (`EQ ARR`)

Returns `true` if all the values in the right operand are substrings of at least one of the values in the left operand. This operator checks for matches within the elements of the left operand array, ensuring that all specified values in the right operand appear as substrings.

* The right operand set can be separated by pipe (`|`), comma (`,`), or semicolon (`;`).
* The left operand must be an array `[]`.
* It returns `true` only when all the values in the right operand match a substring in the left operand.

```javascript
// [request value] EQ ARR [table value]

[1, 2, 3]     EQ ARR  1|2|3      //true
["a", "b"]    EQ ARR  "a"|"b"    //true
[1,2,3]       EQ ARR  1|2        //true
[1111,111]    EQ ARR  1|11|111   //true
[1,2,3,4,5]   EQ ARR  1|2|3|4|6  //false
```

{% hint style="success" %}
This operator is helpful when you want to ensure that a set of substrings is found across an array of values.
{% endhint %}

### Else (`ELSE`)

The **ELSE** operator is a unique operator in decision tables, which returns `true` when no preceding row has passed the evaluation. It acts independently of the input variable in its column and only evaluates the overall flow of the table rather than specific conditions.

**Key Points**:

* The ELSE operator triggers if no other rows have passed before it.
* There can only be one row with the ELSE operator that passes.
* When evaluated, it takes into account only the conditions above it in the table.

{% hint style="success" %}
The ELSE operator is primarily used to create a default or fallback row in decision tables. This row is triggered if no other conditions match, making it ideal for handling scenarios like generating error messages or returning default responses.
{% endhint %}
