---
description: You can simply run solver of another rules directly from Scripting Rule.
---

# Call Embedded Rules in Scripting Rules

## How to call embedded rules

You can run solver of other rules from Scripting Rule.

Solver is available under class **DR** and method **solve().**

`DR.solve(ruleId, data, version, SolverStrategy)`

Everything that you need is the rule ID and solver input data. Optionally, you may specify the version of the called rule and the execution strategy.

{% hint style="info" %}
Note that you can use **rule alias** instead of rule ID to identify the rule. In that case, make sure that the rule alias is unique within the space, otherwise the request will fail.
{% endhint %}

{% hint style="success" %}
If you are importing/exporting existing rules, **DO NOT** forget to change the ruleID you are calling in the scripting rule!
{% endhint %}

### Parameters

<table><thead><tr><th>name</th><th>type</th><th data-type="checkbox">mandatory</th><th>description</th></tr></thead><tbody><tr><td>ruleId</td><td>string</td><td>true</td><td>Id of solving rule. You can also use rule alias.</td></tr><tr><td>data</td><td>any</td><td>true</td><td>Input data for solver</td></tr><tr><td>version</td><td>number</td><td>false</td><td>Version of solving rule</td></tr><tr><td>SolverStrategy</td><td><a data-mention href="../other/execution-strategy.md">execution-strategy.md</a></td><td>false</td><td>Solver strategy of solver</td></tr></tbody></table>

### Return type

**DR.solve()** is returning the response from Solver as **Array**.

### Examples

#### Basic method

```
DR.solve("ruleId", data);
```

#### Method with rule version

```
DR.solve("ruleId", data, 5);
```

#### Method with Solver Strategy

```
DR.solve("ruleId", data, 5, SolverStrategy.FIRST_MATCH);
```

{% hint style="success" %}
If you want to define [Solver Execution Strategy](../other/execution-strategy.md) you have to specify the rule version too.
{% endhint %}

## Example of usage

{% hint style="info" %}
The rules you want to call in the scripting rules must be in the same [space](../team-work/spaces.md).
{% endhint %}

### **Decision table 1: "0000-0000-0000-0000"**

#### Input Model

```json
{
  "age": {}
}
```

#### Output Model

```
{
  "result": {}
}
```

#### Table

![](<../.gitbook/assets/image (153).png>)

### **Decision table 2: "1111-1111-1111-1111"**

#### Input **Model**

```
{
  "total amount": {},
  "blocked": {}
}
```

#### Output Model

```
{
  "result": {}
}
```

#### Table

![](<../.gitbook/assets/image (166) (1).png>)

### **Scripting Rule**

#### Script

```javascript
// Get data from Input
const data = input.data;

// Check if data is in Input and if data is an Array
if(data && Array.isArray(data)){

    const dates = [];

    // Iterate over data array
    for(let dat of data){
        // Check if dat (member of data array) has parameter date;
        if(dat.date){
            // add date to dates
            dates.push(dat.date);
        }
    }

    // Create BULK input data for DT
    const DTdata = [];

    for(let date of dates){
        const input = {
            "age": date
        }
        DTdata.push(input);
    }

    // log input data for DT
    log(JSON.stringify(DTdata));

    // Call first DT with FIRST_MATCH strategy
    const DTresult = DR.solve("0000-0000-0000-0000", DTdata, 1, SolverStrategy.FIRST_MATCH);

    // log result from DT
    log(JSON.stringify(DTresult));

    // transform data from DT to another DT
    let blocked = 0;

    for(let res of DTresult){
        if(Array.isArray(res)){
            if(res[0].result && res[0].result == "BLOCKED"){
                blocked ++;
            }
        }
    }

    // Create input data for DT
    const DTdata2 = {
        "total amount": dates.length,
        "blocked": blocked
    }

    // log input data for DT
    log(JSON.stringify(DTdata2));

    // Call second DT with FIRST_MATCH strategy
    const DTresult2 = DR.solve("1111-1111-1111-1111", DTdata2, 1, SolverStrategy.FIRST_MATCH);

    // log result from DT
    log(JSON.stringify(DTresult2));

    // pass result from DT to SR result
    output.result = DTresult2[0].result;

}

return output;
```

#### Input

```
{
	"data": [
		{
			"date": "01/01/1990"
		},
		{
			"date": "01/01/1999"
		},
		{
			"date": "01/01/1930"
		}
	]
}
```

#### Output

```
[
  {
    "output": "PASS"
  }
]
```
