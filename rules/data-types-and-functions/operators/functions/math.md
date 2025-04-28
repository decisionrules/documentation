# Math Functions

## List of math functions

* [ABS](math.md#absolute-value-abs)
* [AVG](math.md#average-avg)
* [CEILING](math.md#ceiling-ceiling)
* [COUNT](math.md#count-count)
* [/  (Division)](math.md#division)
* [EXP](math.md#exponential-exp)
* [FLOOR](math.md#floor-floor)
* [MAX](math.md#maximum-max)
* [MEDIAN](math.md#median-median)
* [MIN](math.md#minimum-min)
* [— (Minus)](math.md#minus)
* [MODULO](math.md#modulo-modulo)
* [+ (Plus)](math.md#plus)
* [POW](math.md#power-pow)
* [ROUND](math.md#round-round)
* [ROUNDE](math.md#round-to-even-rounde)
* [SUM](math.md#summation-sum)
* &#x20;[**\***  (Times)](math.md#times)
* [NUMHASH](math.md#numerical-hash-numhash)

### Absolute Value (`ABS`)

Returns the absolute value of a number.

* Takes 1 argument.
* The argument has to be a number or a variable.

**Input Example:**

```javascript
// variable input 

input = 3
```

```javascript
// [function] --> [output]

ABS(6)            --> 6
ABS(0)            --> 0
ABS(-2.5)         --> 2.5
ABS({input})      --> 3

ABS("a")          --> invalid
```

### Average (`AVG`)

Returns the average (arithmetic mean) of the arguments.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, AVG can take an array of numbers in any argument.

**Input Example:**

```javascript
// variables input 

input1 = 3
input2 = [1,2,3]
```

```javascript
// [function] --> [output]

AVG(6,8)           --> 7
AVG(1,2,3)         --> 2
AVG({input1},7)    --> 5
AVG({input2})      --> 2
AVG("1",3)         --> 2

AVG("a","b")       --> invalid
```

### Ceiling (`CEILING`)

Returns a number rounded up to the nearest whole number.

* Takes 1 argument.
* The argument must be a number or a variable.

**Input Example:**

```javascript
// variable input 

input = 3.28
```

```javascript
// [function] --> [output]

CEILING(1.34)          --> 2
CEILING({input})       --> 4
CEILING("1.15")        --> 2

CEILING(6,8)           --> invalid
CEILING("a","b")       --> invalid
```

### Count (`COUNT`)

Counts the number of its arguments or elements of provided arrays.

* Takes any number of arguments greater than 0.
* When given an array, it looks inside the array and counts in its elements.

**Input Example:**

```javascript
// variable input 

input = 3
```

```javascript
// {function] --> [output]

COUNT(6,8)           --> 2
COUNT(1,2,3)         --> 3
COUNT({input},7)     --> 2
COUNT([1,2,3])       --> 3
COUNT([1,2,3],4)     --> 4
COUNT(1)             --> 1
COUNT("a","b")       --> 2

COUNT()              --> invalid
```

### Division (`/`)

Takes 2 arguments. Both arguments must be numbers or variables.

**Input Example:**

```javascript
// variable input 

input = 6
```

```javascript
// [function] --> [output]

4/2             --> 2
18/{input}      --> 3
30/(-6)         --> -5

x/x             --> invalid
```

### **Exponential (`EXP`)**

Returns the value of exponential function of the given numerical argument.

* Takes 1 argument.
* The argument must be a number or a variable.

**Input Example:**

```javascript
// variable input 

input = 2.5
```

```javascript
// [function] --> [output]

EXP(0)              --> 1
EXP(1)              --> 2.718281828459045
EXP(2.5)            --> 12.182493960703473
EXP({input})        --> 12.182493960703473
EXP(-2.5)           --> 0.0820849986238988
EXP("2.5")          --> 12.182493960703473

EXP("x")            --> invalid
```

### Floor (`FLOOR`)

Returns a number rounded down to the nearest whole number.

* Takes 1 argument.
* The argument must be a number or a variable.

**Input Example:**

```javascript
// variable input 

input = 3.28
```

```javascript
// [function] --> [output]

FLOOR(1.34)          --> 1
FLOOR({input})       --> 3
FLOOR("1.15")        --> 1

FLOOR(6,8)           --> invalid
FLOOR("a","b")       --> invalid
```

### Maximum (`MAX`)

Returns the largest number from those provided.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MAX can take an array of numbers in any argument.

**Input Example:**

```javascript
// variables input

input1 = 3    
input2 = [1,2,3]
```

```javascript
// [function] --> [output]

MAX(5,8)           --> 8
MAX(1,2,3)         --> 3
MAX({input2},6)    --> 6
MAX({input2})      --> 3
MAX({input2},10)   --> 10
MAX(1)             --> 1
MAX("1")           --> 1

MAX("a","b")     --> invalid
```

### Median (`MEDIAN`)

Returns the median of the given numbers. The median is the number in the middle of a set of numbers.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MEDIAN can take an array of numbers in any argument.

**Input Example:**

```javascript
// variable input 

input = 3
```

```javascript
// [function] --> [output]

MEDIAN(6,8)           --> 7
MEDIAN(1,2,2,3)       --> 2
MEDIAN({input},7)     --> 5
MEDIAN(0,[2,5])       --> 2
MEDIAN(1)             --> 1
MEDIAN("1","3")       --> 2

MEDIAN("a","b")       --> invalid
```

### **Minimum (`MIN`)**

Returns the smallest number from those provided.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MIN can take an array of numbers as an argument.

**Input Example:**

```javascript
// variables input

input1 = 3  
input2 = [1,2,3]
```

```javascript
// [function] --> [output]

MIN(5,8)           --> 5  
MIN(1,2,3)         --> 1  
MIN({input1},6)    --> 3  
MIN({input2})      --> 1  
MIN({input2},10)   --> 1  
MIN(1)             --> 1  
MIN("1")           --> 1  

MIN("a","b")       --> invalid  
```

### Minus (`-`)

* Takes 1 or 2 arguments, yet the second argument always has to be there.
* Both arguments have to be numbers or a variables.

**Input Example:**

```javascript
// variable input

input = 6  
```

```javascript
// [function] --> [output]

4-2             --> 2
{input}-1       --> 5
9-{input1}      --> 3
-1              --> -1

3-              --> invalid
x-x             --> invalid
```

{% hint style="danger" %}
For the minus operation to work correctly, it is necessary to use brackets to specify the desired order of the operations, e.g. write `(1-1)-1` or `(-3)*5` instead of merely `1 - 1 - 1` or `-3*5`, respectively.
{% endhint %}

### Modulo (`MODULO`)

Returns the remainder of the division of two numbers. This function captures the remainder when the first argument is divided by the second, which can be useful in scenarios requiring evaluations based on divisibility or cyclic behavior.

* Takes 2 arguments.
* Both arguments must be numbers or variables.

**Input Example:**

```javascript
// variables input

input1 = 5
input2 = 3
```

```javascript
// [function] --> [output]

MODULO(10, 3)              --> 1
MODULO(10, 5)              --> 0
MODULO(15, {input2})       --> 0
MODULO({input1}, {input2}) --> 2
MODULO(9, 4)               --> 1

MODULO(10)                 --> invalid
MODULO("a", 2)             --> invalid
```

### Plus (`+`)

* Takes 2 arguments.
* Both arguments have to be numbers or a variables.

**Input Example:**

```javascript
// variable input

input = 6
```

```javascript
// [function] --> [output]

4+2             --> 6
{input}+2       --> 8
3+{input}       --> 9

x+x             --> invalid
```

### **Power (`POW`)**

Returns an arbitrary power of an arbitrary number.

* Takes 2 arguments.
* Both arguments have to be numbers or a variables.
* The first argument is the base, the second argument is the exponent.

**Input Example:**

```javascript
// variable input

input = 3
```

```javascript
// [function] --> [output]

POW(2,6)            --> 64
POW(0,6)            --> 0
POW(10,0)           --> 1
POW(10,-2.5)        --> 0.00316227766
POW(2,{input})      --> 8

POW(-4,0.5)         --> invalid
POW("a",2)          --> invalid
```

### Round (`ROUND`)

Rounds a number to the closest number of the specified decimal place.

* Takes 1 or 2 arguments.
* The first argument is the number to be rounded.
* The second (optional) specifies the number of decimal places (defaults to 0 if omitted and can be negative).

**Input Example:**

```javascript
// variable input

input = 8.358
```

<pre class="language-javascript"><code class="lang-javascript">// [function] --> [output]

ROUND(24.89)         --> 25
ROUND(24.89, 2)      --> 24.89
ROUND(24.89, -1)     --> 20
<strong>ROUND({input})       --> 8
</strong>ROUND({input},1)     --> 8.4
ROUND("24.89")       --> 25

ROUND("a",2)     --> invalid
</code></pre>

### Round **to Even** (`ROUNDE`)

The round-to-even method is used in engineering, finance, and computer science to reduce bias when you use rounded numbers to estimate sums and averages. The round-to-even method works like this:

* If the difference between the number and the nearest integer is less than 0.5, round to the nearest integer. This familiar rule is used by many rounding methods.
* If the difference between the number and the nearest integer is exactly 0.5, look at the integer part of the number. If the integer part is EVEN, round towards zero. If the integer part of the number is ODD, round away from zero. In either case, the rounded number is an even integer.

```javascript
// [function] --> [output]

ROUNDE(1.465,2)      --> 1.46
ROUNDE(1.5)          --> 2
ROUNDE(2.5)          --> 2
ROUNDE("a",2)     --> invalid
```

### Summation (`SUM`)

Sums up numerical values.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, SUM can take an array of numbers in any argument.

**Input Example:**

```javascript
// variables input

input1 = 3
input2 = [1,2,3]
```

```javascript
// [function] --> [output]

SUM(1,2)           --> 3
SUM(1,2,3)         --> 6
SUM({input1},6)    --> 9
SUM({input2})      --> 6
SUM({input2},4)    --> 10
SUM("1")           --> 1
SUM(1)             --> 1

SUM("a","b")     --> invalid
```

### **Times (\*)**

Performs multiplication between two numbers.

* Takes 2 arguments.
* Both arguments have to be numbers or a variables.

**Input Example:**

```javascript
// variable input

input = 6
```

```javascript
// [function] --> [output]

4*2             --> 8
{input}*2       --> 12
5*(-2)          --> -10

x*x             --> invalid
```

### **Numerical Hash (NUMHASH)**

Converts the input into a number. Uses a variant of the djb2 hash function.

* Takes any amount arguments.
* Arguments can be of any type.
* Is idempotent
* Uniqueness is not guaranteed

**Input Example:**

```javascript
// [function]   -->     [output]
'hello'         -->     261238937
{"test": 123}   -->     1271012719
5*(-2)          -->     68779267
```

## Combining Function Operators

You can combine basic operations to create more complex expressions using parentheses `()`. For example:

```javascript
// variable input

input = 6
```

```javascript
// [function] --> [output]

1+2+(-3)                            --> 0
1-(4+5+2*{input})/3                 --> -4
(4+9)*(4+9) - (4*4 + 2*4*9 + 9*9)   --> 0
```

You can also use arithmetic operations in conjunction with other functions:

<pre class="language-javascript"><code class="lang-javascript"><strong>// [function] --> [output]
</strong>
SUM(1,2,-3)                                 --> 0
1-AVG(4,5,2*{input})                        --> -4
POW(4+9,2) - (POW(4,2) + 2*4*9 + POW(9,2))  --> 0
</code></pre>

