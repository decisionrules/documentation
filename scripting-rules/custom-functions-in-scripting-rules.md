# Custom functions in Scripting Rules

In Scripting Rules, you can use functions as standard in JavaScript. The definition of the function must be before calling it.

#### Without  methods of class DR

```javascript
const CONSTANT = 20;

function fce(parameter){
    return parameter + 10;
}

output.result = fce(CONSTANT);
return output;
```

\
If you use methods of the **DR class** in a custom function, then the function must be **asynchronous**. Indicated by the key call to async and the call to the await function. DR class methods are automatically set to await, but you can specify it there yourself to make the code clearer for you.

#### Without await for methods of class DR

<pre class="language-javascript"><code class="lang-javascript">const CONSTANT = 20;

async function fce(parameter){
    const result = DR.solve("ruleId", {});
    return result + parameter;
}

<strong>output.result = await fce(CONSTANT);
</strong><strong>return output;
</strong></code></pre>

#### With await for methods of class DR

```javascript
const CONSTANT = 20;

async function fce(parameter){
    const result = await DR.solve("ruleId", {});
    return result + parameter;
}

output.result = await fce(CONSTANT);
return output;
```

**Using custom functions to make parallel API calls**

In the example below we first get an array of item names, we then define a function to make the asynchronous API call to a given item's name endpoint. After that we push all of the item calls into an empty array, which we use Promise.all on, giving us an array of results.

```javascript
const url = "https://interestingApi.com"
const promises = [];

// get a list of itemNames from the API
const inventory = DR.http.get(url, options)

// define a function to make the API call
async function getDataForEachItem(itemName) {
    return await DR.http.get(url+itemName, options);
}

// push all of the function calls into an Array of promises
for (const item of inventory.itemsList) {
    promises.push(getDataForEachItem(item.name));
}

// call Promise.all on the array
output.output = await Promise.all(promises);

return output;
```

{% hint style="warning" %}
You can also use this pattern with DR.Solve() to call the DecisionRules Solver for many rules at once. This approach can however overburden the server and result in errors when making too many calls to the Solver at once.
{% endhint %}
