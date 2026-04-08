# AI Agent Best Practice

Building an AI Agent that works reliably in production is not just about writing a prompt. It requires thinking clearly about what job the agent is doing, what data it needs, what it should return, and how it fits into the larger decision flow around it. This page covers the principles that make the difference between an agent that works in a demo and one that works in production.

## Start With the Job, Not the Prompt

Before you open the designer, define what the agent is actually supposed to do. The most common mistake is building an agent that tries to do too many things at once — extract data, evaluate it, score it, and write a summary all in one rule. That produces an agent that does everything adequately and nothing well.

We have identified four task patterns that cover the vast majority of real-world AI Agent use cases in DecisionRules:

<table><thead><tr><th width="153.90447998046875">Role</th><th>What it does</th></tr></thead><tbody><tr><td><strong>Decision Maker</strong></td><td>Evaluates input and produces a decision, score, or routing outcome</td></tr><tr><td><strong>Deep Analyzer</strong></td><td>Reads documents, records, and signals to extract structured intelligence</td></tr><tr><td><strong>Report Writer</strong></td><td>Condenses complex input into a concise, decision-ready narrative</td></tr><tr><td><strong>Policy Validator</strong></td><td>Checks data against rules and standards; <br>Fixes and normalizes non-conforming records</td></tr></tbody></table>

Together these four patterns cover around 95% of tasks you would want to automate with an AI Agent in DecisionRules. Before you build, ask yourself which one your use case maps to. If it maps to more than one, split it into multiple agents. And if none of them fit — you are not limited to these patterns. Define the role and task freely from scratch in the prompt.

A well-scoped agent is easier to prompt, easier to annotate, easier to test, and easier to maintain when something changes.

### Role & Task Templates

**Decision Maker**

```
## ROLE
You are a [domain] risk analyst with deep expertise in [field].

## TASK
Evaluate the input and produce a scored assessment with a recommended action.
```

**Deep Analyzer**

```
## ROLE
You are a [domain] specialist with deep expertise in [field].

## TASK
Read the submitted document and extract all structured fields defined in the output schema.
```

**Report Writer**

```
## ROLE
You are a [domain] analyst with expertise in [field].

## TASK
Produce a concise, plain-language summary of the input that a [audience] 
can act on without reading the source data.
```

**Policy Validator**

```
## ROLE
You are a [domain] compliance reviewer with expertise in [field].

## TASK
Check the submitted data against the defined policy and flag 
or correct any non-conforming values.
```

## Writing Effective Prompts

### Structure Is Not Optional

Models read your prompt from top to bottom, in order. What comes first shapes how everything after it is interpreted — the role you define at the top influences how the model reads the context, and the context influences how it approaches the task. This is why the order matters:

1. **`## ROLE`** — tells the model who it is and what expertise it brings. This frames all subsequent reasoning
2. **`## CONTEXT`** — gives the model the data it needs to work with. Comes after ROLE so the model reads it through the right lens
3. **`## TASK`** — tells the model what to do with that context. Comes last because it depends on both

```
## ROLE
You are a [domain expert] with deep expertise in [relevant field].

## CONTEXT
[Describe what the model is looking at — reference your input
variables here so the model has all the data it needs.]

{input.field_one}
{input.field_two}

## TASK
[Describe the overall job the model should perform for this rule —
what it is evaluating, analyzing, or processing as a whole.
Do not list individual output fields here; those are defined in Annotations.]
```

### Prompt Formatting

Use `##` headers to create these anchors — they signal to the model where one concern ends and another begins. A flat wall of text with no structure forces the model to infer the structure itself, which it will do inconsistently.

For emphasis within a section — to highlight a constraint or a rule that must not be broken — use `**bold text**`. It signals to the model that those parts carry higher priority than the surrounding prose.

### Label Your Variables

When the model receives `{applicant.score}` it gets the value `45`. It does not know that `45` is a credit score, a debt ratio, or a temperature — it just gets `45`. Always provide context around your variables so the model knows what it is looking at:

```
## CONTEXT
Wrong:
    {applicant.score}
    
Right:
    Credit score: {applicant.score}
    Debt-to-income ratio: {applicant.dti}
    Savings balance: ${applicant.savings}
```

### Prompt Comparison

#### Good Prompt

```
## ROLE
You are a senior medical reviewer with deep expertise in
utilization management and clinical necessity assessment.

## CONTEXT
You are reviewing a prior authorization request for the following patient:

{patient.name} is a {patient.age}-year-old {patient.gender} diagnosed
with {patient.diagnosis} ({patient.diagnosis_code}).

Requested treatment: {treatment.procedure} — {treatment.duration_months}-month
course, estimated cost ${treatment.estimated_cost_usd}.

Prior treatments attempted:
{clinical.prior_treatments}

Clinical notes from {treatment.requesting_physician}:
{clinical.notes}

Reference the attached treatment guidelines when assessing
clinical necessity and step therapy compliance:
{attachments.Treatment_Guidelines.pdf}

## TASK
Evaluate the request against clinical necessity criteria and
insurance policy compliance.
**Base your assessment only on the data and guidelines provided.**
**Do not approve treatments that have not met step therapy requirements.**
```

