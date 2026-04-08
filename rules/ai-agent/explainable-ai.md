# Explainable AI

When an **AI Agent** returns a result, it is not always obvious how it got there. A score of 72, a "high" risk tier, a recommended action — these come from the model's reasoning over the input, but none of that reasoning is visible in the output by default.

**Explainable AI** surfaces that reasoning as structured data alongside the main result, so you can see not just what the model concluded, but how confident it was and what evidence it used.

## How It Works

When the **Explainable AI** toggle is enabled in the sidebar, the platform automatically adds an `explanation` object to every response. You do not define these fields — they are injected by the platform and populated by the model on every execution.

<figure><img src="../../.gitbook/assets/Frame 15.png" alt=""><figcaption></figcaption></figure>

Enabling **Explainable AI** increases the number of tokens the model must generate, which adds latency and cost to each call. Enable it where the reasoning is genuinely useful — not by default on every rule.

{% hint style="warning" %}
When enabled, the `explanation` fields also appear in the **Output Model**. If you are using the rule output in downstream rules or mapping fields in a Flow, make sure not to remove them from the model — doing so will drop the explanation data from the response.
{% endhint %}

### The explanation Object

The `explanation` object contains four fields. Together they give you a full picture of how the model arrived at its output — what it was confident about, what it had to infer, and where in the input it found each value.

<table><thead><tr><th width="164.216552734375">Field</th><th width="87.689697265625">Type</th><th>Content</th></tr></thead><tbody><tr><td><code>probability</code></td><td>Number</td><td>A score from 0 to 1 representing overall confidence in the complete output. Close to 1 means everything was clear and explicit. Lower means some fields had to be estimated or inferred.</td></tr><tr><td><code>reason</code></td><td>Text</td><td>A plain language paragraph walking through how the model arrived at the output — field by field, noting what was stated directly, what was implied, and what had to be read between the lines.</td></tr><tr><td><code>source_fragments</code></td><td>Array</td><td>The exact phrases or sentences from the input that were used to determine the output values, copied verbatim.<br>Can be empty if no clear source can be identified.</td></tr><tr><td><code>warnings</code></td><td>Array</td><td>Plain language warnings about fields the model extracted with less than full confidence — because the input was ambiguous, a figure was an estimate, or a value had to be inferred.<br>Empty array if everything was determined with full confidence.</td></tr></tbody></table>

#### The example output:

```json
"explanation": {
      "probability": 0.98,
      "reason": "The NDA submission fails several company standards. 
                  Explicitly, the confidentiality period (2 years), notice period (14 days), 
                  non-compete duration (24 months), liability cap ($50,000), and return 
                  deadline (30 days) were all outside permitted ranges and required 
                  correction to the minimum or maximum allowed thresholds...",
      "source_fragments": [  // were extracted from NDA_Standart.pdf
        "3 years minimum",
        "litigation acceptable",
        "mutually agreed EU member state",
        "Minimum $100,000",
        "12 months maximum",
        "For one-way NDAs, non-solicitation is recommended but not mandatory.",
        "30 days minimum",
        "Not permitted — must be excluded",
        "deadline 14 days maximum"
      ],
      "warnings": [
        "The acceptance of 'Germany' as governing law assumes it is a mutually agreed EU member state as per section 2.",
        "Non-solicitation is compliant only because this is a one-way NDA."
      ]
}
```

## Accessing the Explanation

The `explanation` object is part of the standard rule output — nothing special is needed to retrieve it. It sits alongside your defined output fields in the response.

When called via the [Rule Solver API](https://docs.decisionrules.io/doc/api/rule-solver-api):

```json
{
  "decision": { ... },
  "risk_profile": { ... },
  "explanation": {
    "probability": 0.87,
    "reason": "...",
    "source_fragments": [ ... ],
    "warnings": [ ... ]
  }
}
```

In a Flow, after an AI Agent node, the fields are available as:

```
[node name].output.explanation.probability
[node name].output.explanation.reason
[node name].output.explanation.source_fragments
[node name].output.explanation.warnings
```

## Using Explainability in Practice

The most practical use of the `probability` score is as a routing signal. After an AI Agent node, add a Switch node that checks the score — if it falls below a defined threshold, route the record to a manual review branch. The reviewer then has `reason` and `source_fragments` available to quickly understand what the model found and where, without having to read the original document in full.

```
AI Agent → Switch on explanation.probability
              < 0.75  → flag for manual review
              >= 0.75 → continue automated processing
```

{% hint style="info" %}
The threshold you choose depends on your use case and acceptable risk — there is no universal value.
{% endhint %}
