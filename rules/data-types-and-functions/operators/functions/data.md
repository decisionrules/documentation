# Data Functions

## List of data functions

* PICK
* RAW\_VALUE

### Pick a value from an array or object (PICK)

Given an array or object and a JSON path to certain value inside it, the PICK function picks this value and returns it.

* Takes 2 arguments, the array / object and the path.
* The first argument must be a variable or another function returning the object or array.
* The second argument must be a string specifying JSON path to the desired string values.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### PICK function examples:

```javascript
input1 = {"order":{"code":"A"}}

input2 = ["A", "B", "C"]

input3 = { "order": [ {"code":"A2", "price":22}, {"code":"B3", "price":11} ] }
 
[function] --> [output]

PICK({input1}, "order.code")        --> "A"
PICK({input2}, "[2]")               --> "C"
PICK({input3}, "order[0].code")     --> "A2"
PICK({input3}, "order[1].price")    --> 11
```

### Keep the same type without auto-casting (RAW\_VALUE)

For the given argument, it ignores auto-casting and the return value of the same type. In most cases, we want to call this function first, because the output of the function cell is automatically auto-casted, and this function prevents this behaviour.

* Take 1 argument of any type

#### RAW\_VALUE function examples:

```javascript
[function] --> [output]

RAW_VALUE(true)                  -->    true
RAW_VALUE(false)                 -->    false
RAW_VALUE("0001")                -->    "0001"
RAW_VALUE(11)                    -->    11
RAW_VALUE(null)                  -->    null
RAW_VALUE(TEXT(true))            -->    "true"
RAW_VALUE({"a": 10, "b": 20})    -->    {"a": 10, "b": 20}
RAW_VALUE(["a", "b", 1, 2])      -->    ["a", "b", 1, 2]
```
