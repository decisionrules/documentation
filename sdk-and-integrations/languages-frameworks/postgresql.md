# PostgreSQL

## Database Setup

Postgres itself does not have a way of calling an external API, you will need to use a Procedural Language of your choice to create a stored procedure and call the procedure from your code.

In this showcase we will use the plpython3u language ( documentation: [https://www.postgresql.org/docs/current/plpython.html](https://www.postgresql.org/docs/current/plpython.html) ), but you can use any other supported language where you write an analogous procedure.

Bellow you can find scripts that will create the tables necessary for the purposes of this tutorial

{% file src="../../.gitbook/assets/create My_DR_Input.sql" %}
Create My\_DR\_input table
{% endfile %}

{% file src="../../.gitbook/assets/create results.sql" %}
Create RESULTS table
{% endfile %}



## Calling API from postgres

As we mentioned we will need to create a stored procedure using a Procedural language and compile it in Postgres. In the case of using plpython3u the procedure is as follows

{% file src="../../.gitbook/assets/RestCallFunction.sql" %}
plpython3u function code
{% endfile %}

```python
CREATE OR REPLACE FUNCTION py_pgrest(p_url text, p_method text DEFAULT 'POST'::text, p_data text DEFAULT ''::text, p_headers text DEFAULT '{"Content-Type": "application/json"}'::text)
 RETURNS text
 LANGUAGE plpython3u
AS $function$
    import requests, json
    try:
        r = requests.request(method=p_method, url=p_url, data=p_data, headers=json.loads(p_headers))
    except Exception as e:
        return e
    else:
        return r.content
$function$
;
```

We can then use this procedure to call the API inside our main block of code.&#x20;



## Processing the API call

Our code divides the input data into batches according to the `batchSize` variable and for each of these batches call the `py_pgrest` function to execute the API call. We describe the code in detail bellow, but here is the full version

{% file src="../../.gitbook/assets/postgres Call and process api.sql" %}
Full code to process input in batches and store results
{% endfile %}

### Load data into JSON

To create a json structure from our input data we use two inbuilt postgres functions

* `JSON_BUILD_OBJECT` ( \[alias, columnName] , ... )
  * creates a json object with alias as the key and columnName as value
* `JSON_AGG`
  * creates an array ( used to create Bulk input )

```plsql
select json_build_object( 'data', json_agg(json_build_object( 'promoCode' , promoCode , 'productType', productType, 'period', period)) )
		into body
		from (select * from my_dr_input dr OFFSET lastBatchStart - 1 FETCH FIRST batchSize rows only);
```

### Executing the API call

To execute the API call we simply invoke the previously created `py_pgrest` function using the following code

```plsql
 py_pgrest(  'https://api.decisionrules.io/rule/solve/' || rule_alias,
					   'POST' , 
					   body, 
					   '{"Authorization":"Bearer ' || API_KEY ||  '","Content-Type": "application/json"}');
```

###

### Extracting data from the response

In our example we extract data from the API response and store it in the RESULTS table. To access the data in the response we use the following process

```plsql
result =  py_pgrest(  'https://api.decisionrules.io/rule/solve/' || rule_alias,
					   'POST' , 
					   body, 
					   '{"Authorization":"Bearer ' || API_KEY ||  '","Content-Type": "application/json"}');
-- store results in a table
-- use -> to access nested object
-- use ->> to extract the value
-- use ::data_type to convert the value into your desired datatype
insert into results
select (res::json->'prices'->>'finalPrice')::float ,
       (res::json->'prices'->>'crudePrice')::float ,
        res::json->>'message' 
-- parse the response by object
from (select JSON_ARRAY_ELEMENTS(JSON_ARRAY_ELEMENTS(result::json) ) as res ) ;
```

We use the function JSON\_ARRAY\_ELEMENTS twice since the strucure of the response is

```json
[ [result1...resultN], [result1..resultM] , ...   ]
```

This gives us a row for each result we obtained. We then take these rows ( column alias `res` ) and we extract the necessary values using two different operators&#x20;

* '- >' allows us to gain access into nested records
* '- > >' extracts the final value

we then can use ::your\_data\_type to convert the value to the required data type&#x20;
