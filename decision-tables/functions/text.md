# Text

## **TEXT** functions

* CONCAT
* CONCAT_WS
* LEN
* REPLACE
* UPPER_CASE
* LOWER_CASE

### Concatenation function (CONCAT)

The CONCAT function adds two or more strings together.

* Minimum 2 parameters.
* Any quantity of parameters.
* CONCAT can be a part of an embedded function.
* Must be a string, number, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).

{% hint style="warning" %}
The separator between the words is a **space**.
{% endhint %}

#### CONCAT function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

CONCAT("Hello", "World")              --> "Hello World"
CONCAT("Hello", "World", "Here")      --> "Hello World Here"
CONCAT(1, 2)                          --> 1 2
CONCAT({INPUT}, "hi")                 --> "Bye hi"
CONCAT(Hello)                         --> invalid
CONCAT(ha, he)                        --> invalid
```

### Concatenation with a separator function (CONCAT_WS)

The CONCAT_WS function adds two or more strings together with a separator.

* Minimum 2 parameters and the separator.
* Any quantity of parameters.
* CONCAT_WS can be a part of an embedded function.
* Must be a string, number, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).

{% hint style="warning" %}
The separator between the words is what is in the first place in the function CONCAT_WS(-, xx, yy). **-** is the separator **xx-yy**
{% endhint %}

#### CONCAT_WS function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

CONCAT_WS("-", "Hello", "World")            --> "Hello-World"
CONCAT_WS("+", "Hello", "World", "Here")    --> "Hello+World+Here"
CONCAT_WS("k", "1", "2")                    --> "1k2"
CONCAT_WS("-", {INPUT}, "hi")               --> "Bye-hi"
CONCAT_WS(-, Hello)                         --> invalid
CONCAT_WS(-, ha, he)                        --> invalid
```

### String format function (STRINGFORMAT)

The CONCAT function adds two or more strings together.

* Must have 1 parameter.
* STRINGFORMAT can be a part of an embedded function.
* Must be a string, number, or an **INPUT **variable.
* Parameters must be in **"",  **because it is a string.

#### CONCAT function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

STRINGFORMAT("Hello,World")             --> "Hello,World"
STRINGFORMAT("Hello, World, Here")      --> "Hello, World, Here"
STRINGFORMAT("1, 2")                    --> 1 2
STRINGFORMAT("{INPUT}hi")               --> "Byehi"
STRINGFORMAT("Hello")                   --> "Hello"
STRINGFORMAT("ha he")                   --> "ha he"
STRINGFORMAT("Hello", "World")          --> invalid
STRINGFORMAT("ha" "he")                 --> invalid
```

### Length function (LEN)

The LENfunction returns the length of a string.

* Must have 1 parameter.
* LEN can be a part of an embedded function.
* Must be a string, number, or an **INPUT **variable.

#### LEN function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

LEN("Hello")       --> 5
LEN("555")         --> 3
LEN("Hello")       --> 7
LEN({INPUT})       --> 3
LEN(Hello, bye)    --> invalid
LEN(25)            --> invalid
```

### Replace function (REPLACE)

The REPLACE function replaces all occurrences of a substring within a string with a new substring.

* Must have 3 parameters.

{% hint style="warning" %}
1. parameter --> **where **to replace
2. parameter --> **what** to replace
3. parameter --> **for what** to replace
{% endhint %}

* REPLACE can be a part of an embedded function.
* Must be a string, number, or an **INPUT **variable.
* Parameters can be separated by **comma **(,).

#### REPLACE function examples:

```javascript
INPUT = "Bye bye"
[function] --> [output]

REPLACE("Hello World", "o", "a")       --> "Hella warld"
REPLACE("Hello 777", "777", "444")     --> "Hella 444"
REPLACE({INPUT}, "y", "3")             -->" B3e B3e"
REPLACE(Hello World, ddd o, a)         --> invalid
REPLACE("Hello World", o, a)           --> invalid
```

### Upper case function (UPPER_CASE)

The UPPER_CASE function converts the string to the upper case.

* Must have 1 parameter.
* UPPER_CASE can be a part of an embedded function.
* Must be a string or an **INPUT **variable.

#### UPPER_CASE function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

UPPER_CASE("Hello World")       --> "HELLO WORLD"
UPPER_CASE("I AM NEW HERE")     --> "I AM NEW HERE"
UPPER_CASE("2ae3")              --> "2AE3"
UPPER_CASE({INPUT})             --> "BYE"
UPPER_CASE("Hello", "no")       --> invalid
UPPER_CASE(Hello World)         --> invalid
```

### Lower case function (LOWER_CASE)

The LOWER_CASE function converts the string to the upper case.

* Must have 1 parameter.
* LOWER_CASE can be a part of an embedded function.
* Must be a string or an **INPUT **variable.

#### LOWER_CASE function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

LOWER_CASE("HELLo WORLd")       --> "hello world"
LOWER_CASE("I am HERE")         --> "i am here"
LOWER_CASE("2AE3")              --> "2ae3"
UPPER_CASE({INPUT})             --> "bye"
LOWER_CASE(Hello, no)           --> invalid
LOWER_CASE(Hello World)         --> invalid
```
