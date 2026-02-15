# Supported Data Types

## Data types in Decision Tables

All data in a decision table is stored as string values and is automatically cast when needed. Therefore, you don’t need to specify any data format for your[ input and output models](../common-rule-features/input-and-output/). The automatic casting of conditions and results is described in the following sections.

### Condition Data Types

Conditions can be created using the following scalar data types:

* Number
* Boolean
* String
* Date

And collection data types:

* JSON Array

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-05 at 15.09.10.png" alt=""><figcaption><p>examples of entry conditions</p></figcaption></figure>

{% hint style="warning" %}
The decimal separator is **always a dot**: **`5.5`**
{% endhint %}

#### Solver Request Data Example

The inputs below demonstrate the format in which you can send a request to match a particular row:

1.  **Number:**

    ```json
    {
      "input": "2.31"
    }
    ```

    or

    ```json
    {
      "input": 2.31
    }
    ```
2.  **Boolean (True):**

    ```json
    {
      "input": true
    }
    ```

    or

    ```json
    {
      "input": "true"
    }
    ```
3.  **Boolean (False):**

    ```json
    {
      "input": false
    }
    ```

    or

    ```json
    {
      "input": "false"
    }
    ```
4.  **String:**

    ```json
    {
      "input": "hello world"
    }
    ```
5.  **Date and Time:**

    ```json
    {
      "input": "2024-09-23 13:27 +02:00"
    }
    ```

    or as extended ISO-8601:

    ```json
    {
      "input": "2024-09-23T13:27:00+02:00"
    }
    ```
6.  **Array:**

    ```json
    {
      "input": ["first", 2, false]
    }
    ```
7.  **Empty Value:**

    ```json
    {
      "input": ""
    }
    ```

{% hint style="danger" %}
The data cells now convert dates to strings. The **old object format is deprecated** but still supported. For example, the input:

<pre class="language-json"><code class="lang-json"><strong>{
</strong><strong>"input": {
</strong><strong>    "date": "2024-09-23",
</strong><strong>    "time": "13:27",
</strong><strong>    "timezone": "+02:00"
</strong><strong>    }
</strong><strong>}   
</strong></code></pre>

**will match** the new condition `2024-09-23 13:27 +02:00`.

Read more about [Date cells in the dedicated section.](operators/date-operators.md#date-cell-values)
{% endhint %}

#### Examples:

<table><thead><tr><th width="308.3333333333333">Condition [value in decision table]</th><th width="288">Solver Request Value [value send on API]</th><th>Result</th></tr></thead><tbody><tr><td><code>2.31</code></td><td><code>2.31</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>2.31</code></td><td><code>"2.31"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>true</code></td><td><code>true</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>true</code></td><td><code>"true"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>false</code></td><td><code>false</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>true</code></td><td><code>2</code></td><td><mark style="color:red;">Not Equal</mark></td></tr><tr><td><code>hello world</code></td><td><code>"hello world"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>"2024-09-23 13:27 +02:00"</code></td><td><code>"2024-09-23 13:27 +02:00"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>"2024-09-23 13:27 +02:00"</code></td><td><code>"2024-09-23T13:27:00+02:00"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>"2024-09-23 13:27 +02:00"</code></td><td><p></p><pre class="language-json"><code class="lang-json">{
  "input": {
    "date": "2024-09-23",
    "time": "13:27",
    "timezone": "+02:00"
  }
}
</code></pre></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>"2021-03-17T13:17-09:00"</code></td><td><code>"2024-09-23 13:27 +02:00"</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td><code>"2021-03-17T13:17-09:00"</code></td><td><p></p><pre class="language-json"><code class="lang-json">{
  "input": {
    "date": "2024-09-23",
    "time": "13:27",
    "timezone": "+02:00"
  }
}
</code></pre></td><td><mark style="color:red;">Not Equal!</mark></td></tr><tr><td>&#x3C;empty></td><td><code>""</code></td><td><mark style="color:green;">Equal</mark></td></tr><tr><td>&#x3C;empty></td><td><em>Value not presented in input JSON</em></td><td><mark style="color:red;">Not Equal</mark></td></tr></tbody></table>

### Calculation Data Types

Calculation columns support all the data types used by result columns.

### Result Data Types

When calling the [Solver API](../../api/rule-solver-api.md), the response returns an array of results based on the decision table setup. Response values are automatically cast to the following data types:

* Boolean
* Number&#x20;
* String
* Date
* JSON Object
* JSON Array

#### Casting examples:

| Decision Table Result Value | Solver Response Value     |
| --------------------------- | ------------------------- |
| `true`                      | `true`                    |
| `false`                     | `false`                   |
| `"true"`                    | `\"true\"`                |
| `25`                        | `25`                      |
| `25.0`                      | `25`                      |
| `25.01`                     | `25.01`                   |
| `""`                        | `""`                      |
| Empty                       | `""`                      |
| `hello world`               | `"hello world"`           |
| `DATE(09.23.2024)`          | `"2024-09-22T22:00"`      |
| `{}`                        | `{}`                      |
| `{"data":123 }`             | `{"data":123 }`           |
| `{"data": "123" }`          | `{"data": "123" }`        |
| `[12,36,"542"]`             | `[12,36,"542"]`           |
| `[12,36,"542"`              | `"[12,36,\"542\""`        |
| `[12, 36, "542", [1,2] ]`   | `[12, 36, "542", [1,2] ]` |
