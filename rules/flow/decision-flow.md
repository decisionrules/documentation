# Decision Flow

This section introduces the DecisionRules Decision Flow feature and gives a high-level overview of its possible applications.

Decision Flow is a feature brought in version 1.19.0 of DecisionRules. It allows to design complex decisioning processes. It can be used to orchestrate other rules, make data transforms and calculations, run inline scripts, perform conditional branching, call external API, DB connectors, and more. The list is not final. Decision Flow will be given even more capabilities in the future, like integrations to 3rd party tools, etc.

## Decision Flow Features

Looking at its versatility and potential, Decision Flow can be considered a whole new feature category within the DecisionRules universe. After all, with Decision Flow in its repertoire, DecisionRules are gaining some of the major capabilities of a Decision Flow engine. On the other hand, from the user's perspective, Decision Flow fits perfectly into the same picture as other rules. It is listed as an item in the folder structure, it has the same settings, and it has a designer tab for editing the Decision Flow.

Like its predecessor, the [Rule Flow](../rule-flow/), Decision Flow is built by placing boxes on canvas and connecting them with lines. The boxes are called nodes (as in a graph), and the lines are called connections. Unlike in Rule Flow, there are numerous types of nodes, and the connections also have slightly different meaning, which will be explained on following pages of this doc section.

