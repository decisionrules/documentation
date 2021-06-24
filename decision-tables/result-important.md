---
description: This change is affected by adding functions.
---

# RESULT - important

{% hint style="danger" %}
VERY important! 
{% endhint %}

## How to enter results in Decision Tables

When you are creating a rule in the Decision Tables, you have to enter the result in a particular way. All the results are taken as functions that are the reason why non-functional parameters have to be in **"..."** or **'...'**

## **Example**

### String

```text
"Hello"        --> valid
"not at home"  --> valid
"1,5"          --> valid
"1.5"          --> valid
'Hello'        --> valid
'not at home'  --> valid
'1,5'          --> valid
'1.5'          --> valid
Hello          --> invalid
f4r8           --> invalid

Number      --> 
Date        -->
Time        -->
Function    -->
```

### Numbers

```text
123    --> valid
1.2    --> valid
"1,5"  --> not a number (string)
"1.2"  --> not a number (string)
"22"   --> not a number (string)
'1,5'  --> not a number (string)
'1.2'  --> not a number (string)
'22'   --> not a number (string)
```

### Date and Time

```text
"15:00"                    --> valid (string)
"2021-06-16"               --> valid (string)
"2.20.2022 15:00 GMT+3"    --> valid (string)
'15:00'                    --> valid (string)
'2021-06-16'               --> valid (string)
'2.20.2022 15:00 GMT+3'    --> valid (string)

15:00                    --> invalid
2021-06-16               --> invalid
2.20.2022 15:00 GMT+3    --> invalid
```

