# Text Functions

## List of text functions

* CONCAT
* CONCAT\_WS
* LEN
* REPLACE
* UPPER\_CASE
* LOWER\_CASE
* LEFT
* RIGHT
* TRIM
* TRIM\_LEFT
* TRIM\_RIGHT

### Concatenation function (CONCAT)

The CONCAT function adds two or more strings together.

* Minimum 2 parameters.
* Any quantity of parameters.
* CONCAT can be a part of an embedded function.
* Must be a string, number, or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### CONCAT function examples:

```javascript
INPUT = "Bye"
[function] --> [output]

CONCAT("Hello", "World")              --> "HelloWorld"
CONCAT("Hello", "World", "Here")      --> "HelloWorldHere"
CONCAT(1, 2)                          --> 12
CONCAT({INPUT}, "hi")                 --> "Byehi"
CONCAT(Hello)                         --> invalid
CONCAT(ha, he)                        --> invalid
```

### Concatenation with a separator function (CONCAT\_WS)

The CONCAT\_WS function adds two or more strings together with a separator.

* Minimum 2 parameters and the separator.
* Any quantity of parameters.
* CONCAT\_WS can be a part of an embedded function.
* Must be a string, number, or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

{% hint style="warning" %}
The separator between the words is what is in the first place in the function CONCAT\_WS(-, xx, yy). **-** is the separator **xx-yy**
{% endhint %}

#### CONCAT\_WS function examples:

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
* Must be a string, number, or an **INPUT** variable.
* Parameters must be in **"",** because it is a string.

#### STRINGFORMAT function examples:

```javascript
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
* Must be a string, number, or an **INPUT** variable.

#### LEN function examples:

```javascript
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
1. parameter --> **where** to replace
2. parameter --> **what** to replace
3. parameter --> **for what** to replace
{% endhint %}

* REPLACE can be a part of an embedded function.
* Must be a string, number, or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### REPLACE function examples:

```javascript
[function] --> [output]

REPLACE("Hello World", "o", "a")       --> "Hella warld"
REPLACE("Hello 777", "777", "444")     --> "Hella 444"
REPLACE({INPUT}, "y", "3")             -->" B3e B3e"
REPLACE(Hello World, ddd o, a)         --> invalid
REPLACE("Hello World", o, a)           --> invalid
```

### Upper case function (UPPER\_CASE)

The UPPER\_CASE function converts the string to the upper case.

* Must have 1 parameter.
* UPPER\_CASE can be a part of an embedded function.
* Must be a string or an **INPUT** variable.

#### UPPER\_CASE function examples:

```javascript
[function] --> [output]

UPPER_CASE("Hello World")       --> "HELLO WORLD"
UPPER_CASE("I AM NEW HERE")     --> "I AM NEW HERE"
UPPER_CASE("2ae3")              --> "2AE3"
UPPER_CASE({INPUT})             --> "BYE"
UPPER_CASE("Hello", "no")       --> invalid
UPPER_CASE(Hello World)         --> invalid
```

### Lower case function (LOWER\_CASE)

The LOWER\_CASE function converts the string to the upper case.

* Must have 1 parameter.
* LOWER\_CASE can be a part of an embedded function.
* Must be a string or an **INPUT** variable.

#### LOWER\_CASE function examples:

```javascript
[function] --> [output]

LOWER_CASE("HELLo WORLd")       --> "hello world"
LOWER_CASE("I am HERE")         --> "i am here"
LOWER_CASE("2AE3")              --> "2ae3"
UPPER_CASE({INPUT})             --> "bye"
LOWER_CASE(Hello, no)           --> invalid
LOWER_CASE(Hello World)         --> invalid
```

### Left (LEFT)

The LEFT function returns the first character of a string or the specified number of characters. Functions has 2 parameters:

1. String value or variable
2. \[optional] The number of characters to be taken from the left side. Value is set to 1 by default if not used

#### LEFT function examples:

```javascript
VARIABLE = "123"
[function] --> [output]

LEFT("abcd")                   --> "a"
LEFT("")                       --> ""
LEFT("abcd",2)                 --> "ab"
LEFT({VARIABLE},2)             --> "12"
```



### Right (RIGHT)

The RIGHT function returns the last character of a string or the specified number of characters from the end of the input string.&#x20;

**Functions parameters:**

1. String value or variable
2. \[optional] The number of characters to be taken from the right side. Value is set to 1 by default if not used

#### RIGHT function examples:

```javascript
VARIABLE = "123"
[function] --> [output]

RIGHT("abcd")                   --> "d"
RIGHT("")                       --> ""
RIGHT("abcd",2)                 --> "cd"
RIGHT({VARIABLE},2)             --> "23"
```

### Trim (TRIM)

The function trims leading and trailing spaces in a string.&#x20;

**Function parameters:**

1. String value or variable

#### TRIM function examples:

```javascript
VARIABLE = "  123  "
[function] --> [output]

TRIM("   abcd   ")           --> "abcd"
TRIM("")                     --> ""
TRIM("abcd")                 --> "abcd"
TRIM({VARIABLE})             --> "123"
```

### Trim Left (TRIM\_LEFT)

The function trims leading spaces in the input string.&#x20;

**Function parameters:**

1. String value or variable

#### TRIM\_LEFT function examples:

```javascript
VARIABLE = "  123"
[function] --> [output]

TRIM_LEFT("   abcd")              --> "abcd"
TRIM_LEFT("   abcd   ")           --> "abcd   "
TRIM_LEFT("")                     --> ""
TRIM_LEFT({VARIABLE})             --> "123"
```

### Trim Right (TRIM\_RIGHT)

The function trims trailing spaces in the input string.&#x20;

**Function parameters:**

1. String value or variable

#### TRIM\_RIGHT function examples:

```javascript
VARIABLE = "123  "
[function] --> [output]

TRIM_RIGHT("abcd   ")              --> "abcd"
TRIM_RIGHT("abcd")                 --> "abcd"
TRIM_RIGHT("")                     --> ""
TRIM_RIGHT({VARIABLE})             --> "123"
```

