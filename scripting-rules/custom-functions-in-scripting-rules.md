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
</strong><strong>return output;</strong></code></pre>

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
