# Array Functions

## List of array functions

* ARRAY\_PICK
* ARRAY\_MAP
* ARRAY\_REDUCE
* ARRAY\_FILTER
* ARRAY\_INCLUDES

#### Deprecated functions

* ARRAY\_AND
* ARRAY\_OR
* ARRAY\_SUM
* ARRAY\_CONCAT
* ARRAY\_CONCAT\_WS

### Pick values from and array of nested objects (ARRAY\_PICK)

Given an array of objects and a JSON path to certain (string) values nested inside these objects, the ARRAY\_PICK function picks these values and returns them in an array.

* Requires 2 arguments: the array and the path.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying JSON path to the desired string values.

{% hint style="info" %}
The JSON path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = [
    {"order":{"code":"A"}},
    {"order":{"code":"B"}},
    {"order":{"code":"C"}}
  ]
 
INPUT2 = [
    {"order": [
        {"code":"A2", "price":22},
        {"code":"B3", "price":11}
               ]
    },
    {"order": [
        {"code":"A5", "price":55},
        {"code":"B8", "price":88}
        ]
    }
  ]
 
[function] --> [output]

ARRAY_PICK({INPUT1}, "order.code")        --> ["A", "B", "C"]
ARRAY_PICK({INPUT2}, "order[0].code")     --> ["A2", "A5"]
ARRAY_PICK({INPUT2}, "order[1].price")    --> [11, 88]
```

### Map array to another array (ARRAY\_MAP)

Thanks to ARRAY\_MAP, you can transform an array of values or objects to another array. Given an array and a representation of a custom function of a single argument, the ARRAY\_MAP function applies the custom function to every element of the given array and returns the resulting array.

* Requires 3 arguments: the array, name of a custom argument and a custom function.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying the name of a custom argument.
* The third argument must be a function of the custom argument.

```javascript
INPUT = [1,2,3]
 
[function] --> [output]

ARRAY_MAP({INPUT}, "x", SUM({x},1))   --> [2,3,4]
ARRAY_MAP({INPUT}, "z", TIMES(3,{z})) --> [3,6,9]
ARRAY_MAP({INPUT}, "element", CONCAT_WS(" ", "number", {element}))
                                      --> ["number 1","number 2","number 3"]
```

### Reduce array with custom function (ARRAY\_REDUCE)

Thanks to ARRAY\_REDUCE, you can reduce an array of values to a single value. Given an array and a representation of a custom function of 2 arguments, the ARRAY\_REDUCE function applies the custom function successively (to the first couple of elements, to the result and the third element, to the result and the fourth element, etc.) and returns the resulting value.

* Requires 4 arguments: the array, 2 names of custom arguments and a custom function.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying the name of the first custom argument.
* The third argument must be a string specifying the name of the second custom argument.
* The last, fourth argument must be a function of the 2 custom arguments.

```javascript
INPUT1 = [1,2,3,4]
INPUT2 = [true,true,false]
 
[function] --> [output]

ARRAY_REDUCE({INPUT1}, "x", "y", SUM({x},{y}))     --> 10
ARRAY_REDUCE({INPUT1}, "a", "b", TIMES({a},{b}))   --> 24
ARRAY_REDUCE({INPUT1}, "word1", "word2", CONCAT_WS("_",{word1},{word2}))
                                                   --> "1_2_3_4"
ARRAY_REDUCE({INPUT2}, "a", "b", AND({a},{b}))     --> false
ARRAY_REDUCE({INPUT2}, "a", "b", OR({a},{b}))      --> true
```

### Filter array with custom function (ARRAY\_FILTER)

The ARRAY\_FILTER function filters an array based on a custom function and returns another array with a subset of the elements of the original array.

* Requires 3 arguments: the array, a name of a custom argument and a custom function.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying the name of the custom argument.
* The third argument must be a function of the custom argument returning a boolean value.

```javascript
INPUT1 = [1,8,12,4]

INPUT2 = [
    {"code":"A","quantity":"1"}
    {"code":"B","quantity":"4"}
    {"code":"A","quantity":"3"}
    {"code":"B","quantity":"5"}
  ]
 
[function] --> [output]

ARRAY_FILTER({INPUT1}, "x", LT({x},5))    --> [1,4]
ARRAY_FILTER({INPUT2}, "a", EQ(PICK({a},"code"),"B"))
--> [
      {"code":"B","quantity":"4"}
      {"code":"B","quantity":"5"}
    ]
```

### Check if array includes an element (ARRAY\_INCLUDES)

Checks whether an array includes a given element.

* Requires 2 arguments: the array and the element to search for.
* The first argument must be a variable or another function returning an array.
* The second argument can have any value.

```javascript
INPUT = [
    {"code":"A","quantity":"1"}
    {"code":"B","quantity":"4"}
    {"code":"A","quantity":"3"}
    {"code":"B","quantity":"5"}
  ]
 
[function] --> [output]