#### Bad Prompt

```
Review this patient and tell me if treatment should be approved.
Return approval_status, risk_score, and justification.

{patient.name} {patient.age} {patient.diagnosis}
{treatment.procedure} {treatment.estimated_cost_usd}
{clinical.prior_treatments} {clinical.notes}
```

**What is wrong:**

* **No ROLE** — the model has no clinical or policy expertise to draw on
* **Variables dumped without labels** — `{patient.age}` delivers `34`, `{treatment.estimated_cost_usd}` delivers `24000`. The model receives a sequence of raw numbers and strings with no indication of what any of them represent
* **Attachment not referenced** — the guidelines file is attached to the rule but never referenced in the prompt, so it is never sent to the model
* **Output fields in the prompt** — `approval_status`, `risk_score`, `justification` belong in Annotations, not here
* **No constraints** — nothing tells the model what step therapy means, what the cost threshold is, or what counts as clinical necessity

## Writing Effective Annotations

Annotations are not labels or comments — they are instructions. The model reads every description as a directive for what to produce. A vague description produces vague output. A precise description produces output your downstream rules can depend on.

The key shift is this: stop thinking about what a field _is_ and start thinking about what the model needs to _know_ to fill it correctly.

The name `risk_tier` tells the model nothing. \
The description `Risk tier derived from overall_risk_score. Allowed values: low · moderate · high · critical. Return null if overall_risk_score is null.` tells it everything.

### How to Write Each Type

* **Enumerations** — list every allowed value explicitly. If the field is used in a downstream Switch or Decision Table, the values must match exactly: \
  `Allowed values: approve · conditional_approve · refer_to_underwriter · decline`
* **Booleans** — state both conditions. Never leave the false case implicit: \
  `True if debt-to-income ratio exceeds 0.40. False if within acceptable threshold.`
* **Scores** — define the range, what drives each end, and how to compute it: \
  `Range: 0 (no risk) to 100 (extreme risk).` \
  `Weighted: clinical necessity 45%, cost appropriateness 30%, policy compliance 25%.` \
  `Round to the nearest integer.`
* **Text summaries** — specify length and what evidence must be cited: \
  `2–3 sentence explanation citing at least one specific finding from the clinical notes or prior treatment history.`

### Be Consistent With Null

If one field returns `null` when data is missing and another returns `"unknown"` and a third returns an empty string, your downstream Decision Table needs three separate conditions to handle each case — and will still break silently when the model returns something unexpected. Pick one fallback for the whole rule and apply it everywhere. `null` is the recommended choice because it is the easiest to catch with a single `IS NULL` condition.

### Annotation Comparison

#### **Good annotations**

<table><thead><tr><th width="225.93316650390625">Field</th><th width="97.0078125">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>commercial_terms</code></td><td>Object</td><td>Key commercial terms extracted directly from the contract document.</td></tr><tr><td>     <code>initial_term_months</code></td><td>Number</td><td>Duration of the initial contract term in months as stated in the document. <br>Return null if not specified.</td></tr><tr><td>     <code>auto_renewal</code></td><td>Boolean</td><td>True if the contract renews automatically at the end of each term without affirmative action. <br>False if renewal requires explicit agreement. <br>Return null if the renewal clause is absent.</td></tr><tr><td>     <code>fee_increase_cap_pct</code></td><td>Number</td><td>Maximum percentage by which fees may increase annually as stated in the document. <br>Return null if no cap is defined.</td></tr><tr><td>     <code>foreign_jurisdiction</code></td><td>Boolean</td><td>True if the governing law is outside the Czech Republic. False if governed by Czech law. <br>Return null if no governing law clause is present.</td></tr></tbody></table>

#### **Bad annotations**

<table><thead><tr><th width="229.1995849609375">Field</th><th width="94.8836669921875">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>commercial_terms</code></td><td>Auto</td><td>Commercial info.</td></tr><tr><td>     <code>initial_term_months</code></td><td>Auto</td><td>The term.</td></tr><tr><td>     <code>auto_renewal</code></td><td>Auto</td><td>True if auto renewal.</td></tr><tr><td>     <code>fee_increase_cap_pct</code></td><td>Auto</td><td>Fee cap.</td></tr><tr><td>     <code>foreign_jurisdiction</code></td><td>Auto</td><td>True if foreign.</td></tr></tbody></table>

**What is wrong:**

* **Auto on every field** — `initial_term_months` is a Number, `auto_renewal` is a Boolean. The model has no type contract to follow
* **"The term"** — is this months, years, days, or a string like "twelve months"? The model will decide for itself, differently on every call
* **"True if auto renewal"** — circular. Does not define what auto renewal means or what evidence to look for in the document
* **"Fee cap"** — no unit, no instruction on what to return if no cap exists in the document
* **"True if foreign"** — foreign to what? The model does not know your jurisdiction
