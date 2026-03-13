# Snowflake

## Calling DecisionRules API directly from Snowflake

In this walkthrough we are going to show you how to setup up a connection from Snowflake database directly to the [DecisionRules.io](http://decisionrules.io) solver API, which will allow you to create procedure in Snowflake that can leverage your rules and give you great control over the results without having to change anything in the database code itself.

## Setting up in Snowflake <a href="#docs-internal-guid-7c72fcd7-7fff-d6a1-5bdb-b6c8be98dba4" id="docs-internal-guid-7c72fcd7-7fff-d6a1-5bdb-b6c8be98dba4"></a>

There are several steps you need to take in snowflake to make it so that the Rest API call is possible

<br>

1. ### Setup a Network rule

First we have to setup a network rule, this is a schema specific object that will “whitelist” the decisionrules API endpoint telling snowflake now to block the calls going out to this address.

The network rule can be created as follows

```sql
CREATE OR REPLACE NETWORK RULE NR_DECISIONRULES
MODE = EGRESS
TYPE = HOST_PORT
VALUE_LIST = ('api.decisionrules.io');
```

&#x20;

You can of course choose your own name for the Network Rule , but keep it for next steps

<br>

2. ### Creating the secret

For DecisionRules authentication we will need to store the API key as a secret that can then be used in the procedure itself. An example secret can be created like this&#x20;



```sql
CREATE OR REPLACE SECRET SECRET_DECISIONRULES
    TYPE = GENERIC_STRING
    SECRET_STRING = '<YOUR SOLVER KEY HERE>';

```

Of course you can choose your own name again, keep in mind that you will need to create multiple secrets if you need to be executing rules in multiple spaces so name them accordingly.

<br>

3. ### External access integration

Now we need to connect the secret and the network rule together using the External access integration which can be created as follows ( again if you have more secrets you need to include those as well for them to be usable )

```sql
CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION EAI_DECISIONRULES
  ALLOWED_NETWORK_RULES = (NR_DECISIONRULES)
  ALLOWED_AUTHENTICATION_SECRETS = (SECRET_DECISIONRULES)
  ENABLED = true;

```

4. ### Final Step - creating the function

Now we can create the function that can then be executed in snowflake. We will use Python to make the actual call and take advantage of all the objects we created previously.

An example function DR\_CALL can be seen bellow <br>

```python
create or replace function DR_CALL(
    ruleAlias string,
    json OBJECT,
    version int
)
returns VARIANT
language python
runtime_version = '3.10'
handler = 'run'
packages = ('snowflake-snowpark-python', 'requests')
external_access_integrations = (ExternalAccess_Decisionrules)
secrets = ('Secret_Decisionrules' = Secret_Decisionrules)
as
$$


import _snowflake
import requests


session = requests.Session()


def run(ruleAlias: str, json: dict , version: int) -> dict:
    token = _snowflake.get_generic_secret_string('Secret_Decisionrules')


    # Define the DeepSeek API endpoint
    url = "https://api.decisionrules.io/rule/solve/" + ruleAlias


    # Define the translation request payload
    data = {"data" : json }


    # Define the headers with the API key
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }


    # Make the API request
    response = requests.post(url, json=data, headers=headers)


    # Check response status and print output
    if response.status_code == 200:
        result =  response.json()
        return {"results": result} if isinstance(result, list) else result
    else:
        print("Error:", response.status_code, response.text)
        return response.text


$$;

```

Now all that is left to do is test that everything is set up correctly and we can call the actual function to see our first results!

```sql
Select DR_CALL(‘test’ , PARSE_JSON( ‘{“example_input”: “example”}’ ) ,1 )

```

The first argument of the function is the Alias of the rule we are executing, second is the input and the last is the version of the rule. Of course this is just an example, you have access to all the code used so you can modify it to fit your needs and to fit your data.