ARRAY_INCLUDES([1,5,10],6)                              --> false
ARRAY_INCLUDES([1,5,10],5)                              --> true
ARRAY_INCLUDES({INPUT},{"code":"A","quantity":"3"})     --> true
```



### Summation over an array (ARRAY\_SUM) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use SUM instead (if you need to get nested values, you can use SUM in combination with ARRAY\_PICK).
{% endhint %}

Given an array of numeric values (or alternatively objects), ARRAY\_SUM returns their sum.

* Requires 1 argument, the array.
* The argument must be a variable or another function returning an array.
* There can be a second optional argument of type string specifying JSON path to numeric values nested within the elements of the array (in case they are objects).
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = [1,2,3]

INPUT2 = [
    {"order":{"price":20}},
    {"order":{"price":30}},
    {"order":{"price":40}}
  ]
 
INPUT3 = [
    {"order": [
        {"code":"A2", "price":22},
        {"code":"B3", "price":11}
               ]
    },
    {"order": [
        {"code":"A5", "price":55},
        {"code":"B8", "price":88}
        ]
    }
  ]
 
[function] --> [output]

ARRAY_SUM({INPUT1})                       --> 6
ARRAY_SUM({INPUT2}, "order.price")        --> 90
ARRAY_SUM({INPUT3}, "order[0].price")     --> 77
ARRAY_SUM({INPUT3}, "order[1].price")     --> 99
```

### Concatenation over an array (ARRAY\_CONCAT) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use CONCAT instead (if you need to get nested values, you can use CONCAT in combination with ARRAY\_PICK).
{% endhint %}

Given an array of string values (or alternatively objects), the ARRAY\_CONCAT function concatenates these values and returns the concatenated string.

* Requires 1 argument, the array.
* The argument must be a variable or another function returning an array.
* There can be a second optional argument of type string specifying JSON path to numeric values nested within the elements of the array (in case they are objects).
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = ["a","b","c"]

INPUT2 = [
    {"order":{"code":"A"}},
    {"order":{"code":"B"}},
    {"order":{"code":"C"}}
  ]
 
INPUT3 = [
    {"order": [
        {"code":"A2", "price":22},
        {"code":"B3", "price":11}
               ]
    },
    {"order": [
        {"code":"A5", "price":55},
        {"code":"B8", "price":88}
        ]
    }
  ]
 
[function] --> [output]

ARRAY_CONCAT({INPUT1})                      --> "abc"
ARRAY_CONCAT({INPUT3}, "order[0].code")     --> "A2A5"
ARRAY_CONCAT({INPUT3}, "order[1].code")     --> "B3B8"
```

### Concatenation over an array with a separator (ARRAY\_CONCAT\_WS) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use CONCAT\_WS instead (if you need to get nested values, you can use CONCAT\_WS in combination with ARRAY\_PICK).
{% endhint %}

Given a separator and an array of string values (or alternatively objects), the ARRAY\_CONCAT\_WS function concatenates these values with the given separator and returns the concatenated string.

* Requires 2 arguments: the separator and the array.
* The first argument must be a string separator.
* The second argument must be a variable or another function returning an array.
* There can be a third optional argument of type string specifying JSON path to numeric values nested within the elements of the array (in case they are objects).
* String arguments should be enclosed in **""**.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = ["a","b","c"]

INPUT2 = [
    {"order":{"code":"A"}},
    {"order":{"code":"B"}},
    {"order":{"code":"C"}}
  ]
 
INPUT3 = [
    {"order": [
        {"code":"A2", "price":22},
        {"code":"B3", "price":11}
               ]
    },
    {"order": [
        {"code":"A5", "price":55},
        {"code":"B8", "price":88}
        ]
    }
  ]
 
[function] --> [output]

ARRAY_CONCAT_WS("_", {INPUT1})                      --> "a_b_c"
ARRAY_CONCAT_WS("_", {INPUT2}, "order.code")        --> "A_B_C"
ARRAY_CONCAT_WS("_", {INPUT3}, "order[0].code")     --> "A2_A5"
ARRAY_CONCAT_WS(" ", {INPUT3}, "order[1].code")     --> "B3 B8"
```

### Logical conjunction over an array (ARRAY\_AND) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use AND instead (if you need to get nested values, you can use AND in combination with ARRAY\_PICK).
{% endhint %}

Given an array of boolean values (or alternatively objects), ARRAY\_AND returns their logical conjunction.

* Requires 1 argument, the array.
* The argument must be a variable or another function returning an array.
* There can be a second optional argument of type string specifying JSON path to numeric values nested within the elements of the array (in case they are objects).
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = [true,true,false]

INPUT2 = [
    {"order":{"sent":true}},
    {"order":{"sent":true}},
    {"order":{"sent":true}}
  ]
 
[function] --> [output]

ARRAY_AND({INPUT1})                   --> false
ARRAY_AND({INPUT2}, "order.sent")     --> true
```

### Logical disjunction over an array (ARRAY\_OR) (deprecated)

{% hint style="warning" %}
This function is deprecated. Use OR instead (if you need to get nested values, you can use OR in combination with ARRAY\_PICK).
{% endhint %}

Given an array of boolean values (or alternatively objects), ARRAY\_OR returns their logical disjunction.

* Requires 1 argument, the array.
* The argument must be a variable or another function returning an array.
* There can be a second optional argument of type string specifying JSON path to numeric values nested within the elements of the array (in case they are objects).
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

```javascript
INPUT1 = [true,false,false]

INPUT2 = [
    {"order":{"sent":false}},
    {"order":{"sent":false}},
    {"order":{"sent":false}}
  ]
 
[function] --> [output]

ARRAY_OR({INPUT1})                   --> true
ARRAY_OR({INPUT2}, "order.sent")     --> false
```

