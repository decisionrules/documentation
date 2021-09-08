# PHP

### [@decisionrules/decisionrules-php](https://packagist.org/packages/decisionrules/decisionrules-php)

![](../../.gitbook/assets/1280px-php-logo.svg-1-.png)

## README

Simple async python library that allows you to easily connect to [Decisionrules.io](https://decisionrules.io/) from your PHP application.

## Where to get APIkey?

You can create your API key here: [https://app.decisionrules.io/api-keys](https://app.decisionrules.io/api-keys)

## Enums

### Geolocation

* DEFAULT
* EU1
* EU2
* US1
* US2

### SolverStrategy

* STANDARD
* ARRAY
* FIRST\_MATCH

### Protocols

* HTTP
* HTTPS

Geolocation in DecisionRules class constructor can be omitted. The version in Solver method can be omitted. Custom domain for the on-premise version of DecisionRules can be omitted if using standard version.

## Usage

```php
include 'decisionrules.php';

$decisionRules = new DecisionRules('API_KEY_HERE', GeoLocation::DEFAULT);

$data = array (
    'data' => 
    array (
        'day' => 'today',
    ),
);

$response = $decisionRules->Solver("RULE_ID_HERE", $data, SolverStrategy::STANDARD, "VERSION_HERE");
```

### Custom domain usage

Just create a CustomDomain instance that takes string URL and Protocols enum value and passes it to the DecisionRules object as so.

```php
$customDomainIfOnPremise = new CustomDomain("your.domain.com", Protocols::HTTP);

$decisionRules = new DecisionRules('API_KEY_HERE', GeoLocation::DEFAULT, $customDomain);
```

