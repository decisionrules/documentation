---
description: >-
  This page lists the tools available in the AI Assistant. Selected tools are
  described in detail on their dedicated sub-pages.
---

# AI Assistant Tools

## AI Tools Overview

This section lists all tools available within the AI Assistant and explains their purpose, scope, and availability inside **DecisionRules**.

### Answer Questions, Search Docs and Highlight UI Elements

Availability: All pages with the AI Assistant panel

AI Assistant is designed to be a true assistant. It tries to answer any relevant questions regarding the platform, your use-case and other related topics. In its answers, it combines common knowledge (stemming from its LLM base) and specific DecisionRules knowledge.

What more, the AI Assistant is able to search the entire DecisionRules Docs and provide precise answers with reference links to the related Docs pages. Thanks to this the user no longer needs to search the documentation — they can get relevant answers and explanations right in the app. Besides the Docs, AI Assistant is also able to search the DecisionRules Academy.

Last but not least, AI Assistant is able to highlight a chosen UI element within the DecisionRules app. This can be useful when the user is searching for a specific feature or element in the app.

### Create Decision Table

Availability: Rules List

The AI Assistant can generate a new Decision Table based on natural-language instructions provided by the user. It guides the user through the process by asking clarifying questions when needed and then creates a structured Decision Table that reflects the described logic.

This tool can be used directly from the Rules List page and supports rapid rule prototyping without manual table setup.

Read more on a dedicated [Create Decision Table](create-decision-table.md) page.

### Generate Functions

**Availability:** Decision Table Detail

The AI Assistant can generate valid function expressions for selected cells within a Decision Table. It is aware of the cell context, including available variables, and uses DecisionRules function definitions correctly.

In addition to generating new expressions, the AI Assistant can:

* Explain existing function expressions and their results
* Debug and adjust existing functions
* Combine multiple functions to achieve the desired behavior

{% hint style="info" %}
Click a cell to select it. You can see the selected cell at the bottom of the AI Assistant panel, and you can cancel the selection by clicking the cross.
{% endhint %}

This tool helps users implement complex logic while maintaining correctness and readability.

### Generate Test Data

**Availability:** Decision Table Detail

The AI Assistant can generate input data for Decision Table evaluation. It supports both single and bulk input generation and takes into account the Decision Table definition and the selected evaluation strategy.

It can generate:

* Random input data examples
* Input data satisfying specific conditions
* Input data matching selected rows of the Decision Table
* Input data resulting in specific outputs
* Input data testing edge cases, overlaps, or boundary conditions
* Input data not matching any row (uncovered cases)

The AI Assistant can also help adjust or refine existing input data to meet specific testing requirements.

### Generate Rule Summary

**Availability:** Decision Table Detail

The AI Assistant can generate a human-readable summary of a Decision Table. For simple tables, the summary may describe the complete logic. For larger or more complex tables, it focuses on the main structure, conditions, and outcomes.

This tool is intended to improve understanding, reviews, and communication of decision logic, without requiring readers to analyze the full table structure.

