# Text Functions

## List of text functions

* CONCAT
* CONCAT\_WS
* LEN
* UPPER\_CASE
* LOWER\_CASE
* LEFT
* RIGHT
* TRIM
* TRIM\_LEFT
* TRIM\_RIGHT
* RE
* TEST
* MATCH
* REPLACE
* SPLIT

#### Deprecated functions

* STRINGFORMAT

### Concatenation (CONCAT)

Adds two or more strings together.

* Takes at least 1 argument.
* All arguments must be strings, numbers, variables or alternatively arrays.

```javascript
input = "week"

[function] --> [output]

CONCAT("pine","apple")      --> "pineapple"
CONCAT("he","ll","o")       --> "hello"
CONCAT(1,2)                 --> 12
CONCAT({input},"end")       --> "weekend"
CONCAT(1+1,"nd")            --> "2nd"
CONCAT(["a","b","c"])       --> "abc"

CONCAT()                    --> invalid
```

### Concatenation with a separator (CONCAT\_WS)

Adds two or more strings together with a separator.

* Takes at least 2 arguments.
* The first argument specifies the separator.
* The other arguments are the values to be concatenated.
* The arguments have to be strings, numbers or variables.
* All arguments except the first one can also take arrays.

```javascript
input = "week"

[function] --> [output]

CONCAT("-","pine","apple")      --> "pine-apple"
CONCAT_WS("+","he","ll","o")    --> "he+ll+o"
CONCAT_WS("_"1,2)               --> 1_2
CONCAT_WS(" ",{input},"end")    --> "week end"
CONCAT_WS("^",1+1,"nd")         --> "2^nd"
CONCAT_WS("separator","word")   --> "word"
CONCAT_WS("!",["a","b","c"])    --> "a!b!c"

CONCAT_WS()                     --> invalid
```

### Length (LEN)

Returns the length of a string.

* Takes 1 argument.
* The argument has to be a string, number, or a variable.

```javascript
[function] --> [output]

LEN("Hello")       --> 5
LEN("555")         --> 3
LEN(555)           --> 3

LEN("Hello", "bye")    --> invalid
```

### Upper case (UPPER\_CASE)

Converts a string to the upper case.

* Takes 1 argument.
* The argument has to be a string or a variable.

```javascript
[function] --> [output]

UPPER_CASE("Hello World")       --> "HELLO WORLD"
UPPER_CASE("I AM NEW HERE")     --> "I AM NEW HERE"
UPPER_CASE("2ae3")              --> "2AE3"

UPPER_CASE("Hello", "World")       --> invalid
```

### Lower case (LOWER\_CASE)

Converts a string to the lower case.

* Takes 1 argument.
* The argument has to be a string or a variable.

```javascript
[function] --> [output]

LOWER_CASE("Hello World")       --> "hello world"
LOWER_CASE("I AM NEW HERE")     --> "i am here"
LOWER_CASE("2AE3")              --> "2ae3"

UPPER_CASE("Hello", "World")       --> invalid
```

### Left (LEFT)

Returns the first character of a string or the specified number of characters from the beginning.

* Takes 1 or 2 arguments.
* The first argument has to be a string, number or a variable.
* The second optional argument specifies the number of characters to be taken from the left side. If not specified, it defaults to 1.

```javascript
input = "123"

[function] --> [output]

LEFT("abcd")           --> "a"
LEFT("")               --> ""
LEFT("abcd",2)         --> "ab"
LEFT({input},2)        --> "12"
```

### Right (RIGHT)

Returns the last character of a string or the specified number of characters from the end.

* Takes 1 or 2 arguments.
* The first argument has to be a string, number or a variable.
* The second optional argument specifies the number of characters to be taken from the right side. If not specified, it defaults to 1.

```javascript
input = "123"

[function] --> [output]

RIGHT("abcd")           --> "d"
RIGHT("")               --> ""
RIGHT("abcd",2)         --> "cd"
RIGHT({input},2)        --> "23"
```

### Trim (TRIM)

Trims leading and trailing spaces in a string.

* Takes 1 argument.
* The argument has to be a string, number or a variable.

```javascript
input = "  123  "

[function] --> [output]

TRIM("   abcd   ")       --> "abcd"
TRIM("")                 --> ""
TRIM("abcd")             --> "abcd"
TRIM({input})            --> "123"
```

### Trim left (TRIM\_LEFT)

Trims leading spaces in a string.

* Takes 1 argument.
* The argument has to be a string, number or a variable.

```javascript
input = "  123"
[function] --> [output]

TRIM_LEFT("   abcd")          --> "abcd"
TRIM_LEFT("   abcd   ")       --> "abcd   "
TRIM_LEFT("")                 --> ""
TRIM_LEFT({input})            --> "123"
```

