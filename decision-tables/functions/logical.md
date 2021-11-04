# Logical operators

* EQUAL
* GREATER
* GREATER\_EQUAL
* LESS
* LESS\_EQUAL
* NOT\_EQUAL
* BETWEEN
* AND
* OR
* REGEXP
* IS\_NULL
* IS\_NOT_\__NULL

{% hint style="danger" %}
The return value of the LOGICAL operators is  always **BOOLEAN **(TRUE/FALSE)
{% endhint %}

### Equal operator (EQ - EQUAL)

The EQUAL operator returns TRUE if two values are equal to each other.

* Must have 2 parameters.
* EQ can be a part of an embedded function.
* Can be a number, text or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### EQ function examples:

```javascript
INPUT = 3
[function] --> [output]

EQ(10,10)         --> TRUE
EQ({INPUT,3})     --> TRUE
EQ(aa,aa)         --> TRUE
EQ("aa","aa")     --> TRUE
EQ(20,10)         --> FALSE
EQ(10,20)         --> FALSE
```

### Greater than operator (GT - GREATER)

The GREATER than operator returns TRUE if the first value is greater than the second value.

* Must have 2 parameters.
* GT can be a part of an embedded function.
* Can be a number, text or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### GT function examples:

```javascript
INPUT = 4
[function] --> [output]

GT(20,10)         --> TRUE
GT({INPUT,3})     --> TRUE
GT(tt,aa)         --> TRUE
GT("tt","aa")     --> TRUE
GT(10,20)         --> FALSE
GT(10,10)         --> FALSE
```

### Greater than or equal operator (GTE - GREATER\_EQUAL)

The GREATER\_EQUAL operator returns TRUE if the first value is greater than or equal to the second value.

* Must have 2 parameters.
* GTE can be a part of an embedded function.
* Can be a number, text, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### GTE function examples:

```javascript
INPUT = 4
[function] --> [output]

GTE(20,10)         --> TRUE
GTE({INPUT,3})     --> TRUE
GTE(tt,aa)         --> TRUE
GTE("tt","aa")     --> TRUE
GTE(20,20)         --> TRUE
GTE(10,20)         --> FALSE
```

### Less than operator (LT - LESS)

The LESS operator returns TRUE if the first value is lower than the second value.

* Must have 2 parameters.
* LT can be a part of an embedded function.
* Can be a number, text, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### LT function examples:

```javascript
INPUT = 2
[function] --> [output]

LT(10,20)         --> TRUE
LT({INPUT,3})     --> TRUE
LT(aa,tt)         --> TRUE
LT("aa","tt")     --> TRUE
LT(20,20)         --> FALSE
LT(20,10)         --> FALSE
```

### Less than or equal operator (LTE - LESS\_EQUAL)

the LESS\_EQUAL operator returns TRUE if the first value is less than or equal to the second value.

* Must have 2 parameters.
* LTE can be a part of an embedded function.
* Can be a number, text, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### LTE function examples:

```javascript
INPUT = 2
[function] --> [output]

LTE(10,20)         --> TRUE
LTE({INPUT,3})     --> TRUE
LTE(20,20)         --> TRUE
LTE(aa,tt)         --> TRUE
LTE("aa","tt")     --> TRUE
LTE(20,10)         --> FALSE
```

### Not equal operator (NE - NOT\_EQUAL)

The NOT\_EQUAL operator returns TRUE if the first value is not equal to the second operator.

* Must have 2 parameters.
* NE can be a part of an embedded function.
* Can be a number, text, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### NE function examples:

```javascript
INPUT = 2
[function] --> [output]

NE(10,20)         --> TRUE
NE({INPUT,3})     --> TRUE
NE(20,10)         --> TRUE
NE(aa,tt)         --> TRUE
NE("aa","tt")     --> TRUE
NE(20,20)         --> FALSE
```

### Between operator (BTW - BETWEEN)

The BETWEEN operator returns TRUE if the second value is between the first and the second value.

