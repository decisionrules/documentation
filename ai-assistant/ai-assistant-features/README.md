---
description: >-
  This page lists the features available in the AI Assistant. Selected features
  are described in detail on their dedicated sub-pages.
---

# AI Assistant Features

## AI Features Overview

This section lists all features available within the AI Assistant and explains their purpose, scope, and availability inside **DecisionRules**.

#### General Assistant

**Availability:** All pages with the AI Assistant panel

The General Assistant handles general conversation and broad assistance inside the platform. It is used when the request does not clearly indicate a more specialized task.

It can help users with general product orientation, basic guidance, and simple follow-up questions. It can also direct users toward other supported AI capabilities such as rule creation, function generation, documentation search, Academy search, and UI navigation.

#### Documentation Search

**Availability:** All pages with the AI Assistant panel

Documentation Search answers questions using the DecisionRules documentation. It searches the full DecisionRules Docs and returns concise answers based only on documented content.

It is useful when users want reliable product explanations, configuration guidance, or links to the relevant documentation pages.

#### Academy Search

**Availability:** All pages with the AI Assistant panel

Academy Search helps users find relevant learning materials in DecisionRules Academy. It searches Academy courses, tutorials, and other educational content and recommends the most relevant results.

It is useful when users want to learn a feature step by step, find training materials, or discover content suited to their current level or topic.

If the request is too broad, the Assistant may ask a clarifying question to narrow the search.

#### Navigation Helper

**Availability:** All pages with the AI Assistant panel

Navigation Helper can be used to find features and controls in the DecisionRules application.

It can guide users to the next relevant page, panel, or control based on the currently visible UI. If the requested element is visible, it can highlight it directly in the interface. If the element is hidden or located on another page, it explains what to open or where to navigate first.

For some UI-related questions, it can also add short documentation-based clarification about what a feature does or how to choose between nearby options.

#### Decision Table Architect

**Availability:** Rules List

The Decision Table Architect generates a new Decision Table from natural-language instructions. It asks clarifying questions when required and then creates a structured table that matches the described logic.

The generated result is validated against the required Decision Table structure before it is offered in the UI. This helps ensure the created table is structurally correct and ready for further editing.

It is available directly on the Rules List page and supports rapid rule prototyping without manual table setup.

Read more on the dedicated [Create Decision Table](create-decision-table.md) page.

#### Scripting Rule Architect

**Availability:** Rules List, Scripting Rule Detail

The Scripting Rule Architect works with DecisionRules Scripting Rules.

On the Rules List page, it can generate a new scripting rule from natural-language instructions. On the Scripting Rule Detail page, it can also prepare updates to an existing scripting rule based on the user’s request.

It is useful for imperative or code-based logic that is better expressed as a scripting rule than as a Decision Table.

If the requested scripting logic depends on existing rules, the Assistant can take folder and rule structure into account before generating references.

#### Generate Functions

**Availability:** Decision Table Detail

This feature allows to generate valid function expressions for selected cells in a Decision Table. It understands the cell context, including available variables, and uses DecisionRules function definitions correctly.

In addition to generating new expressions, it can:

* Explain existing function expressions and their results
* Debug and adjust existing functions
* Combine multiple functions to achieve the desired behavior

{% hint style="info" %}
Click a cell to select it. You can see the selected cell at the bottom of the AI Assistant panel, and you can cancel the selection by clicking the cross.
{% endhint %}

This feature therefore helps users implement complex logic while maintaining correctness and readability.

#### Generate Test Data

**Availability:** Decision Table Detail, Scripting Rule Detail

This feature allows to generate input data for Decision Table evaluation. It supports both single and bulk generation and takes into account the table definition and the selected evaluation strategy.

It can generate:

* Random input data examples
* Input data satisfying specific conditions
* Input data matching selected rows of the Decision Table
* Input data resulting in specific outputs
* Input data testing edge cases, overlaps, or boundary conditions
* Input data not matching any row (uncovered cases)

It can also adjust or refine existing input data to meet specific testing requirements.

The generated inputs follow the available input schema fields so they can be used directly for testing.

#### Generate Rule Summary

**Availability:** Decision Table Detail

This feature allows to generate a human-readable summary of a Decision Table. For simple tables, the summary may describe the complete logic. For larger or more complex tables, it focuses on the main structure, conditions, and outcomes.

The summary also includes a compact overview of the rule’s input and output structure to make the rule easier to review and communicate.

This feature therefore improves understanding, reviews, and communication of decision logic without requiring readers to analyze the full table structure.

#### Templates Helper

**Availability:** Rules List

The Template Helper recommends DecisionRules templates based on the user’s described use case.

It rewrites the user’s request into a focused template-search query and returns the most relevant matching templates with short descriptions. This helps users start from an existing template instead of building a rule from scratch.

It is useful when users know the business problem they want to solve but are not sure whether a suitable template already exists.
