# Functions and JSON

DecisionRules supports mixing native functional expressions with JSON. On this page, we will shortly explain how to write these mixed functional/JSON expressions and provide one realistic example of their usage.

## Overview

In this section we give a brief overview of all the supported types of mixed functional/JSON expressions together with examples and recommendations for their use.

### Placement as key and value

Functional expressions can be passed as a value into an object.

```
{"animal":{data}}
```

They can also define the key.

```
{{data}:["dog","cat","bird"]}
```

{% hint style="info" %}
Since JSON only allows strings as keys, make sure that the dynamically generated key evaluates to a string. If not, it will be automatically casted to string, which might not make good sense. Also note that the key must be unique within the object.
{% endhint %}

### Placement inside an array

Functional expressions can also represent an element of an array.

```
["dog",{data},"bird"]
```

### Variables

In the above examples, we have passed a variable `data` inside the JSON. This can be any kind of [variable](./#variables) supported within functions. Mixed expressions even work with abstract function variables:

```
ARRAY_MAP({data}, "letter", {"letter": {letter}})
```

### Functions

We can of course use functions.

```
{"average": AVG(10,30)}
```

```
{1+2:"three"}
```

### Combinations

The above listed types of expressions can be arbitrarily combined.

```
{"animals": {data}, "number": COUNT({data})}
```



## Example

Suppose you have a rule **Delivery Price** with alias `delivery-price` which gives you the price of delivery based on package weight. Its input model is

```json
{
  "package": {
    "weight": {}
  }
}
```

and the output model is

```json
{
  "price": {},
  "currency": {},
  "deliveryInHours": {}
}
```

Now, imagine we wish to call this rule from a decision table. We can easily do that with the [**SOLVE**](integration-functions.md#solve-function) function. In the respective output cell where we want to get the result, we can write something like

```
SOLVE("delivery-price", {"package": {"weight": 12}})
```

Note that the object in the second argument of the SOLVE function corresponds to the input model of our **Delivery Price** rule. This is because it supplies the input data for it. The SOLVE function evaluates the rule and returns the output, which may look like this:

```json
[
  {
    "price": 28,
    "currency": "USD",
    "deliveryInHours": "24 Hours"
  }
]
```

Of course, the exact form and data returned depends on the **Delivery Price** rule itself. We could now take this output, process it with the help of [Data Functions](data.md) or [Array Functions](array.md) and return it in the outputs or use it in our next steps.

The interesting part comes when we want to pass some dynamic data to our **Delivery Price** rule. For example, imagine we have an input variable `packageWeight` and want to solve **Delivery Price** with the value from this variable. We can do that by simply writing the variable inside to the object:

```
SOLVE("delivery-price", {"package": {"weight": {packageWeight}}})
```

The variable `packageWeight` will be automatically interpreted and passed to the object, which will be then picked up by the SOLVE function and used as input for the **Delivery Price** rule.

But we can do much more than this. The JSON can be also mixed with arbitrary functions. For example, imagine we want to limit the `packageWeight` to be always greater than 10 before passing it to the SOLVE function. No problem, just write the appropriate function expression:

```
SOLVE("delivery-price", {"package": {"weight": MIN(10,{packageWeight})}})
```

Following this logic, it is possible to mix arbitrary functional expressions and JSON to get the desired behavior.