### Trim right (TRIM\_RIGHT)

Trims trailing spaces in a string.

* Takes 1 argument.
* The argument has to be a string, number or a variable.

```javascript
VARIABLE = "123  "
[function] --> [output]

TRIM_RIGHT("abcd   ")              --> "abcd"
TRIM_RIGHT("abcd")                 --> "abcd"
TRIM_RIGHT("")                     --> ""
TRIM_RIGHT({VARIABLE})             --> "123"
```

### Regular expression (RE)

Builds a regular expression for use in other text functions (TEST, MATCH, REPLACE, SPLIT).

* Takes 1 or 2 arguments.
* The first argument is a string representation of the regular expression.
* The second optional argument is a string representation of custom flags.

```javascript
[function] --> [output]

RE("[A-Z]")        --> /[A-Z]/
RE("[A-Z]","g")    --> /[A-Z]/g
```

### Test (TEST)

Tests a string for a match against a regular expression and returns true or false.

* Takes 2 arguments.
* The first argument specifies to string to be tested.
* The first argument has to be a string, number or a variable.
* The second argument specifies the substring whose presence is to be tested.
* The second argument can take a string or the RE function.

```javascript
[function] --> [output]

TEST("Hello, World!","ll")             --> true
TEST("Hello, World!","[A-Z]")          --> true
TEST("Hello, World!",RE("l{2}"))       --> true
TEST("Hello, World!",RE("l{3}"))       --> false
TEST("Hello, World!",RE("H[ae]llo"))   --> true
TEST("Hello, World!",RE("h[ae]llo"))   --> false
```

### Match (MATCH)

Tests a string for a match against a regular expression and returns an array of matches (or null for no matches).

* Takes 2 arguments.
* The first argument specifies to string to be tested for matches.
* The first argument has to be a string, number or a variable.
* The second argument specifies the regular expression to be used for the matching.
* The second argument can take a string or the RE function.
* When the second argument is given as a plain string, the match is performed with the g (global) flag.

```javascript
[function] --> [output]

MATCH("Hello, World!","ll")             --> ["ll"]
MATCH("Hello, World!","[A-Z]")          --> ["H","W"]
MATCH("Hello, World!",RE("[A-Z]"))      --> ["H"]
MATCH("Hello, World!",RE("[A-Z]","g"))  --> ["H","W"]
MATCH("Hello, World!",RE("l{3}"))       --> null
MATCH("Hello, World!",RE("h[ae]llo"))   --> null
```

### Replace (REPLACE)

Takes a string, matches it against a regular expression and replaces the matches with a given replacement string.

* Takes 3 arguments.
* The first argument specifies to string to be tested for matches.
* The first argument has to be a string, number or a variable.
* The second argument specifies the regular expression to be used for the matching.
* The second argument can take a string or the RE function.
* When the second argument is given as a plain string, the match is performed with the g (global) flag.
* The third argument specifies the replacement string.

{% hint style="info" %}
Argument 1 --> **where** to replace

Argument 2 --> **what** to replace

Argument 3 --> **for what** to replace
{% endhint %}

```javascript
[function] --> [output]

REPLACE("Hello World", "o", "a")                    --> "Hella warld"
REPLACE("Hello, World!", "ll", "zz")                --> "Hezzo, World!"
REPLACE("Hello, World!", RE("[A-Z]","g"), "X")      --> "Xello, Xorld!"
REPLACE("John Smith", RE("(\w+)\s(\w+)"), "$2, $1") --> "Smith, John"
```

### Split (SPLIT)

Takes a string, matches it against a regular expression and splits it into an array of strings.

* Takes 2 arguments.
* The first argument specifies to string to be tested for matches.
* The first argument has to be a string, number or a variable.
* The second argument specifies the regular expression to be used for the matching.
* The second argument can take a string or the RE function.
* When the second argument is given as a plain string, the match is performed with the g (global) flag.

```javascript
[function] --> [output]

SPLIT("Hello, World!", "ll")                --> ["He","o, World!"]
SPLIT("Hello, World!", "l{2}")              --> ["He","o, World!"]
SPLIT("Hello, World!", RE("[A-Z]","g"))     --> ["","ello, ","orld!"]

```



### String format (STRINGFORMAT) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use plain text with variables instead.
{% endhint %}

Includes variables into a string.

* Must have 1 argument, the string with variables to include.

```javascript
input = "hi"

[function] --> [output]

STRINGFORMAT("Hello,World")             --> "Hello,World"
STRINGFORMAT("1, 2")                    --> 1 2
STRINGFORMAT("{INPUT}bye")              --> "hiby"
STRINGFORMAT("Hello")                   --> "Hello"
STRINGFORMAT("ha he")                   --> "ha he"
```

