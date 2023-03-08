# Integration functions

## List of Integration functions

* SOLVE
* HTTP\_GET
* HTTP\_POST
* HTTP\_PUT
* HTTP\_PATCH
* HTTP\_DELETE

## Solve function (SOLVE)

The SOLVE function has the ability to call any other rule within your space and retrieve the output of the rule depending on the provided input data.

* Takes 2 or 3 arguments.
* The first argument is the rule ID or alias of the rule you would like to call.
* The second argument is the object containing input data for the rule you are trying to solve.
* The third optional argument is an object specifying further options like execution strategy, version of the rule or JSON path to the value you want to return.

{% hint style="info" %}
If you are using alias, make sure it is unique in your space, otherwise the solve will fail.
{% endhint %}

{% hint style="info" %}
Note that when specifying the input data object, you can take advantage of our [Functions in JSON](functions-and-json.md) notation to specify dynamical values in your data.
{% endhint %}

```
SOLVE("rule-id", {"foo":"bar"})

SOLVE("rule-alias", {"foo":"bar"})

SOLVE("rule-id",
    {"foo":"bar"}, 
    {"version": "1","strategy":"FIRST_MATCH","path":"person.name"}
)
```

### Examples

The below provided decision table contains examples for the SOLVE function. Import the decision table to your space to review them. For the examples to actually work, you will also need to import another decision table which will be called via the SOLVE function. This dependent table is also provided below.

{% file src="../../.gitbook/assets/Solve_Example_v1.json" %}

Take care to import the following dependent table only **once**, otherwise the provided examples will not work. For the SOLVE function to work, it must be given rule ID or a unique alias.

{% file src="../../.gitbook/assets/Plant_Items_Example_v1.json" %}

### Version

Defines the version of the rule you want to call. If not specified, the SOLVE function calls the latest published version.

### Strategy

If you are solving a decision table, you can use the `strategy` option to specify one of the existing execution strategies. The allowed values are as follows.

```
STANDARD
ARRAY
FIRST_MATCH
EVALUATE_ALL
```

Their effect is described at the [Execution Strategy](../../other/execution-strategy.md) page.

### Path

The `path` option allows you to reach for a value inside the output data returned when the desired rule is solved. It takes a string specifying the JSON path to the value you want to retrieve. For example, suppose that the output of the rule is the following.

```
[
    {
        person: {
            name: "Joe" 
        }
    }
]
```

Then you can use `"path":"person.name"`. As a result, your solve function will only return

```
"Joe"
```

and not the whole object above. Therefore, the `path` option is handy when you want to get just a small portion of the output.

If you are calling a decision table, note that the `path` option will have different effect for different [execution strategies](../../other/execution-strategy.md). Below, we will describe the behavior for each of them in detail.

#### First Match

The the `path` option behaves as expected with the First Match strategy. It reaches inside the returned output object, as shown in the example above.

#### Standard and Evaluate All

For these strategies, the output is an array that may contain more than one element with output data, depending on how many (passing) rows you have in your decision table.

The path will always look into **the first element** of the array. For example, if the whole output of the called table is

```
[
    {
        person: {
            name: "Joe" 
        }
    },
    {
        person: {
            name: "Jane" 
        }
    }
]
```

and we use `"path":"person.name"`, the solve function will simply return

```
"Joe"
```

and it will ignore the other matched rows.

#### Array

In case of the Array Strategy, the output data take another form. They may look for example as follows.

```
[
    {
        person: {
            name: ["Joe","Jane"] 
        }
    }
]
```

By using `"path":"person.name"`, we tell the SOLVE function to unpack the name attribute for us, and it will return

```
["Joe","Jane"]
```

Therefore, if you are interested in an array of values where each value comes from one of the outputted rows of the solved decision table, you may use the SOLVE function with the Array Strategy and the `path` option.

{% hint style="info" %}
If you need some more complex transformation of the output data, you may be able to perform it with the help of [Data Functions](data.md) or [Array Functions](array.md).
{% endhint %}



## HTTP functions

### HTTP\_GET

HTTP\_GET _function can perform classic GET request with given URL._ HTTP\_GET returns JSON object of called API.

