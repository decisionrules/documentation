---
description: >-
  This documentation outlines the architecture and configuration of Departments.
  Use the links below to find the relevant guide for your role.
---

# Departments

### Quick Navigation

1. <mark style="background-color:$primary;">Understand Departments</mark>: Continue reading below for a high-level overview of how departments function within the organization.
2. <mark style="background-color:$primary;">Setup & Administration</mark>: If you are an Owner or Admin looking to create or configure organizational units, go to: [Setup Guide](setting-up-department.md).
3. <mark style="background-color:$primary;">Managing Your Department</mark>: If you are a Department Manager looking for instructions on day-to-day operations, go to: [Department Manager role](department-manager-guide.md).

### What are Departments?

A Department is a structural container within your organization. It isolates specific Teams, Spaces, and Space Roles so they can be managed independently from the rest of the organization by department managers. See following graph with example department structure.

#### Problem that Companies Faced before Departments:

```mermaid
%%{init: {"flowchart": {"nodeSpacing": 15, "rankSpacing": 30}}}%%
graph LR
    %% Styling
    classDef root fill:#263238,stroke:#000,stroke-width:2px,color:#fff;
    classDef bucket fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px,color:#424242;
    classDef sales fill:#e8f5e9,stroke:#4caf50,stroke-width:2px,color:#1b5e20;
    classDef market fill:#e3f2fd,stroke:#2196fb,stroke-width:2px,color:#0d47a1;
    classDef roles fill:#fff3e0,stroke:#fb8c00,stroke-width:2px,color:#bf360c;

    %% Root
    Org["🏢 Global Organization / Admin"]:::root

    %% Buckets (Level 1)
    Org --> TeamsBucket["👥 ALL TEAMS"]:::bucket
    Org --> SpacesBucket["📁 ALL SPACES"]:::bucket
    Org --> RolesBucket["📋 ALL ROLES"]:::bucket

    %% Teams (Level 2)
    TeamsBucket --> SalesA["🚀 Sales Team A"]:::sales
    TeamsBucket --> SalesB["🚀 Sales Team B"]:::sales
    TeamsBucket --> MktgX["📣 Marketing Team X"]:::market

    %% Spaces (Level 2)
    SpacesBucket --> SalesSpaces["📁 Sales Spaces"]:::sales
    SpacesBucket --> MktgSpaces["📁 Mktg Spaces"]:::market

    %% Roles (Level 2)
    RolesBucket --> Role1["✍️ Role: Editor"]:::roles
    RolesBucket --> Role2["📖 Role: Reader"]:::roles
```

#### The Solution:&#x20;

```mermaid
graph TD
    %% Styling
    classDef root fill:#263238,stroke:#000,stroke-width:2px,color:#fff;
    classDef sales fill:#e8f5e9,stroke:#4caf50,stroke-width:2px,color:#1b5e20;
    classDef market fill:#e3f2fd,stroke:#2196f3,stroke-width:2px,color:#0d47a1;
    classDef manager fill:#fff,stroke:#000,stroke-width:1px,color:#000;
    classDef neutral fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px,color:#424242;

    %% Root
    Org["🏢 Global Organization / Admin"]:::root

    %% The Split (Departments + Global)
    Org --> Sales["🟢 Sales Department"]:::sales
    Org -.-> GlobalRes["🌐 Global Resources"]:::neutral
    Org --> Marketing["🔵 Marketing Department"]:::market

    %% Sales Silo
    subgraph SalesDept ["Scope: Sales"]
        Sales --- Mgr1["🦸 Manager: Carl"]:::manager
        Mgr1 -.-> Teams1["🚀 Sales Resources"]:::sales
    end

    %% Marketing Silo
    subgraph MktDept ["Scope: Marketing"]
        Marketing --- Mgr2["🦸 Manager: John"]:::manager
        Mgr2 -.-> Teams2["🚀 Marketing Resources"]:::market
    end
```

### The Organizational Benefit:

As illustrated above, this structure creates clean "Silos of Responsibility":

* Segmentation: Users and Teams are grouped logically. A "Sales" team lives strictly within the Sales Department.
* Scalability: You can add as many departments as needed without cluttering the global view.
* Clarity: It provides an immediate visual map of who belongs where, making it easy for Admins to audit the organization at a glance.
* Flexibility & Delegation: While Departments act as dedicated silos, they remain connected to the wider company. Admins retain ultimate control—you can manage a department directly, or appoint a Department Manager to offload the day-to-day work.

{% hint style="info" %}
#### Manager Scope:&#x20;

Department Managers are restricted to managing only their assigned department. Detailed role limitations are covered here: [Setting up Department](setting-up-department.md#summary-of-delegation)
{% endhint %}

{% code fullWidth="false" %}
```mermaid
graph TD
  %% STYLES
  classDef dept fill:#e8f5e9,stroke:#4caf50,stroke-width:2px,color:#1b5e20;
  classDef component fill:#e3f2fd,stroke:#2196f3,stroke-width:2px,color:#0d47a1;
  classDef result fill:#fff9c4,stroke:#fbc02d,stroke-width:2px,stroke-dasharray: 5 5,color:#f57f17;

  %% NODES
  Dept("🟢 Department"):::dept

  %% The "Ingredients"
  Teams["👥 Teams<br/>(Who)"]:::component
  Spaces["📁 Spaces<br/>(Where)"]:::component
  Roles["📋 Space Roles<br/>(What)"]:::component

  %% The Result
  Policies{{"🎯 Policies<br/>(Access Rules)"}}:::result

  %% CONNECTIONS
  Dept --> Teams
  Dept --> Spaces
  Dept --> Roles

  %% Funneling into Policies
  Teams --> Policies
  Spaces --> Policies
  Roles --> Policies

  %% Link Styling
  linkStyle 3,4,5 stroke:#fbc02d,stroke-width:2px;
```
{% endcode %}





