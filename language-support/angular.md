# Angular

## [@decisiongri/ng-decisiongrid](https://www.npmjs.com/package/@decisiongrid/ng-decisiongrid) on NPM

A simple Angular library that allows you to easily connect to [Decisiongrid.io](https://decisiongrid.io/) from your web application.

### Manual Installation

#### 1. Installation

Install Decisiongrid packages through [npm](https://www.npmjs.com/package/@decisiongrid/ng-decisiongrid):

```text
npm install @decisiongrid/ng-decisiongrid
```

#### 2. Generate API key

You can create your `API key` here: [https://app.decisiongrid.io/api-keys](https://app.decisiongrid.io/api-keys)

#### 3. Setup Angular Modules

Import the `NgDecisiongridModule` into your Angular application's module `AppModule`. Your application's main module might look like this:

_app.module.ts_

```text
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {NgDecisiongridModule} from 'ng-decisiongrid';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgDecisiongridModule.forRoot({
      token: 'YOUR_API_KEY'
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```


#### 4. Solve rule

You can create rule on [Decisiongrid dashboard](https://app.decisiongrid.io/)

_app.component.ts_

```text
export class AppComponent implements OnInit {
  
  constructor(private decisiongridService: NgDecisiongridService) {
  }

  ngOnInit(): void {
    const inputData = {
      client: {
        age: 18
      }
    };
    this.decisiongridService.solveRule(inputData, 'YOUR_RULE_ID').then(data => {
      console.log(data);
    });
  }
}
```

