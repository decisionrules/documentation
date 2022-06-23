# Array Functions

## List of array functions

* ARRAY\_SUM
* ARRAY\_CONCAT
* ARRAY\_CONCAT\_WS
* ARRAY\_PICK

### Summation over an array of objects (ARRAY\_SUM)

Given an array of objects and a JSON path to certain (numeric) values nested inside these objects, the ARRAY\_SUM function sums these values and returns the sum.

* Requires 2 arguments: the array and the path.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying JSON path to the desired numeric values.
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### ARRAY\_SUM function examples:

```javascript
INPUT1 = [
    {"order":{"price":20}},
    {"order":{"price":30}},
    {"order":{"price":40}}
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

ARRAY_SUM({INPUT1}, "order.price")        --> 90
ARRAY_SUM({INPUT2}, "order[0].price")     --> 77
ARRAY_SUM({INPUT2}, "order[1].price")     --> 99
```

### Concatenation over an array of objects (ARRAY\_CONCAT)

Given an array of objects and a JSON path to certain (string) values nested inside these objects, the ARRAY\_CONCAT function concatenates these values and returns the concatenated string.

* Requires 2 arguments: the array and the path.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying JSON path to the desired string values.
* Since the path is a string, it should be enclosed in **""**.
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### ARRAY\_CONCAT function examples:

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

ARRAY_CONCAT({INPUT1}, "order.code")        --> "ABC"
ARRAY_CONCAT({INPUT2}, "order[0].code")     --> "A2A5"
ARRAY_CONCAT({INPUT2}, "order[1].code")     --> "B3B8"
```

### Concatenation over an array of objects with a separator (ARRAY\_CONCAT\_WS)

Given a separator, an array of objects and a JSON path to certain (string) values nested inside these objects, the ARRAY\_CONCAT\_WS function concatenates these values with the given separator and returns the concatenated string.

* Requires 3 arguments: the separator, the array and the path.
* The first argument must be a string separator.
* The second argument must be a variable or another function returning an array.
* The third argument must be a string specifying JSON path to the desired string values.
* String arguments should be enclosed in **""**.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### ARRAY\_CONCAT\_WS function examples:

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

ARRAY_CONCAT_WS("_", {INPUT1}, "order.code")        --> "A_B_C"
ARRAY_CONCAT_WS("_", {INPUT2}, "order[0].code")     --> "A2_A5"
ARRAY_CONCAT_WS(" ", {INPUT2}, "order[1].code")     --> "B3 B8"
```

### Pick values from and array of nested objects (ARRAY\_PICK)

Given an array of objects and a JSON path to certain (string) values nested inside these objects, the ARRAY\_PICK function picks these values and returns them in an array.

* Requires 2 arguments: the array and the path.
* The first argument must be a variable or another function returning an array.
* The second argument must be a string specifying JSON path to the desired string values.
* Since the path is a string, it should be enclosed in **""**.
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### ARRAY\_PICK function examples:

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



