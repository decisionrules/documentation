# React

## [@decisionrules/decisionrules-js on NPM](https://www.npmjs.com/package/@decisionrules/decisionrules-js)

![](<../../.gitbook/assets/1200px-React.svg (1).png>)

A simple NodeJS library that allows you to connect to [Decisionrules.io](https://decisionrules.io) from your web application easily.

### Manual Installation

#### 1. Installation

Install DecisionrulesJS packages through [npm](https://www.npmjs.com/package/@decisionrules/decisionrules-js):

```jsx
npm install @decisionrules/decisonrules-js --save
```

#### 2. Generate API key

You can create your API key here: [https://app.decisionrules.io/api-keys](https://app.decisionrules.io/api-keys)

#### 3. Example Usage

```jsx
import {solve} from 'decisionrules-js'

class App extends Component{
  constructor() {
    super()
    this.state = {data: null}
  }

  async componentDidMount(){
    const rule = await solve(token, ruleId, data, version)
        .then(rest => {return rest[0].supplier});
    this.setState({data: rule})
  }

  render() {
      return (
      <div className="App">

          <div>
              {this.state.data}
          </div>

      </div>
  );
  }
}
```
