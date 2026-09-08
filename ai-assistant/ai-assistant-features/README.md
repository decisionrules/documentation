---
description: >-
  This page lists the features available in the AI Assistant. Selected features
  are described in detail on their dedicated sub-pages.
---

# AI Assistant Features

## AI Assistant Features Overview

This page lists the specialized features available in DecisionRules AI Assistant and where they can be used. For each feature, **AI Assistant** identifies its locations in the application. **Authoring MCP** identifies the equivalent feature-specific MCP tools when they are available. If no Authoring MCP entry is shown, this release does not expose an equivalent dedicated tool through the Authoring MCP server.

[See Authoring MCP Server for connection, permission, review, and persistence requirements.](../../integrations/sdk-and-libraries/mcp-servers/authoring-mcp-server.md)

### General Assistance

#### General Assistant

**AI Assistant:** All pages with the AI Assistant panel

The General Assistant handles broad conversation and product orientation when a request does not clearly require a specialized agent. It can answer follow-up questions and direct you to supported authoring, search, and navigation capabilities.

#### Documentation Search

**AI Assistant:** All pages with the AI Assistant panel

Documentation Search answers questions using DecisionRules Documentation. It returns a concise answer grounded in documented product behavior and can point you to the relevant pages.

#### Academy Search

**AI Assistant:** All pages with the AI Assistant panel

Academy Search finds relevant courses, tutorials, and learning materials in DecisionRules Academy. If a request is broad, the Assistant may ask for more detail before recommending content.

#### Navigation Helper

**AI Assistant:** All pages with the AI Assistant panel

Navigation Helper guides you to pages, panels, and controls in the DecisionRules application. When the requested element is visible, it can highlight it. Otherwise, it explains where to navigate first and can add a short documentation-based explanation of the feature.

### Rule and Process Authoring

#### Decision Table Architect

**AI Assistant:** Rules List, Decision Table Detail\
**Authoring MCP:** `generate_decision_table` for creation; `propose_rule_edit` for editing

Decision Table Architect creates Decision Tables from natural-language requirements and prepares targeted changes to an open Decision Table. When editing, it can use the current table, selected cells, and Test Bench data as context.

During creation, it can ask structured clarification questions, display generation progress, review whether the draft covers the requested behavior, and validate the table before offering it for import. If the request needs several rules and a flow, it can recommend Process Architect instead of forcing the complete problem into one table.

[Read Create and Edit Decision Tables.](decision-tables.md)

#### Scripting Rule Architect

**AI Assistant:** Rules List, Scripting Rule Detail\
**Authoring MCP:** `generate_scripting_rule` for creation; `propose_rule_edit` for editing

Scripting Rule Architect creates a Scripting Rule or prepares changes to the script, Input Model, Output Model, and Rule Variables of the currently open rule.

Use it when the behavior genuinely requires procedural logic or capabilities that cannot be represented clearly with declarative rules. If the script calls other DecisionRules resources, the Assistant can use the space's folder and rule structure to prepare grounded references.

[Read Create and Edit Scripting Rules.](create-and-edit-scripting-rules.md)

#### Lookup Table Architect

**AI Assistant:** Rules List\
**Authoring MCP:** `generate_lookup_table` for creation

Lookup Table Architect creates a Lookup Table from natural-language instructions. It is designed for fixed reference data where one primary key identifies a row and the remaining columns provide values to retrieve.

The Assistant validates the generated structure and asks for clarification when essential details, such as the key, columns, or mappings, are missing. Use a Decision Table instead when the result is based on conditions or business policy.

[Read Create Lookup Tables.](create-lookup-tables.md)

#### Decision Flow Architect

**AI Assistant:** Rules List, Decision Flow Detail\
**Authoring MCP:** `generate_decision_flow` for creation; `propose_rule_edit` for editing

Decision Flow Architect creates a Decision Flow that orchestrates rules and supported workflow nodes. It can use rules already available in the selected space, prepare input and output mappings, create branches and iterations, and expose editable configuration values in the proposal.

On Decision Flow Detail, it prepares reviewable changes to the current flow while preserving its identity. Generated flows are validated and automatically arranged before they are persisted.

