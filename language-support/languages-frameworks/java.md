# Java

##  [java-spring-decisionrules on GitHub](https://github.com/decisionrules/java-spring-decisionrules)

##  ![](../../.gitbook/assets/java-1-.svg) 

A simple Java Spring library that allows you to connect to [Decisionrules.io](https://decisionrules.io/) from your web application easily.

Example call to decision rules API using spring rest template. This simple project shows how can you call decision rules API mainly

* init rest template
* add authorization headers
* execute sample rule on DecisionRules

### How to execute this example

#### 1. Clone this repo to your computer

Install Decisionrules packages through [npm](https://www.npmjs.com/package/@decisionrules/ng-decisionrules):

```bash
git clone https://github.com/decisionrules/java-spring-decisionrules.git
```

#### 2. Add your sample rule id \(every account on decision rules has this sample rule by default\) and bearer token to Main class.

#### 3. Execute main method in Main class and see the resu

### Decision rules call example

#### Prepare header with token authorization

Every call to decision rules has to contain an authorization header with bearer token.

```java
HttpHeaders headers = new HttpHeaders();
headers.setContentType(MediaType.APPLICATION_JSON);
headers.set("Authorization", "Bearer " + bearerToken);
```

#### Call REST API with JSON in string

```typescript
//prepare input object
String jsonInput = "{\"delivery\":{\"distance\":40,\"tariff\":\"basic\"},\"pack\":{\"weight\":4,\"longestSide\":50}}";
        

HttpEntity<String> entity = new HttpEntity<String>(jsonInput, headers);
ResponseEntity<String> response = restTemplate.exchange(formatUrl(connectionUrl, ruleId, version), HttpMethod.POST, entity, String.class);
```

#### Call REST API with java model

```typescript
// register object mapper to rest template
final ObjectMapper objectMapper = new ObjectMapper();
MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter(objectMapper);        
this.restTemplate.getMessageConverters().add(converter);

//prepare input object
ExampleRuleInput inputModel =

//call api
HttpEntity<ExampleRuleInput> entity = new HttpEntity<ExampleRuleInput>(inputModel, headers);
final List<ExampleRuleOutput> output = restTemplate.postForObject(formatUrl(connectionUrl, ruleId, version), entity, List.class);
        
```

