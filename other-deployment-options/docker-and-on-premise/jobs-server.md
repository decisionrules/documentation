---
description: >-
  Article about Job handling and orchestration options with On-Premise
  Deployments
icon: folder-gear
---

# Jobs Server

### Overview

The Jobs feature allows your application to handle background tasks and scheduled operations. This guide explains how to configure job processing in your Docker deployment, including options for running jobs in the same container as your main application or in dedicated job server containers.

### How Jobs Work

#### Database-Driven Architecture

The jobs system uses your database as the central communication layer between all components:

* **Job Queue**: All jobs are stored in the database with status, priority, and payload information
* **Job Processing**: Containers configured to process jobs poll the database queue and pick up pending jobs
* **Status Updates**: Job processors update job status in the database (pending → processing → completed/failed)
* **Result Storage**: Job results and errors are written back to the database

This architecture means:

* No additional message queue infrastructure required
* All containers **must connect to the same database**
* Job creation and processing are completely decoupled
* Containers can create jobs even with `JOBS_SERVER_DISABLED=true`
* Only containers with job processing enabled will actually execute jobs

### Deployment Modes

#### Mode 1: Single Container (Default)

By default, when you deploy the application, a single container handles all features including job processing. This is the simplest setup and works well for most small to medium-scale deployments.

**Configuration:**

* No additional environment variables required
* Jobs run alongside your main application features

**When to use:**

* Short to medium length workloads
* Simple deployment requirements

#### Mode 2: Decoupled Job Processing

For better scalability and resource management, you can separate job processing from your main application by running dedicated job server containers.

**Primary Application Container**

Handles all features **except** job processing.

```yaml
environment:
  - JOBS_SERVER_DISABLED=true
```

**Dedicated Job Server Container(s)**

Handles **only** job processing.

```yaml
environment:
  - ONLY_JOB_SERVER=true
```

**When to use:**

* High job volume or resource and time-intensive jobs
* Need for independent scaling of job processing
* Better fault isolation between main app and job processing
