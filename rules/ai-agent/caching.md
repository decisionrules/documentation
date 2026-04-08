# Caching

When an **AI Agent** executes, it sends the input to the AI model, waits for a response, and returns the result. For rules that receive the same input repeatedly, this means paying the same latency and model cost on every single call — even when the answer would be identical.

Caching solves this by storing the output of each execution and returning it directly on any subsequent call that arrives with the same input, without touching the model at all.

## How It Works

When **Cache AI Response** is enabled, the rule stores its output after each execution. The cache is keyed on the **input data** — two calls with identical input return the same cached output. If any input value changes, the cache is bypassed and a fresh model inference is made.

<figure><img src="../../.gitbook/assets/Frame 14.png" alt=""><figcaption></figcaption></figure>

The cache is active for **60 seconds** from the last execution. After that, the next call triggers a new inference and the result is cached again.

### What Gets Cached

The entire rule output is cached — including the `explanation` object if Explainable AI is enabled. Any downstream rule or Flow node receives the cached response exactly as if it were a live model call.

### Scope

Caching is configured at the rule level and applies wherever the rule is executed — whether called directly via the [Rule Solver API](https://docs.decisionrules.io/doc/api/rule-solver-api) or triggered from a Flow via the AI Agent node.

## When to Enable It

Caching is most valuable as a safety net against redundant calls — situations where the same input reaches the rule more than once within a short window, not because something changed, but because of how the surrounding system behaves. A user clicking twice, a Flow branch evaluating the same record in parallel, a retry after a timeout. In these cases the model would return the same result every time, and caching makes sure you only pay for it once.

If your inputs are unique on every call, or your use case requires a fresh inference regardless of whether the input has changed, caching adds no value and should be left off.

## Limitations

* The cache **cannot be manually cleared** — it expires automatically after 60 seconds
* Caching is **per rule version** — each published version maintains its own cache independently
