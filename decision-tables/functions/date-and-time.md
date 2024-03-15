# Date and Time Functions

## List of date and time functions

* NOW
* CURDATE
* CURTIME
* DATE
* DATEDIFF
* DATE\_COMPUTE
* DAY
* MONTH
* YEAR
* WEEKDAY
* DATIME\_COMPUTE
* DATE\_MAX
* DATE\_MIN

{% hint style="info" %}
Within DecisionRules functions, date and time are represented by a date/time ISO string. Functions generating date like NOW or DATE therefore return string which can be then picked up by other date functions. On the other hand, most of the other date functions return numbers, like DATEDIFF, DAY, MONTH or YEAR.
{% endhint %}

### Now (NOW)

Returns the current date and time.

* Takes 1 optional argument.
* When present, the optional argument specifies time zone.

```javascript
input = "+02:00"

[function] ---> [output]

NOW()              ---> "2021-06-01T11:01"
NOW("+08:00")      ---> "2021-06-01T19:01"
NOW("-08:00")      ---> "2021-06-01T03:01"
NOW({input})       ---> "2021-06-01T13:01"

NOW(1)             ---> invalid
NOW("abc")         ---> invalid
```

### Current date (CURDATE)

Returns the current date.

* Takes 1 optional argument.
* When present, the optional argument specifies time zone.

```javascript
input = "+02:00"

[function] ---> [output]

CURDATE()              ---> "2021-06-01"
CURDATE("+08:00")      ---> "2021-06-01"
CURDATE("-02:00")      ---> "2021-06-01"
CURDATE({input})       ---> "2021-06-01"
CURDATE("+10:00")      ---> "2021-07-01"

CURDATE(1)             ---> invalid
CURDATE("xx")          ---> invalid
```

### Current time (CURTIME)

Returns the current time.

* Takes 1 optional argument.
* When present, the optional argument specifies time zone.

```javascript
input = "+02:00"

[function] ---> [output]

CURTIME()              ---> "11:16"
CURTIME("-02:00")      ---> "09:16"
CURTIME("+08:00")      ---> "19:16"
CURTIME({input})       ---> "13:16"

CURTIME(1)             ---> invalid
CURTIME("xx")          ---> invalid
```

### Date (DATE)

Takes a string and returns a date (a date ISO string that can be picked up by other functions). The returned date and time are localized to UTC.

* Takes 1 to 3 arguments.
* The first argument is a string representing a date.
* The second optional argument specifies custom format of the given date.
* Third argument determinate what units are used for flooring. Possible values are: s= seconds,  m= minutes and h= hours.

