---
description: >-
  # OpenTelemetry  ## Introduction  Modern production environments require
  visibility into application behavior, performance, and failures. 
  DecisionRules provides built-in observability capabilities th
---

# OpenTelemetry and Access Logging

## OpenTelemetry

### Introduction

Modern production environments require visibility into application behavior, performance, and failures.

DecisionRules provides built-in observability capabilities through OpenTelemetry (OTLP) and structured logging. These capabilities allow organizations to integrate DecisionRules into existing monitoring platforms, troubleshoot production issues, analyze rule execution behavior, and correlate requests across distributed systems.

Depending on the deployment architecture, observability can be implemented in several ways:

* Full OpenTelemetry integration with an observability platform
* Trace-only, log-only, or metrics-only telemetry exports
* Structured access and audit logging to stdout
* Audit-only logging without database persistence

The platform allows these approaches to be combined according to operational and compliance requirements.

## Feature Overview

DecisionRules provides built-in OpenTelemetry support for production-grade observability using the OTLP (OpenTelemetry Protocol) standard.

The platform can export:

* Traces — request execution flow and dependency spans
* Logs — structured access, audit, and application logs
* Metrics — runtime and service performance metrics

Telemetry can be sent to any OTLP-compatible observability platform, including:

* Grafana
* Jaeger
* Datadog
* OpenTelemetry Collectors
* Existing enterprise monitoring stacks

A single request can be correlated end-to-end using shared `traceId` and `spanId` values across:

* inbound API requests
* outbound dependency calls
* audit records
* runtime/application logs
* distributed traces

This provides a unified operational view of rule execution behavior and system performance.

## Deployment Patterns

DecisionRules supports multiple observability deployment patterns. The following sections describe the most common approaches.

### 1. Full OpenTelemetry Integration

This mode exports telemetry data directly to an OTLP-compatible observability platform.

Typical use cases:

* Centralized monitoring
* Distributed tracing
* Production diagnostics
* SLA monitoring
* Enterprise observability platforms

#### Traces, Logs and Metrics

```yaml
env:
  - name: OTLP_URL
    value: "otel-collector:4318"
  - name: OTLP_TRACES_ENABLED
    value: "true"
  - name: OTLP_LOGS_ENABLED
    value: "true"
  - name: OTLP_METRICS_ENABLED
    value: "true"
```

#### Logs Only

Useful when a centralized logging platform is available but distributed tracing is not required.

```yaml
env:
  - name: OTLP_URL
    value: "otel-collector:4318"
  - name: OTLP_LOGS_ENABLED
    value: "true"
```

### 2. Structured Logging to Stdout

DecisionRules can emit structured JSON logs directly to stdout without requiring any telemetry collector.

This mode is often sufficient for troubleshooting, operational monitoring, and log aggregation performed by the container platform itself.

Generated logs include:

* Access logs
* Audit logs
* Application logs

Benefits:

* No OpenTelemetry collector required
* No additional infrastructure components
* Works with Kubernetes log collection out of the box
* Full request correlation through `traceId` and `spanId`

#### Example Configuration

```yaml
env:
  - name: OTLP_URL
    value: "."
  - name: OTLP_STDOUT_LOGS_ENABLED
    value: "true"
```

### 3. Stdout Logging with Audit-Only Persistence Disabled

By default, audit logs are persisted to the audit database.

Some deployments prefer audit records to be exported through the logging pipeline only, without storing them in MongoDB.

In this configuration:

* Audit logs are generated
* Audit logs are exported to stdout
* Audit logs are not persisted in the audit database

#### Example Configuration

```yaml
env:
  - name: OTLP_URL
    value: "otel-collector:4318"
  - name: OTLP_STDOUT_LOGS_ENABLED
    value: "true"
  - name: OTLP_AUDIT_MONGO_ENABLED
    value: "false"
```

This approach is commonly used when audit retention is handled by an external logging platform.

### 4. Hybrid Mode

OpenTelemetry export and stdout logging can be enabled simultaneously.

This provides:

* Centralized telemetry collection
* Local container visibility
* Easier debugging during deployments and migrations

#### Example Configuration