[Read Create and Edit Decision Flows.](create-and-edit-decision-flows.md)

#### Process Architect

**AI Assistant:** Rules List\
**Authoring MCP:** `plan_process`, `refine_process`, `build_process`, process recovery tools, and `import_process`

Process Architect is intended for business requests that require several rules plus the Decision Flows that connect them.

It first proposes an editable plan. You can review each rule, adjust the plan, and explicitly choose a compatible existing rule for reuse. After confirmation, generation reports progress per step and can pause for a business clarification, retry a failed step, or present a smaller split or repair for review. Nothing is imported until the completed process is approved.

[Read Design and Build a Complete Process.](design-and-build-a-complete-process.md)

{% hint style="info" %}
Decision Flow Architect and Process Architect require DecisionRules App **1.26.2 or later** and AI Engine **1.3.0 or later** in self-hosted deployments.

The corresponding focused Authoring MCP tools require DecisionRules Server **1.26.2 or later** and AI Engine **1.3.0 or later**.
{% endhint %}

### Rule Support Features

#### Generate Functions

**AI Assistant:** Decision Table Detail

Generate Functions writes valid DecisionRules function expressions for selected Decision Table cells. It understands the selected cell and available variables.

It can also:

* Explain an existing expression and its result
* Debug or adjust an existing expression
* Combine supported functions to express the required calculation

{% hint style="info" %}
Select a cell before entering the request. The selected cell is shown at the bottom of the AI Assistant panel and can be removed from the context there.
{% endhint %}

#### Generate Test Data

**AI Assistant:** Decision Table Detail, Scripting Rule Detail, Decision Flow Detail

Generate Test Data prepares one or more inputs that match the open resource's Input Model. For a Decision Flow, it reconstructs the flow's public input shape and can use the behavior of bound Decision Tables and Lookup Tables as additional context.

Depending on the resource and request, it can generate:

* Representative or random input examples
* Inputs satisfying particular conditions
* Inputs targeting selected Decision Table rows or requested outcomes
* Boundary, overlap, and uncovered cases
* Refined versions of an existing Test Bench input

Review generated values before using them in Test Bench or automated tests.

#### Test Suite Generator

**AI Assistant:** Decision Table Detail, Scripting Rule Detail\
**Authoring MCP:** `generate_test_suite` followed by `import_generated_test_suites` after review

Test Suite Generator proposes a named suite containing representative test inputs for the exact open rule version. It can focus on happy paths, boundary cases, invalid inputs, or another requested area.

The AI does not invent expected outputs. When you select **Import Test Suite**, DecisionRules solves the exact saved rule version and fills the expected outputs before persisting the suite.

{% hint style="warning" %}
Review the proposed scenarios before importing them. After import, run the suite and inspect the results before relying on it for regression testing.
{% endhint %}

#### Generate Rule Summary

**AI Assistant:** Decision Table Detail

Generate Rule Summary produces a human-readable explanation of the open Decision Table. For simple tables, it can describe the complete logic. For larger tables, it focuses on the main structure, behavior, and public input and output model.

Use summaries to support reviews and communication, but verify important details against the table itself.

#### Templates Helper

**AI Assistant:** Rules List

Templates Helper rewrites a described use case into a focused template search and recommends the most relevant DecisionRules templates with short explanations.

### Conversation Context

#### Suggested Follow-ups

**AI Assistant:** Responses where the selected agent provides follow-up suggestions

The Assistant can display suggested next prompts beneath a response. Select one to send it to the same agent and continue the current task.

#### File Import

**AI Assistant:** Pages where attachments are supported by the selected AI model

Attach a file with the attachment button, drag it into the chat, or paste a supported file from the clipboard. The Assistant can use the written prompt and attached content in the same request.

Supported file types include `PDF`, `TXT`, `MD`, `CSV`, `XLSX`, `DOCX`, `XML`, and selected IBM ODM formats. Each file must not exceed `10 MB`.

Attachment availability depends on the selected AI model and provider configuration.

#### Space Knowledge

**AI Assistant:** Pages where the AI Assistant can use current space context

Space Knowledge provides persistent context associated with the selected space. It helps the Assistant give relevant guidance without requiring users to repeat shared background information in every prompt.