* Must have 3 parameters.

{% hint style="warning" %}
1. parameter - the lowest value
2. parameter - compared value
3. parameter - the highest value
{% endhint %}

* BTW can be a part of an embedded function.
* Can be a number, text, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### BTW function examples:

```javascript
INPUT = 12
[function] --> [output]

BTW(10,15,20)         --> TRUE
BTW(10,10,20)         --> TRUE
BTW(10,{INPUT},20)    --> TRUE
BTW(aa,ff,pp)         --> TRUE
BTW("aa","ff","pp")   --> TRUE
BTW(10,8,20)          --> FALSE
BTW(20,10,15)         --> FALSE
```

### And operator (AND)

The AND operator returns true if the first and second function is are true.

* Must have at least 2 parameters.
* AND can be a part of an embedded function.
* Must be a logical operator (EQ, LT, GTE, BTW,...) variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### AND function examples:

```javascript
INPUT = 12
[function] --> [output]

AND(QE(10,10),EQ(10,10))  --> TRUE
AND(LT(10,10),GTE(10,10)) --> FALSE
AND(QE(10,10),EQ(10,20))  --> FALSE
AND(10,20)                --> invalid
AND(xx, rr)               --> invalid
```

### Or operator (OR)

The OR operator returns true if at least one of the functions is true.

* Must have at least 2 parameters.
* OR can be a part of an embedded function.
* Must be a logical operator (EQ, LT, GTE, BTW,...) variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### OR function examples:

```javascript
INPUT = 12
[function] --> [output]

OR(QE(10,10),EQ(10,10))  --> TRUE
OR(LS(10,10),GTE(10,10)) --> TRUE
OR(QE(10,10),EQ(10,20))  --> FALSE
OR(10,20)                --> invalid
OR(xx, rr)               --> invalid
```

### Regular expression operator (REGEXP)

The REGEXP function is true if the first value match against a regular expression in the second value.

* Must have 2 parameters.
* REGEXP can be a part of an embedded function.
* Must be a number, string or an **INPUT **variable.
* Parameters can be separated by **comma **(,).
* The return value is **BOOLEAN**.

#### REGEXP function examples:

```javascript
INPUT = hello
[function] --> [output]

REGEXP(abc,bc)     --> TRUE
REGEXP(12233,23)   --> TRUE
REGEXP({INPUT},lo) --> TRUE
REGEXP(xxx, yy)    --> FALSE
REGEXP(hello, ho)  --> FALSE
REGEXP(bye)        --> invalid
```

### Is Null operator (IS\_NULL)

The Is Null operator returns true if the value is empty.

* Must have 1 parameter.
* IS\_NULL can be a part of an embedded function.
* Must be an **INPUT **variable.
* The return value is **BOOLEAN**.

```javascript
INPUT1 = {}
INPUT2 = null
INPUT3 = abc
INPUT4 = 3

[function] --> [output]

IS_NULL(INPUT1)   --> TRUE
IS_NULL(INPUT2)   --> TRUE
IS_NULL(INPUT3)   --> FALSE
IS_NULL(INPUT4)   --> FALSE
IS_NULL(a)        --> invalid
IS_NULL("a")      --> invalid
IS_NULL(3)        --> invalid

```



### Is Not Null operator (IS\_NOT\_NULL)

The Is Not Null operator returns true if the value is not empty.

* Must have 1 parameter.
* IS\_NOT\_NULL can be a part of an embedded function.
* Must be an **INPUT **variable.
* The return value is **BOOLEAN**.

```javascript
INPUT1 = {}
INPUT2 = null
INPUT3 = abc
INPUT4 = 3

[function] --> [output]

IS_NULL(INPUT3)   --> TRUE
IS_NULL(INPUT4)   --> TRUE
IS_NULL(INPUT1)   --> FALSE
IS_NULL(INPUT2)   --> FALSE
IS_NULL(a)        --> invalid
IS_NULL("a")      --> invalid
IS_NULL(3)        --> invalid
```
