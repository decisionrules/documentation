# About AI Assistant

The DecisionRules AI Assistant is a versatile, LLM-based tool designed to enhance the way business rules are created, tested, optimized, and understood within the DecisionRules platform. It provides contextual assistance directly in the application, combining general language model capabilities with DecisionRules-specific knowledge to support users throughout the rule lifecycle.

The AI Assistant offers a set of focused tools, including answering platform- and rule-related questions, searching the DecisionRules Documentation and Academy, highlighting relevant UI elements, generating Decision Tables, preparing test input data, writing and debugging function expressions, and producing human-readable summaries of Decision Tables. Each tool is available in specific parts of the application and operates with awareness of the current user context, such as the active page or selected Decision Table.

## Suggestions

Upon opening the AI Assistant panel, you will find a set of predefined **suggestions**. Selecting one of these options will automatically populate the input with an example prompt. The assistant will then generate a corresponding response. This feature provides a quick and guided way to understand the assistant’s behavior and output format.

## Tools

Apart from asking questions and letting the assistant provide answers, you can also take advantage of several predefined tools, each serving a specific purpose. You do not need to care — the assistant will try to use a suitable tool automatically when it can be inferred from context. However, if you have a specific task in mind, you may choose the tool explicitly using the dropdown inside the chat input. This can help the assistant provide better output, because it knows which tool to use.

See more details about the available tools on the [AI Assistant Tools](ai-assistant-tools/) page.

{% hint style="success" %}
Our team is continually extending and improving the skill set of the AI Assistant. If you are missing some useful feature or tool, please contact our Sales and we will be happy to discuss it.
{% endhint %}

## Accessing AI Assistant

The AI Assistant is currently available on **Lite Plan** or higher, and it is also included in the **Free Trial** so new users can try it out as part of our enhanced onboarding experience. It is placed in the right panel. If not already open, you can open up the assistant panel by clicking the **AI Assistant** button in the top right corner of the page.

## About the Model and Limits

The assistant is powered by **Gemini for Business**. We are currently using the model `gemini-3-flash-preview`. The exact versions may change in the future.

{% hint style="success" %}
Your privacy is fully respected. **No user data is used to train any AI model**, and nothing is shared outside Decision Rules application. See more information about data governance [here](https://cloud.google.com/vertex-ai/generative-ai/docs/data-governance) and [here](https://cloud.google.com/gemini/docs/discover/data-governance).
{% endhint %}

Current usage limits for the assistant are defined by your **subscription plan**. If you are on a free trial, paid Lite or higher tier, you will have access to a limited number of AI generations each month.
