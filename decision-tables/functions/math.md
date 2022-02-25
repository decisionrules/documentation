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
* \+ (plus)
* − (minus)
* / (divide)
* **\*** (multiply)

### Summation function (SUM)

The SUM function adds values together.

* Any quantity of parameters.
* Minimum 2 parameters.
* SUM can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### MAX function examples:

```javascript
INPUT = 3
[function] --> [output]

SUM(1,2)           --> 3
SUM(1,2,3)         --> 6
SUM({INPUT},6)     --> 9
SUM(1)             --> invalid
SUM("1")           --> invalid
SUM(xx,xx)         --> invalid
SUM("xx","xx")     --> invalid
```

### Minimum function (MIN)

The MIN function returns the smallest number in a set of values.

* Minimum 2 parameters.
* Any quantity of parameters.
* MIN can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### MIN function examples:

```javascript
INPUT = 3
[function] --> [output]

MIN(5,8)           --> 5
MIN(1,2,3)         --> 1
MIN({INPUT},6)     --> 3
MIN(1)             --> invalid
MIN("1")           --> invalid
MIN(xx,xx)         --> invalid
MIN("xx","xx")     --> invalid
```

### Maximum function (MAX)

The MAX function returns the largest value in a set of values.

* Minimum 2 parameters.
* Any quantity of parameters.
* MAX can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### SUM function examples:

```javascript
INPUT = 3
[function] --> [output]

MAX(5,8)           --> 8
MAX(1,2,3)         --> 3
MAX({INPUT},6)     --> 6
MAX(1)             --> invalid
MAX("1")           --> invalid
MAX(xx,xx)         --> invalid
MAX("xx","xx")     --> invalid
```

### Average function (AVG)

The AVG function returns the average (arithmetic mean) of the arguments.

* Minimum 2 parameters.
* Any quantity of parameters.
* AVG can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### AVG function examples:

```javascript
INPUT = 3
[function] --> [output]

AVG(6,8)           --> 7
AVG(1,2,3)         --> 2
AVG({INPUT},7)     --> 5
AVG(1)             --> invalid
AVG("1")           --> invalid
AVG(xx,xx)         --> invalid
AVG("xx","xx")     --> invalid
```

### Count function (COUNT)

The COUNT function counts the number of cells that contain numbers and counts numbers within the list of arguments.

* Minimum 2 parameters.
* Any quantity of parameters.
* COUNT can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### COUNT function examples:

```javascript
INPUT = 3
[function] --> [output]

COUNT(6,8)           --> 7
COUNT(1,2,3)         --> 2
COUNT({INPUT},7)     --> 5
COUNT(1)             --> invalid
COUNT("1")           --> invalid
COUNT(xx,xx)         --> invalid
COUNT("xx","xx")     --> invalid
```

### Median function (MEDIAN)

The COUNT function returns the median of the given numbers. The median is the number in the middle of a set of numbers.

* Minimum 2 parameters.
* Any quantity of parameters.
* MEDIAN can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

#### MEDIAN function examples:

```javascript
INPUT = 3
[function] --> [output]

MEDIAN(6,8)           --> 7
MEDIAN(1,2,2,3)       --> 2
MEDIAN({INPUT},7)     --> 5
MEDIAN(1)             --> invalid
MEDIAN("1")           --> invalid
MEDIAN(xx,xx)         --> invalid
MEDIAN("xx","xx")     --> invalid
```

### Ceiling function (CEILING)

The CEILING function returns a number rounded up, away from zero, to the nearest multiple of significance.

* Must have 1 parameter.
* CEILING can be a part of an embedded function.
* Must be a number or an **INPUT** variable.

#### CEILING function examples:

```javascript
INPUT = 3.28
[function] --> [output]

CEILING(1.34)          --> 2
CEILING({INPUT})       --> 4
CEILING("1")           --> invalid
CEILING(xx,xx)         --> invalid
CEILING("xx","xx")     --> invalid
CEILING(6,8)           --> invalid
CEILING(1,2,2,3)       --> invalid
```

### Floor function (FLOOR)

The FLOOR function rounds a number down, toward zero, to the nearest multiple of significance.

* Must have 1 parameter.
* FLOOR can be a part of an embedded function.
* Must be a number or an **INPUT** variable.

#### CEILING function examples:

```javascript
INPUT = 3.28
[function] --> [output]

FLOOR(1.34)          --> 1
FLOOR({INPUT})       --> 3
FLOOR("1")           --> invalid
FLOOR(xx,xx)         --> invalid
FLOOR("xx","xx")     --> invalid
FLOOR(6,8)           --> invalid
FLOOR(1,2,2,3)       --> invalid
```

### Round function (ROUND)

The FLOOR function rounds a number to the closest number or the specified decimal place.

* Must have 1 or 2 parameters.
* ROUND can be a part of an embedded function.
* Must be a number or an **INPUT** variable.
* Parameters can be separated by **comma** (,).

{% hint style="warning" %}
If there is just 1 parameter, it rounds to the closes round number.

The second parameter is the number of decimal spaces the number must be rounded to.
{% endhint %}

#### ROUND function examples:

```javascript
INPUT = 3.68
[function] --> [output]

ROUND(1.34)          --> 1
ROUND(8.358, 2)      --> 8.36
ROUND({INPUT})       --> 4
ROUND({INPUT},1)     --> 3.7
ROUND("1")           --> invalid
ROUND(xx,xx)         --> invalid
ROUND("xx","xx")     --> invalid
ROUND(6,8)           --> invalid
ROUND(1,2,2,3)       --> invalid
```

### **Eulers number to power of n function (EXP)**

Return Eulers number to user defined power of n

Where n parameter has to be type NUMBER; n is an element of the set **Q**

#### EXP example

```javascript
INPUT = user defined exponent
[function] --> [output]

EXP(0)              --> 1
EXP(1)              --> 2.718281828459045
EXP(2.5)            --> 12.182493960703473
EXP(-2.5)           --> 0.0820849986238988
...
EXP(n)              --> E^n
EXP({input})        --> E^{input}
EXP("1")            --> invalid
EXP(x)              --> invalid
EXP("x")            --> invalid
```

### **PLUS, MINUS, MULTIPLY, DEVIDE functions (+,** −, **\*, /)**

Among other things, basic arithmetic operands such as plus, minus, multiply, and divide can be used in functions.

#### PLUS examples

```javascript
INPUT1 = 6
INPUT2 = 2
[function] --> [output]

4+2                  --> 6
{input1}+{input2}    --> 8
3+{input1}           --> 9
x+x                  --> invalid
```

#### MINUS examples

```javascript
INPUT1 = 6
INPUT2 = 2
[function] --> [output]

4-2                  --> 2
{input1}-{input2}    --> 4
9-{input1}           --> 3
x+x                  --> invalid
```

**MULTIPLY examples**

```javascript
INPUT1 = 6
INPUT2 = 2
[function] --> [output]

4*2                  --> 8
{input1}*{input2}    --> 12
3*{input1}           --> 18
x*x                  --> invalid
```

#### DEVIDE examples

```javascript
INPUT1 = 6
INPUT2 = 2
[function] --> [output]

4/2                  --> 2
{input1}/{input2}    --> 3
8/{input2}           --> 4
x/x                  --> invalid
```
