# Angular

## [@decisionrules/ng-decisionrules on NPM](https://www.npmjs.com/package/@decisionrules/ng-decisionrules)

![](../../.gitbook/assets/image%20%2814%29.png)

A simple NodeJS library that allows you to connect to [Decisionrules.io](https://decisionrules.io/) from your web application easily.

### Manual Installation

#### 1. Installation

Install Decisionrules packages through [npm](https://www.npmjs.com/package/@decisionrules/ng-decisionrules):

```bash
npm install @decisionrules/ng-decisionrules
```

#### 2. Generate API key

You can create your `API key` here: [https://a](https://app.decisionrules.io/auth/login?retUrl=%2Fapi-keys)[pp.decisionrules.io/api-keys](https://app.decisionrules.io/auth/login?retUrl=%2Fapi-keys)

#### 3. Setup Angular Modules

Import the `NgDecisionrulesModule` into your Angular application's module `AppModule`. Your application's main module might look like this:

{% code title="app.module.ts" %}
```typescript
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {NgDecisionrulesModule} from 'ng-decisionrules';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgDecisionrulesModule.forRoot({
      token: 'YOUR_API_KEY'
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```
{% endcode %}

#### 4. Solve rule

You can create rule on[ Decisionrules dashboard](https://app.decisionrules.io/)

{% code title="app.component.ts" %}
```typescript
export class AppComponent implements OnInit {

  constructor(private decisionrulesService: NgDecisionrulesService) {
  }

  ngOnInit(): void {
    const inputData = {
      client: {
        age: 18
      }
    };
    this.decisionrulesService.solveRule(inputData, 'YOUR_RULE_ID').then(data => {
      console.log(data);
    });
  }
}
```
{% endcode %}

