# Math Functions

## List of math functions

* SUM
* MIN
* MAX
* AVG
* COUNT
* MEDIAN
* CEILING
* FLOOR
* ROUND
* EXP
* POW
* \+
* −
* \*
* /

### Summation (SUM)

The SUM function sums up numerical values.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, SUM can take an array of numbers in any argument.

```javascript
input1 = 3
input2 = [1,2,3]

[function] --> [output]

SUM(1,2)           --> 3
SUM(1,2,3)         --> 6
SUM({input1},6)    --> 9
SUM({input2})      --> 6
SUM({input2},4)    --> 10
SUM("1")           --> 1
SUM(1)             --> 1

SUM("a","b")     --> invalid
```

### Minimum (MIN)

The MIN function returns the smallest number from those provided.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MIN can take an array of numbers in any argument.

```javascript
input1 = 3
input2 = [1,2,3]

[function] --> [output]

MIN(5,8)           --> 5
MIN(1,2,3)         --> 1
MIN({input1},6)    --> 3
MIN({input2})      --> 1
MIN({input2},10)   --> 1
MIN(1)             --> 1
MIN("1")           --> 1

MIN("a","b")     --> invalid
```

### Maximum (MAX)

The MIN function returns the largest number from those provided.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MAX can take an array of numbers in any argument.

```javascript
input1 = 3
input2 = [1,2,3]

[function] --> [output]

MAX(5,8)           --> 8
MAX(1,2,3)         --> 3
MAX({input2},6)    --> 6
MAX({input2})      --> 3
MAX({input2},10)   --> 10
MAX(1)             --> 1
MAX("1")           --> 1

MAX("a","b")     --> invalid
```

### Average (AVG)

Returns the average (arithmetic mean) of the arguments.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, AVG can take an array of numbers in any argument.

```javascript
input1 = 3
input2 = [1,2,3]

[function] --> [output]

AVG(6,8)           --> 7
AVG(1,2,3)         --> 2
AVG({input1},7)    --> 5
AVG({input2})      --> 2
AVG("1",3)         --> 2

AVG("a","b")     --> invalid
```

### Count (COUNT)

Counts the number of its arguments or elements of provided arrays.

* Takes any number of arguments greater than 0.
* When given an array, it looks inside the array and counts in its elements.

```javascript
input = 3

[function] --> [output]

COUNT(6,8)           --> 2
COUNT(1,2,3)         --> 2
COUNT({input},7)     --> 2
COUNT([1,2,3])       --> 3
COUNT([1,2,3],4)     --> 4
COUNT(1)             --> 1
COUNT("a","b")       --> 2

COUNT()              --> invalid
```

### Median (MEDIAN)

Returns the median of the given numbers. The median is the number in the middle of a set of numbers.

* Takes any number of arguments greater than 0.
* Each argument must be a number or a variable.
* Alternatively, MEDIAN can take an array of numbers in any argument.

```javascript
input = 3

[function] --> [output]

MEDIAN(6,8)           --> 7
MEDIAN(1,2,2,3)       --> 2
MEDIAN({input},7)     --> 5
MEDIAN(0,[2,5])       --> 2
MEDIAN(1)             --> 1
MEDIAN("1","3")       --> 2

MEDIAN("a","b")       --> invalid
```

### Ceiling (CEILING)

Returns a number rounded up to the nearest whole number.

* Takes 1 argument.
* The argument must be a number or a variable.

```javascript
input = 3.28

[function] --> [output]

CEILING(1.34)          --> 2
CEILING({input})       --> 4
CEILING("1.15")        --> 2

CEILING(6,8)           --> invalid
CEILING("a","b")       --> invalid
```

### Floor (FLOOR)

Returns a number rounded down to the nearest whole number.

* Takes 1 argument.
* The argument must be a number or a variable.

```javascript
input = 3.28

[function] --> [output]

FLOOR(1.34)          --> 1
FLOOR({input})       --> 3
FLOOR("1.15")        --> 1

FLOOR(6,8)           --> invalid
FLOOR("a","b")       --> invalid
```

