# Date and Time Functions

## List of date and time functions

* NOW
* CURDATE
* CURTIME
* DATE
* DATEDIFF
* DATE\_COMPUTE

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

* Must have 1 parameter.
* DATE can be a part of an embedded function.

{% hint style="warning" %}
The date format is MM.DD.YYYY
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
DATE_COMPUTE(DATE(01.30.2020), -20) ---> 2020-01-20
DATE_COMPUTE(DATE({INPUT}), +20)    ---> 2020-02-10
DATE_COMPUTE(DATE({INPUT}), x)      ---> invalid
DATE_COMPUTE(DATE(01.30.2020))      ---> invalid
DATE_COMPUTE()                      ---> invalid
```

### Date difference function (DATEDIFF)

The DATEDIFF function returns the number of days/months/years between two dates.

* Must have 3 parameters DATE, DATE and time unit (D-day, M-month, Y-year)
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