{% hint style="info" %}
For details on how to write the second parameter specifying the date format, please see the [Day.js Documentation](https://day.js.org/docs/en/parse/string-format).
{% endhint %}

```javascript
input = "12/25/2021"

[function] ---> [output]

DATE("2021-12-25T23:00")       ---> "2021-12-25T23:00"
DATE("12/25/2021")             ---> "2021-12-25T23:00"
DATE("12.25.2021")             ---> "2021-12-25T23:00"
DATE("2.20.2022 GMT+3")        ---> "2022-02-19T21:00"
DATE("2.20.2022 15:00 GMT+3")  ---> "2022-02-20T12:00"
DATE({input})                  ---> "2021-12-25T23:00"

DATE("18/06/2022T08:15","DD/MM/YYYYTHH:mm")  ---> 2022-06-18T06:15
DATE("18.06.2022 08:15 +03:00","DD.MM.YYYY HH:mm Z")  ---> 2022-06-18T05:15

DATE("18/06/2022T08:15:44","DD/MM/YYYYTHH:mm:ss", "s")  ---> 2022-06-18T06:15:44
DATE("18/06/2022T08:15:44","DD/MM/YYYYTHH:mm:ss", "m")  ---> 2022-06-18T06:15
DATE("18/06/2022T08:15:44","DD/MM/YYYYTHH:mm:ss", "h")  ---> 2022-06-18T06:00

DATE("1710510160000", "x") --> "2024-03-15T13:42"

DATE()                         ---> invalid
DATE(12/25/2021)               ---> invalid
```

{% hint style="warning" %}
Note that the function returns the result even for an invalid date as follows:

* The values for the day can take 1-31 (depending on the month). If the range is exceeded, it will bubble up to the next month.
* The values for the month can take 0-11 (Months are zero indexed, so January is month 0). If the range is exceeded, it will bubble up to the next year.
{% endhint %}

<pre class="language-javascript"><code class="lang-javascript">[function] ---> [output]

//Invalid day
DATE("2021-12-<a data-footnote-ref href="#user-content-fn-1">33</a>T22:00")       ---> "2022-01-02T21:00"
DATE("02/30/2022")             ---> "2022-03-01T23:00"

//Invalid month
DATE("2023-13-30T22:00")       ---> "2024-01-30T21:00"
DATE("2022-18-04T12:00")       ---> "2023-06-04T10:00"
</code></pre>

### Date difference (DATEDIFF)

Returns the number of specified time units between two dates. It may return negative or positive numbers, based on the order of the dates.

* Takes 3 arguments.
* The first and second argument is a date.
* The third argument specifies the time unit, as listed below.

```javascript
"s" -- seconds
"m" -- minutes
"H" -- hours
"D" -- days
"W" -- weeks
"M" -- months
"Y" -- years
```

```javascript
input = "01/02/2016"

[function] ---> [output]

DATEDIFF(DATE("01/31/2020"), DATE("01/31/2021"), "D")  ---> -366
DATEDIFF(DATE("01/31/2021"), DATE("01/31/2020"), "D")  ---> 366
DATEDIFF(DATE("01/31/2021"), DATE("01/31/2020"), "M")  ---> 12
DATEDIFF(DATE("01/31/2021"), DATE("01/31/2020"), "Y")  ---> 1
DATEDIFF(DATE({input}), DATE("12/30/2015"), "D")       ---> 3
```

### Date compute (DATE\_COMPUTE)

Takes a date and adds or subtracts a specified time.

* Takes 2 arguments.
* The first argument is a date (obtained from DATE or NOW).
* The second argument is the number of days to add.

```javascript
input = "12/01/2021"
[function] ---> [output]

DATE_COMPUTE(DATE("12/01/2021"), "+20") ---> "2021-12-21"
DATE_COMPUTE(DATE({input}), +20)        ---> "2021-12-21"
DATE_COMPUTE(DATE("12/30/2021"), "-20") ---> "2021-12-10"

DATE_COMPUTE(DATE("12/01/2021"))        ---> invalid
DATE_COMPUTE()                          ---> invalid
```

### Date Time compute (DATETIME\_COMPUTE)

Takes a date and adds or subtracts a specified time unit.

* Takes 3 arguments.
* The first argument is a date (obtained from DATE or NOW).
* The second argument is the number of units to add.
* Third argument specifies units (s= seconds, h= hours, M= month, m= minutes, y= years)

Output date format is: `YYYY-MM-DDTHH:mm:ss`

```javascript
input = "12/01/2021"
[function] ---> [output]

DATETIME_COMPUTE(DATE("12/01/2021 14:44 GMT+02:00", "DD/MM/YYYY HH:mm Z"), "+24", "h") ---> "2021-01-13T12:44:00"
DATETIME_COMPUTE(DATE({input}, "DD/MM/YYYY"), "+24", "m") ---> "2021-01-11T23:24:00"
DATETIME_COMPUTE(DATE("12/30/2021", "MM/DD/YYYY"), "-24", "h") ---> "2021-12-28T23:00:00"
DATETIME_COMPUTE(DATE("2002-11-25T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s"),"2","s") --> "2002-11-25T11:45:32"

//Example with timestamp
DATETIME_COMPUTE(DATE("1710510160000", "x"), "6", "h")

DATETIME_COMPUTE(DATE("12/01/2021", "DD/MM/YYYY"))  ---> invalid
DATETIME_COMPUTE()                          ---> invalid
```

{% hint style="info" %}
Notice that all return values are in UTC format. For the precise calculation specify date format in DATE function.
{% endhint %}

### Month (MONTH)

Gets the month of the year for a given date.

* Takes 1 argument.
* The argument is a date (obtained from DATE or NOW).

```javascript
input = "12/01/2021"
[function] ---> [output]

MONTH(DATE("12/01/2021"))            --> 12
MONTH(DATE({input}))                 --> 12

MONTH()                              --> invalid
```

### Year (YEAR)

Gets the year of a given date.

* Takes 1 argument.
* The argument is a date (obtained from DATE or NOW).

```javascript
input = "12/01/2021"

[function] ---> [output]

YEAR(DATE("12/31/2015"))            --> 2015
YEAR(DATE({input}))                 --> 2021

YEAR()                              --> invalid
```

### Weekday (WEEKDAY)

Finds the day of the week of the given date.

* Takes 1 argument.
* The argument is a date (obtained from DATE or NOW).

The WEEKDAY function returns a number from 0 (meaning Sunday) to 6 (meaning Saturday).

```javascript
input = "12/01/2021"

[function] ---> [output]

WEEKDAY(DATE("09/05/2022"))        --> 1 (Monday)
WEEKDAY(DATE({input}))             --> 3 (Wednesday)

WEEKDAY()                          --> invalid
```

### Date Max (DATE\_MAX)

Gets the maximum of inputted dates.

* Takes 1 argument.
* The argument is an array (or spread) date (obtained from DATE or NOW).

```javascript
[function] ---> [output]

DATE_MAX(
    DATE("2002-11-25T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s"), 
    DATE("2002-11-29T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s")
) --> "2002-11-29T11:45:30"

DATE_MAX([
    DATE("2002-11-25T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s"), 
    DATE("2002-11-29T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s")
]) --> "2002-11-29T11:45:30"

// Different date format example
DATE_MAX(
    DATE("2002/11/25 12:45:30", "YYYY/MM/DD HH:mm:ss", "s"), 
    DATE("2002/11/29 12:45:30", "YYYY/MM/DD HH:mm:ss", "s")
) --> "2002-11-29T11:45:30"
```

### Date Min (DATE\_MIN)

Gets the minimum of inputted dates.

* Takes 1 argument.
* The argument is an array (or spread) date (obtained from DATE or NOW).

```javascript
[function] ---> [output]

DATE_MIN(
    DATE("2002-11-25T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s"), 
    DATE("2002-11-29T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s")
) --> "2002-11-29T11:45:30"

DATE_MIN([
    DATE("2002-11-25T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s"), 
    DATE("2002-11-29T12:45:30", "YYYY-MM-DDTHH:mm:ss", "s")
]) --> "2002-11-29T11:45:30"

// Different date format example
DATE_MIN(
    DATE("2002/11/25 12:45:30", "YYYY/MM/DD HH:mm:ss", "s"), 
    DATE("2002/11/29 12:45:30", "YYYY/MM/DD HH:mm:ss", "s")
) --> "2002-11-29T11:45:30"
```

[^1]: 
