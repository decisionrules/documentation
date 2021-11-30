---
description: Description of date operators used in decision tables
---

# Date operators

Every condition cell in [decision table](../decision-table-designer.md) can have a different operator. These are the general operators which you can choose from:

![](../../.gitbook/assets/rsz\_2.png)

## General information

By choosing any of the operators, date and time are set to **None,** and the time zone is set to **GTM+1:00.**

{% hint style="danger" %}
Without choosing a specific **Date** or **Time** (at least one), **** you can not save the condition!\
Even if you have a set **Time zone.**
{% endhint %}

![](<../../.gitbook/assets/image (20).png>)

By clicking on ![](<../../.gitbook/assets/image (26).png>) or ![](<../../.gitbook/assets/image (41).png>) modal window is shown, where you:white\_check\_mark:, if you want to set a specific **date** or **time.**

{% hint style="warning" %}
By :white\_check\_mark:selecting a date or time, a current date/time is set.
{% endhint %}

![Date select window](<../../.gitbook/assets/image (47).png>)

![Specific date select](<../../.gitbook/assets/image (32).png>)

### Request input format

Request input **must be** in a specific format, which is shown below. The order of date, time and timezone, does not affect the result.

```javascript
"date": "YYYY-MM-DD",
"time": "HH:MM",
"timezone": "+/-HH:MM"
```

## Equals Operator (=)

Compares two date values. The equal operator compares:

* Date

#### Equal Operator examples:

```javascript
[request value] = [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"         =    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-17"         date: "2021-03-17"
"time": null            =    time: null           //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "08:53"         =    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"         =    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"         =    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"
```

## Greater than OR Equal Operator (>=)

The greater than or equal operator (`>=`) returns `true` if the left operand is greater than or equal to the right operand, and `false` otherwise.

#### Greater than OR Equal Operator examples:

```javascript
[request value] >= [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"        >=    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "09:53"        >=    time: "08:53"        //true
"timezone": "+03:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": null           >=    time: null           //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "08:53"        >=    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "08:53"        >=    time: "10:53"        //false
"timezone": "+04:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": null           >=    time: null           //false
"timezone": "+04:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"        >=    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"        >=    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"
```

## Greater Operator (>)

The greater operator (`>`) returns `true` if the left operand is greater than the right operand, and `false` otherwise.

#### Greater Operator examples:

```javascript
[request value] > [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "09:53"         >    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"         >    time: "08:53"        //true
"timezone": "+03:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": null            >    time: null           //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "09:53"         >    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"         >    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "10:53"         >    time: "08:53"        //false
"timezone": "+04:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": null            >    time: null           //false
"timezone": "+04:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"         >    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"         >    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"
```

## Less than OR Equal Operator (<=)

The less than or equal operator (`<=`) returns `true` if the left operand is less than or equal to the right operand, and `false` otherwise.

#### Less than OR Equal Operator examples:

```javascript
[request value] <= [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"        <=    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "07:53"        <=    time: "08:53"        //true
"timezone": "+03:00"         timezone: "+01:00"

"date": "2021-03-10"         date: "2021-03-18"
"time": null           <=    time: null           //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "08:53"        <=    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "08:53"        <=    time: "10:53"        //false
"timezone": "-04:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": null           <=    time: null           //false
"timezone": "-04:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"        >=    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"        <=    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"
```

## Less than Operator (<)

The less than operator (`<`) returns `true` if the left operand is less than the right operand, and `false` otherwise.

#### Less than Operator examples:

```javascript
[request value] < [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "07:53"         <    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-10"         date: "2021-03-18"
"time": "08:53"         <    time: "08:53"        //true
"timezone": "+03:00"         timezone: "+01:00"

"date": "2021-03-10"         date: "2021-03-18"
"time": null            <    time: null           //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "07:53"         <    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"         <    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "07:53"         <    time: "08:53"        //false
"timezone": "-04:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": null            <    time: null           //false
"timezone": "-04:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"         <    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"         <    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"
```

## Not Equal Operator (<>)

Compares two dates. The not equal operator compares:

* Date

#### Not Equal Operator examples:

```javascript
[request value] <> [table value]

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"        <>    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-17"         date: "2021-03-17"
"time": null           <>    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-18"         date: "2021-03-18"
"time": "08:53"        <>    time: null           //false
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: "2021-03-18"
"time": "08:53"        <>    time: "08:53"        //false
"timezone": "+01:00"         timezone: "+01:00"

"date": "2021-03-20"         date: "2021-03-18"
"time": "08:53"        <>    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"

"date": null                 date: null            
"time": "10:53"        <>    time: "08:53"        //true
"timezone": "+01:00"         timezone: "+01:00"
```

## **Between** Operator (between)

The between operator (`between`) returns `true` if the left operand is between or equal to the right operand, and `false` otherwise.

#### Between Operator examples:

```javascript
[request value] between [table value]

                                  date: "2021-03-18"
                                  time: "08:53"
"date": "2021-05-18"              timezone: "+01:00"
"time": "08:53"         between           AND          //true
"timezone": "+01:00"              date: "2022-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"

 //---------------------------------------------------------- 

                                  date: "2021-03-18"
                                  time: "08:53"
"date": "2021-03-18"              timezone: "+01:00"
"time": "08:53"         between           AND          //true
"timezone": "+01:00"              date: "2021-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"

 //---------------------------------------------------------- 
 
                                  date: "2021-03-18"
                                  time: "08:53"
"date": "2021-05-18"              timezone: "+01:00"
"time": "14:53"         between           AND          //true
"timezone": "+05:00"              date: "2021-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"

 //---------------------------------------------------------- 
  
                                  date: null
                                  time: "08:53"
"date": null                      timezone: "+01:00"
"time": "14:53"         between           AND          //true
"timezone": "+01:00"              date: null
                                  time: "20:53"
                                  timezone: "+01:00"

 //----------------------------------------------------------
  
                                  date: "2021-03-18"
                                  time: null
"date": "2021-09-18"              timezone: "+01:00"
"time": null            between           AND          //true
"timezone": "+01:00"              date: "2022-03-18"
                                  time: null
                                  timezone: "+01:00"

 //---------------------------------------------------------- 
 
                                  date: "2021-03-18"
                                  time: "08:53"
"date": "1999-03-18"              timezone: "+01:00"
"time": "08:53"         between           AND          //false
"timezone": "+01:00"              date: "2021-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"

 //---------------------------------------------------------- 
 
                                  date: "2021-03-18"
                                  time: "08:53"
"date": "2021-06-18"              timezone: "+01:00"
"time": null            between           AND          //false
"timezone": "+01:00"              date: "2022-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"

 //---------------------------------------------------------- 
 
                                  date: "2021-03-18"
                                  time: "08:53"
"date": null                      timezone: "+01:00"
"time": "08:53"         between           AND          //false
"timezone": "+01:00"              date: "2022-03-18"
                                  time: "08:53"
                                  timezone: "+01:00"
```
