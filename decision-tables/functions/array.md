# Data Functions

## List of data functions

* PICK

### Pick values from and array or object (PICK)

Given an array or object and a JSON path to certain value inside it, the PICK function picks this value and returns it in an array.

* Requires 2 arguments: the array / object and the path.
* The first argument must be a variable or another function returning the object or array.
* The second argument must be a string specifying JSON path to the desired string values.
* Since the path is a string, it should be enclosed in **""**.
* Can be a part of an embedded function.

{% hint style="info" %}
The json path is simply the sequence of keys separated by dots. You can access elements in an array by writing the index of the element in square brackets behind the key pointing to that array. Note that elements in an array are indexed from 0! For example, animals\[0] points to the first element of the animals array.
{% endhint %}

#### PICK function examples:

```javascript
INPUT1 = {"order":{"code":"A"}}

INPUT2 = ["A", "B", "C"]

INPUT3 = { "order": [ {"code":"A2", "price":22}, {"code":"B3", "price":11} ] }
 
[function] --> [output]

PICK({INPUT1}, "order.code")        --> "A"
PICK({INPUT2}, "[2]")               --> "C"
PICK({INPUT3}, "order[0].code")     --> "A2"
PICK({INPUT3}, "order[1].price")    --> 11
```

