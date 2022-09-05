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

### Time and date right now function (NOW)

The NOW function returns the current date and time.

* Maximum 1 parameter which is a time zone (not necessary).
* NOW can be a part of an embedded function.

#### NOW function examples:

```javascript
INPUT = "+02:00"
[function] ---> [output]

NOW()              ---> 2021-06-01T11:01
NOW("+08:00")      ---> 2021-06-01T19:01
NOW("-08:00")      ---> 2021-06-01T03:01
NOW({INPUT})       ---> 2021-06-01T13:01
NOW(+08:00)        ---> invalid
NOW(1)             ---> invalid
NOW(1, 2)          ---> invalid
NOW(xx)            ---> invalid
NOW("xx")          ---> invalid
```

### Current date function (CURDATE)

The CURDATE function returns the current date.

* Maximum 1 parameter which is a time zone (not necessary).
* CURDATE can be a part of an embedded function.

#### CURDATE function examples:

```javascript
INPUT = "+02:00"
CURRENT TIME = "14:00"
TIME ZONE = "UTC-00:00"
[function] ---> [output]

CURDATE()              ---> 2021-06-01
CURDATE("+08:00")      ---> 2021-06-01
CURDATE("-02:00")      ---> 2021-06-01
CURDATE({INPUT})       ---> 2021-06-01
CURDATE("+10:00")      ---> 2021-07-01
CURDATE(+02:00)        ---> invalid
CURDATE(1)             ---> invalid
CURDATE(1, 2)          ---> invalid
CURDATE(xx)            ---> invalid
CURDATE("xx")          ---> invalid
```

### Current time function (CURTIME)

The CURDATE function returns the current time.

* Maximum 1 parameter which is a time zone (not necessary).
* CURTIME can be a part of an embedded function.

#### CURTIME function examples:

```javascript
INPUT = "+02:00"
[function] ---> [output]

CURTIME()              ---> 11:16
CURTIME("-02:00")      ---> 09:16
CURTIME("+08:00")      ---> 19:16
CURTIME({INPUT})       ---> 13:16
CURTIME(+02:00)        ---> invalid
CURTIME(1)             ---> invalid
CURTIME(1, 2)          ---> invalid
CURTIME(xx)            ---> invalid
CURTIME("xx")          ---> invalidx
```

### String to date function (DATE)

The DATE function convert string to date.

* Must have 1 or 2 parameters.
* The first parameter takes the string representing a date.
* The second parameter is optional and specifies custom format of the given date.
* DATE can be a part of an embedded function.

{% hint style="info" %}
For details on how to write the second parameter specifying the date format, please see the [Day.js Documentation](https://day.js.org/docs/en/parse/string-format).
{% endhint %}

#### DATE function examples:

```javascript
INPUT = 12.25.2021
[function] ---> [output]

DATE("12/25/2021")             ---> 2021-12-25T23:00
DATE(12.25.2021)               ---> 2021-12-25T23:00
DATE("12.25.2021")             ---> 2021-12-25T23:00
DATE("2.20.2022 GMT+3")        ---> 2022-02-19T21:00
DATE("2.20.2022 15:00 GMT+3")  ---> 2022-02-20T12:00
DATE({INPUT})                  ---> 2021-12-25T23:00

DATE("18/06/2022T08:15","DD/MM/YYYYTHH:mm")  ---> 2022-06-18T06:15
DATE("18.06.2022 08:15 +03:00","DD.MM.YYYY HH:mm Z")  ---> 2022-06-18T05:15

DATE()                         ---> invalid
DATE(12/25/2021)               ---> invalid
```

### Date computation function (DATE\_COMPUTE)

The DATE function adds or subtracts a specified time interval to a date.

* Must have 2 parameters DATE and +/- days.
* DATE\_COMPUTE can be a part of an embedded function.

{% hint style="warning" %}
The date format is MM.DD.YYYY
{% endhint %}

#### DATE\_COMPUTE function examples:

```javascript
INPUT = 01.21.2020
[function] ---> [output]

DATE_COMPUTE(DATE(01.01.2020), +20) ---> 2020-01-21
DATE_COMPUTE(DATE(01.30.2020), -20) ---> 2020-01-10
DATE_COMPUTE(DATE({INPUT}), +20)    ---> 2020-02-10
DATE_COMPUTE(DATE({INPUT}), x)      ---> invalid
DATE_COMPUTE(DATE(01.30.2020))      ---> invalid
DATE_COMPUTE()                      ---> invalid
```

### Day (DAY)

Gets the day of the month for a specific date

**Function parameters:**

1. Date - must be date from **Date function.**  Also works with all Date formats

#### DAY function examples:

```javascript
INPUT = 01.31.2020
[function] ---> [output]

DAY(DATE("12/31/2015"))            --> 31 
DAY()                              --> null
DAY(DATE({INPUT}))                 --> 31 
```

### Month (MONTH)

Gets month from a specific date

**Function parameters:**

1. Date - must be date from **Date function.**  Also works with all Date formats

#### Month function examples:

```javascript
INPUT = 01.31.2020
[function] ---> [output]

MONTH(DATE("12/31/2015"))            --> 12
MONTH()                              --> null
MONTH(DATE({INPUT}))                 --> 1 
```

### Year (YEAR)

Gets the year from a specific date

**Function parameters:**

1. Date - must be date from **Date function.**  Also works with all Date formats

#### Function examples:

```javascript
INPUT = 01.31.2020
[function] ---> [output]

YEAR(DATE("12/31/2015"))            --> 2015
YEAR()                              --> null
YEAR(DATE({INPUT}))                 --> 2020 
```

### Week day (WEEKDAY)

Finds the day of the week based on the date

**Function parameters:**

1. Date - must be date from **Date function.**  Also works with all Date formats

* 0 - Sunday
* 1 - Monday
* 2 - Tuesday
* 3 - Wednesday
* 4 - Thursday
* 5 - Friday
* 6 - Saturday

#### Function examples:

```javascript
INPUT = 01.31.2020
[function] ---> [output]

WEEKDAY(DATE("09/05/2022"))             --> 1  (see the list above: Monday)
WEEKDAY()                               --> null
WEEKDAY(DATE({INPUT}))                  --> 5   (see the list above: Friday)
```

### Date difference function (DATEDIFF)

The DATEDIFF function returns the number of days/months/years between two dates.

* Must have 3 parameters DATE, DATE and time unit (s-second, m-minute, H-hour, D-day, M-month, Y-year)
* DATEDIFF can return negative or positive numbers, based on the order of the dates
* DATEDIFF can be a part of an embedded function.

{% hint style="warning" %}
The date format is MM.DD.YYYY
{% endhint %}

#### DATEDIFF function examples:

```javascript
INPUT = 01.31.2020
[function] ---> [output]

DATEDIFF(DATE(01.31.2020), DATE(01.31.2021), D)  ---> -366
DATEDIFF(DATE(01.31.2021), DATE(01.31.2020), D)  ---> 366
DATEDIFF(DATE(01.31.2021), DATE(01.31.2020), M)  ---> 12
DATEDIFF(DATE(01.31.2021), DATE(01.31.2020), Y)  ---> 1
DATEDIFF(DATE({INPUT}), DATE(01.28.2020), D)     ---> 3
DATEDIFF(xx, xx), D)                             ---> invalid
```
