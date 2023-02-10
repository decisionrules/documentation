# Logging options

DecisionRules has a simple and technology-independent logging system that logs simply to STDOUT. You can still process this standard output in all modern logging add-ons that you use in your infrastructure.

### How to change logger type&#x20;

The type of logger that is going to be chosen is decided by environment variable. This variable  called `LOGGER_TYPE` takes a string as a parameter with name of the logger you desire to use.

```
LOGGER_TYPE=JSON or STRING
```

### Types

#### JSON

This logger outputs data in JSON structure consisting of:&#x20;

* timestamp&#x20;
* severity
* message

Resulting into following object:

```json
{
 "timestamp":"2021-05-24 17:13:04.744+02:00",
 "severity":"INFO",
 "message":"System listening on port TCP 8080"
}
```

#### STRING

Outputs data a string format that consist of:

* timestamp&#x20;
* severity
* message

Data are always in format `[YYYY-MM-DDTHH:mm:ss.sssZ] <SEVERITY> MESSAGE`

Note that the message does not necessarily need to end with `\n`

Example output for this logger is:

```
[2023-02-02T08:51:39.743Z] <INFO> DecisionRules server listening on the port 8080
```
