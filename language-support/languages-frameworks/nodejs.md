# NodeJS

## [@decisionrules/decisionrules-js on NPM](https://www.npmjs.com/package/@decisionrules/decisionrules-js)

![](<../../.gitbook/assets/image (18).png>)

A simple NodeJS library that allows you to connect to [Decisionrules.io](https://decisionrules.io) from your web application easily.

### Manual Installation

#### 1. Installation

Install DecisionrulesJS packages through [npm](https://www.npmjs.com/package/@decisionrules/decisionrules-js):

```javascript
npm install @decisionrules/decisonrules-js --save
```

#### 2. Generate API key

You can create your API key here: [https://app.decisionrules.io/api-keys](https://app.decisionrules.io/api-keys)

#### 3. Example Usage

```javascript
const decisionrules = require('decisionrules-js');

async function solver(){
  return await decisionrules.solve(token, ruleId, data, version).then(res => {
    return res
  });
}
```