#### Syntax

The HTTP\_GET function syntax has the following arguments:

* **URL** - Required. Target url.
* **OPTIONS** - Optional. Object of optional arguments that can enhance HTTP request. Only available options at this moment is `headers` object that can contain custom request headers that are appended to request before sending.

#### Examples

**1) HTTP\_GET **<mark style="color:orange;">**without**</mark>** options**

```
HTTP_GET("my.api.com")
```

**2) HTTP\_GET **<mark style="color:blue;">**with**</mark>** options**

```
HTTP_GET("my.api.com", {"headers": {"X-DEMO": "1"}})
```

### HTTP\_POST

HTTP\_POST _function can perform classic POST request with given URL and request DATA._ HTTP\_POST returns JSON object of called API.

#### Syntax

The HTTP\_POST function syntax has the following arguments:

* **URL** - Required. Target url.
* **DATA** - Required. Request body as valid JSON object.
* **OPTIONS** - Optional. Object of optional arguments that can enhance HTTP request. Only available options at this moment is `headers` object that can contain custom request headers that are appended to request before sending.

#### Examples

**1) HTTP\_POST **<mark style="color:orange;">**without**</mark>** options**

```
HTTP_POST("my.api.com", {"foo":"bar"})
```

**2) HTTP\_POST **<mark style="color:blue;">**with**</mark>** options**

```
HTTP_POST("my.api.com", {"foo":"bar"}, {"headers": {"X-DEMO": "1"}})
```

### HTTP\_PATCH

HTTP\_PATCH _function can perform classic_ PATCH _request with given URL and request DATA._ HTTP\_PATCH returns JSON object of called API.

#### Syntax

The HTTP\_PATCH function syntax has the following arguments:

* **URL** - Required. Target url.
* **DATA** - Required. Request body as valid JSON object.
* **OPTIONS** - Optional. Object of optional arguments that can enhance HTTP request. Only available options at this moment is `headers` object that can contain custom request headers that are appended to request before sending.

#### Examples

**1) HTTP\_PATCH **<mark style="color:orange;">**without**</mark>** options**

```
HTTP_PATCH("my.api.com", {"foo":"bar"})
```

**2) HTTP\_PATCH **<mark style="color:blue;">**with**</mark>** options**

```
HTTP_PATCH("my.api.com", {"foo":"bar"}, {"headers": {"X-DEMO": "1"}})
```

### HTTP\_PUT

HTTP\_PUT _function can perform classic_ PUT _request with given URL and request DATA._ HTTP\_PUT returns JSON object of called API.

#### Syntax

The HTTP\_PUT function syntax has the following arguments:

* **URL** - Required. Target url.
* **DATA** - Required. Request body as valid JSON object.
* **OPTIONS** - Optional. Object of optional arguments that can enhance HTTP request. Only available options at this moment is `headers` object that can contain custom request headers that are appended to request before sending.

#### Examples

**1) HTTP\_PUT **<mark style="color:orange;">**without**</mark>** options**

```
HTTP_PUT("my.api.com", {"foo":"bar"})
```

**2) HTTP\_PUT **<mark style="color:blue;">**with**</mark>** options**

```
HTTP_PUTH("my.api.com", {"foo":"bar"}, {"headers": {"X-DEMO": "1"}})
```

### HTTP\_DELETE

HTTP\_DELETE _function can perform classic GET request with given URL._ HTTP\_DELETE returns JSON object of called API.

#### Syntax

The HTTP\_DELETE function syntax has the following arguments:

* **URL** - Required. Target url.
* **OPTIONS** - Optional. Object of optional arguments that can enhance HTTP request. Only available options at this moment is `headers` object that can contain custom request headers that are appended to request before sending.

#### Examples

**1) HTTP\_DELETE **<mark style="color:orange;">**without**</mark>** options**

```
HTTP_DELETE("my.api.com")
```

**2) HTTP\_DELETE **<mark style="color:blue;">**with**</mark>** options**

```
HTTP_DELETE("my.api.com", {"headers": {"X-DEMO": "1"}})
```