```yaml
env:
  - name: OTLP_URL
    value: "otel-collector:4318"
  - name: OTLP_TRACES_ENABLED
    value: "true"
  - name: OTLP_LOGS_ENABLED
    value: "true"
  - name: OTLP_STDOUT_LOGS_ENABLED
    value: "true"
```

## Log Formatting and Filtering

The platform provides several optional controls for shaping telemetry output.

These settings allow organizations to:

* sanitize sensitive information
* control request/response body formatting
* limit exported log attributes
* exclude health-check traffic
* restrict telemetry to Solver-related endpoints

Commonly used options include:

* `OTLP_LOG_SANITIZATION_ENABLED`
* `OTLP_TRACE_SANITIZATION_ENABLED`
* `OTLP_ACCESS_BODY_FORMAT`
* `OTLP_LOG_ATTRIBUTE_ALLOWLIST`
* `OTLP_ACCESS_EXCLUDE_HEALTHCHECK`
* `OTLP_ACCESS_ONLY_SOLVER`
* `OTLP_STDOUT_WRAPPED_KEY`

Detailed descriptions are available in the Environment Variables section below.

## Implementation Notes

Outbound logs generated from Script Rules are currently not supported.

The reason is that OpenTelemetry instrumentation is not initialized inside the isolated worker process that executes JavaScript code.

## Log Examples

The following examples show the primary telemetry log types emitted by the platform.

All logs are structured JSON and can be correlated using `traceId` and `spanId`.

### Access Log — Inbound Request

Generated when the API receives a request.

```json
{
  "logType": "access",
  "direction": "inbound",
  "role": "request",
  "method": "POST",
  "url": "/rule/solve/my-rule/1",
  "traceId": "0f976b707efdd319550484483ab5f222",
  "spanId": "1e1ea1c52b642277",
  "body": {
    "input": {}
  }
}
```

### Access Log — Inbound Response

Generated when the API sends a response.

```json
{
  "logType": "access",
  "direction": "inbound",
  "role": "response",
  "statusCode": 200,
  "url": "/rule/solve/my-rule/1",
  "traceId": "0f976b707efdd319550484483ab5f222",
  "spanId": "1e1ea1c52b642277",
  "body": [
    {
      "output": "Hello from Solver"
    }
  ]
}
```

### Access Log — Outbound Request

Generated when the API sends a request to an external or internal dependency.

```json
{
  "logType": "access",
  "direction": "outbound",
  "role": "request",
  "method": "POST",
  "url": "http://ai:8084/process",
  "traceId": "0f976b707efdd319550484483ab5f222",
  "spanId": "1e1ea1c52b642277",
  "body": {
    "input": {}
  }
}
```

### Access Log — Outbound Response

Generated when the API receives a response from an external or internal dependency.

```json
{
  "logType": "access",
  "direction": "outbound",
  "role": "response",
  "statusCode": 200,
  "url": "http://ai:8084/process",
  "traceId": "0f976b707efdd319550484483ab5f222",
  "spanId": "1e1ea1c52b642277",
  "body": {
    "result": "ok"
  }
}
```

### Audit Log

Generated for rule execution auditing and operational tracking.

The log is generated only when audit logging is enabled on the rule.

```json
{
  "logType": "audit",
  "statusCode": 200,
  "traceId": "0f976b707efdd319550484483ab5f222",
  "spanId": "1e1ea1c52b642277",
  "body": {
    "ruleAlias": "my-rule",
    "executionTime": 0.5,
    "inputData": {
      "input": {}
    },
    "outputData": [
      {
        "output": "Hello from Solver"
      }
    ]
  }
}
```

### Application Error Log

Generated for internal runtime or application errors.

```json
{
  "logType": "application",
  "level": "ERROR",
  "errorType": "ERROR_OVERWRITE",
  "message": "Script timeout exceeded limit 8000 ms!",
  "traceId": "74c7593f1418870b75b2f62ab9fdb5b0",
  "spanId": "0e11a569e55ade68"
}
```

### Common Correlation Fields

