# Logical Functions

## List of logical functions

* [EQ](logical.md#equal-eq)
* [NE](logical.md#not-equal-ne)
* [GT](logical.md#greater-than-gt)
* [GTE](logical.md#greater-than-or-equal-gte)
* [LT](logical.md#less-than-lt)
* [LTE](logical.md#less-than-or-equal-lte)
* [BTW](logical.md#between-btw)
* [NOT\_BTW](logical.md#not-between-not_btw)
* [BTW\_LEF&#x54;_\__&#x4F;PEN](logical.md#between-left-open-btw_left_open)
* [BTW\_RIGH&#x54;_\__&#x4F;PEN](logical.md#between-right-open-btw_right_open)
* [AND](logical.md#and-and)
* [OR](logical.md#or-or)
* [IS\_NULL](logical.md#is-null-is_null)
* [IS\_NOT\_NULL](logical.md#is-not-null-is_not_null)
* [IF](logical.md#condition-if)
* [NOT](logical.md#negation-not)

{% hint style="info" %}
The return value of logical functions is always boolean, i.e., true or false, with the exception of IF.
{% endhint %}

#### Deprecated functions

* [REGEXP](logical.md#regular-expression-regexp-deprecated)

### Equal (EQ)

Returns `true` if two values are equal to each other, or `false` otherwise.

* Takes 2 arguments.

```javascript
input1 = 3
input2 = [1,3]

[function] --> [output]

EQ(10,10)                     --> true
EQ(10,15)                     --> false
EQ(10,"10")                   --> true
EQ(10,"aa")                   --> false
EQ({input1},3)                --> true
EQ("a","a")                   --> true
EQ([1,3],{input2})            --> true
EQ({"price":10},{"price":11}) --> false

EQ(10)                        --> invalid

```

### Not equal (NE)

Returns `true` if the first value is not equal to the second value.

* Takes 2 arguments.

```javascript
input = 2

[function] --> [output]

NE(10,20)         --> true
NE({input},3)     --> true
NE(20,10)         --> true
NE("a","b")       --> true
NE(20,20)         --> false

NE("a")           --> invalid
```

### Greater than (GT)

Returns `true` if the first value is greater than the second value, or `false` otherwise.

* Takes 2 arguments.
* Both arguments have to be numbers, variables or strings.
* When used with strings, it returns `true` or `false` based on their alphabetical order.

```javascript
input = 4

[function] --> [output]

GT(20,10)         --> true
GT(20,20)         --> false
GT({input},3)     --> true
GT("a","a")       --> false
GT("b","a")       --> true

GT(15)            --> invalid
```

### Greater than or equal (GTE)

Returns `true` if the first value is greater than or equal to the second value, or `false` otherwise.

* Takes 2 arguments.
* Both arguments have to be numbers, variables or strings.
* When used with strings, it returns `true` or `false` based on their alphabetical order.

```javascript
input = 4

[function] --> [output]

GTE(20,10)         --> true
GTE(20,20)         --> true
GTE({input},3)     --> true
GTE("a","a")       --> true
GTE("b","a")       --> true

GTE(15)            --> invalid
```

### Less than (LT)

Returns `true` if the first value is lower than the second value.

* Takes 2 arguments.
* Both arguments have to be numbers, variables or strings.
* When used with strings, it returns `true` or `false` based on their alphabetical order.

```javascript
input = 4

[function] --> [output]

LT(10,20)         --> true
LT(10,10)         --> false
LT(3,{input})     --> true
LT("a","a")       --> false
LT("a","b")       --> true

LT(15)            --> invalid
```

### Less than or equal (LTE)

Returns `true` if the first value is less than or equal to the second value.

* Takes 2 arguments.
* Both arguments have to be numbers, variables or strings.
* When used with strings, it returns `true` or `false` based on their alphabetical order.

```javascript
input = 4

[function] --> [output]

LTE(10,20)         --> true
LTE(20,20)         --> true
LTE(3,{input})     --> true
LTE("a","a")       --> true
LTE("a","b")       --> true

LTE(15)            --> invalid
```

### Between (BTW)

Returns `true` if the second value is between the first and the third value, meaning in particular that first argument ≤ second argument ≤ third argument.

* Takes 3 arguments.

```javascript
input = 12

[function] --> [output]

BTW(10,15,20)         --> true
BTW(10,10,20)         --> true
BTW(10,{input},20)    --> true
BTW("a","f","z")      --> true
BTW(10,8,20)          --> false
BTW(20,10,15)         --> false

BTW(20,10)            --> invalid
```

### Not between (NOT\_BTW)

Returns `true` if the second value is between the first and the third value, meaning in particular that first argument < second argument or second argument > third argument.

* Takes 3 arguments.

### Between left open (BTW\_LEFT\_OPEN)

Returns `true` if the second value is between the first (excluding) and the third (including) value, meaning in particular that first argument < second argument ≤ third argument.

* Takes 3 arguments.

### Between right open (BTW\_RIGHT\_OPEN)

Returns `true` if the second value is between the first (including) and the third (excluding) value, meaning in particular that first argument ≤ second argument < third argument.

* Takes 3 arguments.

### And (AND)

Returns `true` if all of its arguments evaluate to `true`.

* Must have at least 1 argument.
* Arguments have to be booleans, numbers or variables.
* If the argument is a number, 0 is evaluated as `false` and anything else as `true`.
* Alternatively, OR can take an array of values in any argument.

```javascript
input = true

[function] --> [output]

AND(true,EQ(10,10))         --> true
AND(LT(10,10),GTE(10,10))   --> false
AND(true,EQ(10,20))         --> false
AND(true, {input}, false)   --> false
AND([true,true,true])       --> true
AND(1,true)                 --> true

AND("a","b")                --> invalid
```

### Or (OR)

Returns `true` if at least one of its arguments evaluates to `true`.

* Must have at least 1 argument.
* Arguments have to be booleans, numbers or variables.
* If the argument is a number, 0 is evaluated as `false` and anything else as `true`.
* Alternatively, OR can take an array of values in any argument.

```javascript
input = true

[function] --> [output]

OR(false,EQ(10,10))        --> true
OR(LT(10,10),GTE(10,10))   --> true
OR(false,EQ(10,20))        --> false
OR(false, false, {input})  --> true
OR([true,false,false])     --> true
OR(1,true)                 --> true

OR("a","b")                --> invalid
```

### Is null (IS\_NULL)

Returns `true` if the value is null (empty).

* Must have 1 argument.

```javascript
input1 = {}
input2 = null
input3 = "null"
input4 = "abc"
input5 = 3

[function] --> [output]

IS_NULL(input1)   --> true
IS_NULL(input2)   --> true
IS_NULL(input3)   --> true
IS_NULL(input4)   --> false
IS_NULL(input5)   --> false

IS_NULL("abc")    --> false
IS_NULL(3)        --> false
```

### Is not null (IS\_NOT\_NULL)

Returns `true` if the value is not null (empty).

* Must have 1 argument.

```javascript
input1 = {}
input2 = null
input3 = "null"
input4 = "abc"
input5 = 3

[function] --> [output]

IS_NOT_NULL(input1)   --> false
IS_NOT_NULL(input2)   --> false
IS_NOT_NULL(input3)   --> false
IS_NOT_NULL(input4)   --> true
IS_NOT_NULL(input5)   --> true

IS_NOT_NULL("abc")    --> true
IS_NOT_NULL(3)        --> true
```

### Negation (NOT)

Returns the opposite of a boolean value.

* Must have 1 argument.

```javascript
input = false

[function] --> [output]

NOT(true)          --> false
NOT({input})       --> true
NOT(LT(1,4))       --> false
NOT(EQ(256,256))   --> false
```

### Condition (IF)

Returns the second argument if the first argument is `true`, otherwise returns the third argument.

* Must have 3 arguments.
* The first argument is a condition. The condition must be of the boolean type (`true`/`false`).
* The second argument is an arbitrary value.&#x20;
* The third argument is an arbitrary value.

```javascript
input = false
number = 8

[function] --> [output]

IF(true,"Input truthy","Input falsy")       --> "Input truthy"
IF({input},"Input truthy","Input falsy")    --> "Input falsy"
IF(LT(0,{number}),"Positive","Negative")    --> "Positive"
```



### Regular expression (REGEXP) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use TEST instead (see [Text Functions](text.md)).
{% endhint %}

Returns `true` if the first argument matches against a regular expression in the second argument.

* Must have 2 arguments.
* Arguments have to be numbers, strings or variables.

```javascript
input = hello

[function] --> [output]

REGEXP("abc","bc")       --> true
REGEXP(12233,23)         --> true
REGEXP({input},"lo")     --> true
REGEXP("xxx","yy")       --> false
REGEXP("hello","ho")     --> false

REGEXP("bye")            --> invalid
```

