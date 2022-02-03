# Supported Data Types

## Data types in Decision Tables

All data in a data table are stored as string values and are **automatically casted when needed**. Therefore, you don't need to specify any data format for your \*\*\*\* [**input and output** ](input-and-output/)models. The automatic casting of conditions and results is described in the following sections.

{% hint style="info" %}
**The decimal separator is always a dot - "."**
{% endhint %}

### Condition Data Types

The conditions can be made using the following scalar data types:

* Number
* Boolean
* String
* Date

#### Conditions

![](<../.gitbook/assets/image (44).png>)

#### Solver Request Data

```javascript
// 2.31
{
  "inputData": 2.31 OR "2.31"
}

// true
{
  "inputData": true
}

//false
{
  "inputData": false
}

// hello world
{
  "inputData": "hello world"
} 

// 17/13/2021 13:17 GMT:-9:00
{
"inputData": {"date":"2021-03-17","time":"13:17","timezone":"-09:00"}
}
// DATE TIME INPUT AS ISO-8601
{
"inputData": "2021-03-17T13:17-09:00"
}
// OR ANY PARSEABLE DATE STRING
{
"inputData": "2021-03-17, 13:17 -09:00"
}
// <empty>
{}
OR
{
  "inputData": ""
}
```

#### Examples:

| Condition \[value in decision table]                                     | Solver Request Value \[value send on API]                                | Result    |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------ | --------- |
| 2.32                                                                     | 2.32                                                                     | Equal     |
| 2.32                                                                     | "2.32"                                                                   | Equal     |
| true                                                                     | true                                                                     | Equal     |
| false                                                                    | false                                                                    | Equal     |
| true                                                                     | 1                                                                        | Equal     |
| false                                                                    | 0                                                                        | Equal     |
| true                                                                     | 2                                                                        | Not Equal |
| true                                                                     | "true"                                                                   | Not Equal |
| hello world                                                              | "hello world"                                                            | Equal     |
| <p>"date": "2021-03-17",<br>"time": "13:17",<br>"timezone": "-09:00"</p> | <p>"date": "2021-03-17",<br>"time": "13:17",<br>"timezone": "-09:00"</p> | Equal     |
| <p>"date": "2021-03-17",<br>"time": "13:17",<br>"timezone": "-09:00"</p> | "2021-03-17T13:17-09:00"                                                 | Equal     |
| "2021-03-17T13:17-09:00"                                                 | "2021-03-17T13:17-09:00"                                                 | Equal     |
| \<empty>                                                                 | ""                                                                       | Equal     |
| \<empty>                                                                 | _Value not presented in input JSON_                                      | Equal     |

### Result Data Types

Calling [**Solver API**](../api/rule-solver-api.md#solve-rule) returns an array of results according to the decision table setup. Response values are **automatically cast** to:

* Boolean
* Number OR Float
* String
* Date
* JSON Object
* JSON Arrays

#### Casting examples:

| Decision Table Result Value                                                                                     | Solver Response Value                                                                                           |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `true`                                                                                                          | `true`                                                                                                          |
| `false`                                                                                                         | `false`                                                                                                         |
| `"true"`                                                                                                        | `\"true\"`                                                                                                      |
| `25`                                                                                                            | `25`                                                                                                            |
| `25.0`                                                                                                          | `25`                                                                                                            |
| `25.01`                                                                                                         | `25.01`                                                                                                         |
| ` <empty>`` `` `**`OR`**` `` ``empty string `                                                                   | `Node is omitted in reponse`                                                                                    |
| `hello world`                                                                                                   | `"hello world"`                                                                                                 |
| <p><code>"date": "2021-03-17",</code><br><code>"time": "13:17",</code><br><code>"timezone": "-09:00"</code></p> | <p><code>"date": "2021-03-17",</code><br><code>"time": "13:17",</code><br><code>"timezone": "-09:00"</code></p> |
| `{}`                                                                                                            | `{}`                                                                                                            |
| `{"data":123 }`                                                                                                 | `{"data":123 }`                                                                                                 |
| `{"data": "123" }`                                                                                              | `{"data": "123" }`                                                                                              |
| `[12,36,"542"]`                                                                                                 | `[12,36,"542"]`                                                                                                 |
| `[12,36,"542"`                                                                                                  | `"[12,36,\"542\""`                                                                                              |
| `[12, 36, "542", [1,2] ]`                                                                                       | `[12, 36, "542", [1,2] ]`                                                                                       |
