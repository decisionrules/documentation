# Integration functions

## List of Integration functions

* SOLVE
* HTTP\_GET
* HTTP\_POST
* HTTP\_PUT
* HTTP\_PATCH
* HTTP\_DELETE

## Solve function

Solve function has the ability to call all types of DecisionRules rules and retrieve solved output model depending on input of the function. Input is defined as called rule input model.

### Syntax

The SOLVE function syntax has the following arguments:

* **RuleID** - Required. The rule ID of the target rule. You can also use **rule alias**. In that case, make sure that the rule alias is unique within the space, otherwise the request will fail.
* **Data** - Required. Input model of target rule as valid JSON.
* **Options** - Optional. Object of optional parameters that can more specify solving process. Options can contain parameters as _**strategy**_ (specifies solving strategy that can be used for rules solving, more can be found here [execution-strategy.md](../../other/execution-strategy.md "mention"), _**version**_ (specifies version of target rule)and _**path**_ (can be used to parse output model that is on ouput of Solve function, value of path parameter is string that represents dot notation path to desired value \[more in examples])

### Examples

**1) SOLVE function **<mark style="color:orange;">**without**</mark>** options**

<pre><code><strong>SOLVE("rule-id", {"foo":"bar"})
</strong></code></pre>

Function with this implementation takes target RuleID and defined input model and returns output model.

**2) SOLVE function **<mark style="color:blue;">**with**</mark>** options**

```
SOLVE("rule-id", 
    {"foo":"bar"}, 
    {"version": "1", "strategy": "ARRAY", "path":"person.name"}
)
```

Function with this implementation takes target RuleID and defined input model and applies defined strategy, version on solver that modifies output model. Afterwards, path arguments takes care of processing returned output model by solver, take just desired values and then passes it to the user.

**3) Path argument in more detail**

Lets take example rule output model that looks like this (this can be from DecisionTable, ScriptingRule, RuleFlow or DecisionTree):&#x20;

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

Imagine we use `path` argument with value: `"person.name"` then the function return value is "Joe".&#x20;

{% hint style="info" %}
Its `"Joe"` because path argument works only with **FIRST** occurrence in output array (like if you used FIRST\_MATCH strategy). If you want more values from more response objects you can use ARRAY strategy and path argument will return an array containing all matched values. In our case it would be `["Joe", "Jane"]`
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