<table><thead><tr><th width="178.85546875">Field</th><th>Purpose</th></tr></thead><tbody><tr><td>traceId</td><td>Correlates logs, spans, and metrics belonging to the same request flow</td></tr><tr><td>spanId</td><td>Identifies the specific operation/span within a trace</td></tr><tr><td>logType</td><td>Distinguishes access, audit, and application logs</td></tr><tr><td>timestamp</td><td>Event creation time</td></tr><tr><td>statusCode</td><td>HTTP response status when applicable</td></tr></tbody></table>

## Environment Variables

### Feature Activation

| Environment Variable              | Description                                                      | Default Value |
| --------------------------------- | ---------------------------------------------------------------- | ------------- |
| `OTLP_URL`                        | Base OTLP endpoint (required to activate telemetry pipeline).    | `undefined`   |
| `OTLP_TRACES_ENABLED`             | Enables trace exporter and runtime instrumentations.             | `false`       |
| `OTLP_LOGS_ENABLED`               | Enables OTLP log exporter.                                       | `false`       |
| `OTLP_METRICS_ENABLED`            | Enables periodic metric reader/exporter.                         | `false`       |
| `OTLP_STDOUT_ACCESS_LOGS_ENABLED` | Emits access logs to stdout (structured JSON), gated by license. | `false`       |
| `OTLP_STDOUT_AUDIT_LOGS_ENABLED`  | Emits audit logs to stdout (structured JSON), gated by license.  | `false`       |

### Logging Configuration

| Environment Variable              | Description                                                                                                                                                                                                                                                       | Default Value |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| `OTLP_LOG_SANITIZATION_ENABLED`   | Redacts sensitive keys (authorization/api keys/etc.) in telemetry logs.                                                                                                                                                                                           | `true`        |
| `OTLP_TRACE_SANITIZATION_ENABLED` | Redacts sensitive data (authorization/api keys/etc.) in traces.                                                                                                                                                                                                   | `true`        |
| `OTLP_STDOUT_ACCESS_BODY_FORMAT`  | Controls body formatting strategy for access logs in stdout. Valid values: `JSON`, `string`, `string-pretty`.                                                                                                                                                     | `'JSON'`      |
| `OTLP_STDOUT_WRAPPER_KEY`         | Wraps stdout payload into a nested key for downstream parsers. Example: `logDataBody`.                                                                                                                                                                            | `undefined`   |
| `OTLP_LOG_ATTRIBUTE_ALLOWLIST`    | Optional comma-separated allowlist of log fields sent to collector. Example: `level,logType,timestamp,traceId,spanId,statusCode,url,headers.authorization`. Note that `spanId`, `traceId`, and `level` are always present even when not defined in the allowlist. | `undefined`   |
| `OTLP_ACCESS_EXCLUDE_HEALTHCHECK` | Excludes health endpoints from access traces/logs.                                                                                                                                                                                                                | `false`       |
| `OTLP_ACCESS_ONLY_SOLVER`         | Limits telemetry to solver/job-related traffic paths.                                                                                                                                                                                                             | `false`       |

### Logging Options

| Environment Variable | Description                                                                                             | Default Value |
| -------------------- | ------------------------------------------------------------------------------------------------------- | ------------- |
| `LOGGER_TYPE`        | Controls console log format. Valid values: `STRING`, `JSON`, `NONE`.                                    | `STRING`      |
| `LOGGER_LEVEL`       | Minimum log level to print/emit through the application logger (e.g. `error`, `warn`, `info`, `debug`). | `info`        |

### Audit Logs in Database

| Environment Variable  | Description                                                                                                                           | Default Value |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| `AUDIT_MONGO_ENABLED` | If `false`, audit logs are created but not persisted to the audit database (useful when audit logs should only be emitted to stdout). | `true`        |

## Conclusion

DecisionRules observability support can be deployed in multiple ways ranging from simple structured stdout logging to full OpenTelemetry integration with enterprise monitoring platforms.

The most common deployment patterns are:

* Full OpenTelemetry integration
* Stdout-only structured logging
* Audit logging without database persistence
* Hybrid deployments combining both approaches

All telemetry data can be correlated using shared `traceId` and `spanId` values, providing complete visibility into rule execution, API behavior, and platform operations.