### Round (ROUND)

Rounds a number to the closest number of the specified decimal place.

* Takes 1 or 2 arguments.
* The first argument is the number to be rounded.
* The second optional argument is the number of decimal spaces.
* The second argument should be a whole number.
* If the second argument is not given, it defaults to 0.
* The second argument allows negative values.

<pre class="language-javascript"><code class="lang-javascript">input = 8.358

[function] --> [output]

ROUND(24.89)         --> 25
ROUND(24.89, 2)      --> 24.89
ROUND(24.89, -1)     --> 20
<strong>ROUND({input})       --> 8
</strong>ROUND({input},1)     --> 8.4
ROUND("24.89")       --> 25

ROUND("a",2)     --> invalid</code></pre>

### **Exponential (EXP)**

Returns the value of exponential function of the given numerical argument.

* Takes 1 argument.
* The argument must be a number or a variable.

```javascript
input = 2.5

[function] --> [output]

EXP(0)              --> 1
EXP(1)              --> 2.718281828459045
EXP(2.5)            --> 12.182493960703473
EXP({input})        --> 12.182493960703473
EXP(-2.5)           --> 0.0820849986238988
EXP("2.5")          --> 12.182493960703473

EXP("x")            --> invalid
```

### **Power (POW)**

Returns an arbitrary power of an arbitrary number.

* Takes 2 arguments.
* Both arguments have to be numbers or a variables.
* The first argument is the base, the second argument is the exponent.

```javascript
input = 3

[function] --> [output]

POW(2,6)            --> 64
POW(0,6)            --> 0
POW(10,0)           --> 1
POW(10,-2.5)        --> 0.00316227766
POW(2,{input})      --> 8

POW(-4,0.5)         --> invalid
POW("a",2)          --> invalid
```

### **Arithmetic operations**

Besides the above described functions, basic arithmetic operations can be also used.

### Plus (+)

* Takes 2 arguments.
* Both arguments have to be numbers or a variables.

```javascript
input = 6

[function] --> [output]

4+2             --> 6
{input}+2       --> 8
3+{input}       --> 9

x+x             --> invalid
```

### Minus (-)

* Takes 1 or 2 arguments, yet the second argument always has to be there.
* Both arguments have to be numbers or a variables.

```javascript
input = 6

[function] --> [output]

4-2             --> 2
{input}-1       --> 5
9-{input1}      --> 3
-1              --> -1

3-              --> invalid
x-x             --> invalid
```

{% hint style="warning" %}
For the minus operation to work correctly, it is necessary to use brackets to specify the desired order of the operations, e.g. write (1-1)-1 or (-3)\*5 instead of merely 1 - 1 - 1 or -3\*5, respectively.
{% endhint %}

### **Times (\*)**

```javascript
input = 6

[function] --> [output]

4*2             --> 8
{input}*2       --> 12
5*(-2)          --> -10

x*x             --> invalid
```

### Divided (/)

```javascript
input = 6

[function] --> [output]

4/2             --> 2
18/{input}      --> 3
30/(-6)         --> -5

x/x             --> invalid
```

You may use the above described basic operations in the usual way, writing more complex expressions with the use of brackets (), for example:

<pre class="language-javascript"><code class="lang-javascript"><strong>input = 3
</strong>
[function] --> [output]

1+2+(-3)                            --> 0
1-(4+5+2*{input})/3                 --> -4
(4+9)*(4+9) - (4*4 + 2*4*9 + 9*9)   --> 0</code></pre>

It is also possible to use arithmetic operations together with other functions:

<pre class="language-javascript"><code class="lang-javascript"><strong>input = 6
</strong>
[function] --> [output]

SUM(1,2,-3)                                 --> 0
1-AVG(4,5,2*{input})                        --> -4
POW(4+9,2) - (POW(4,2) + 2*4*9 + POW(9,2))  --> 0
</code></pre>

