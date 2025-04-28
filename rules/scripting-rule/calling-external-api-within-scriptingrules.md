# Calling external API within ScriptingRules

## How to call an external API

{% hint style="info" %}
Please, keep in mind all data (response and request body HAS to be a valid JSON object)

We do not support other formats, yet.
{% endhint %}

Calling an external API is done with http methods exposed on DR class in ScriptingRules. Usage is extremely simple. Supported methods are:

* GET
* POST
* PUT
* PATCH
* DELETE

With syntax like this:

<pre class="language-javascript"><code class="lang-javascript"><strong>const getMethod = DR.http.get(&#x3C;URL>, [OPTIONS]);
</strong><strong>const postMethod = DR.http.post(&#x3C;URL>, &#x3C;DATA>, [OPTIONS]);
</strong><strong>const putMethod = DR.http.put(&#x3C;URL>, &#x3C;DATA>, [OPTIONS]);
</strong><strong>const patchMethod = DR.http.patch(&#x3C;URL>, &#x3C;DATA>, [OPTIONS]);
</strong><strong>const deleteMethod = DR.http.delete(&#x3C;URL>, [OPTIONS]);
</strong></code></pre>

Options schema:

```json
{
    "headers": {} //custom headers like key:value pair
}
```

## Error handling

Error handling can be with `try {} catch (e) {}` syntax or without. In that case your solver execution will fail at error and that error will be displayed in output side of the testbench.

Example of try catch syntax with DecisonRules external API calls in ScriptingRules

```javascript
try {
    const result = DR.http.get("myapiurl.com");
    
    output.resultValue = result.body;
} catch (e) {

    output.errorValue = e;
}
```

## Response object and how to work with it

Response object schema:

```javascript
{
    status: 200, // HTTP response status codes
    body: {}, // Response body
    config: {
        contacted_url: "myapi.com", // Called URL
        request_headers: {} // Request headers
    },
    response_headers: {}, // Response headers
    timestamp: 1661760778584 // Time of call as timestamp
}
```

From every call of external API you will receive response schema that contains all the information you might need. Extracting data from schema is easy as it is JavaScript object, hence you can work with that normally. In the example below is ScriptingRule code that is outputting response status and response body.

```javascript

try {

    const options = {
        headers: {
            "X-Name": "Joe",
            "X-Key": "12345XXXX"
        }
    }

    const response = DR.http.get("https://api.myapi.io", options);

    output.status = response.status;
    output.api_body = response.body;
} catch (e) {
    output.Error = e;
}

return output;
```

Please note that `output.status` and `output.api_body` are both part of rules `outputmodel`.

## Functionality limitations

By default API calls are limited by these parameters:

* maximum response size = 3000 bytes
* maximum request body size = 10000 bytes
* maximum possible redirects = 5
* timeout = 2 seconds

All of these can be configured in docker version of DecisionRules to match your needs capabilities. Please refer to [containers-environmental-variables.md](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md "mention")
