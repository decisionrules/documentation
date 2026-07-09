# Settings

The Settings page allows you to manage personal preferences such as language, currency, appearance, and default editor types. It also provides a Hard Restart option for refreshing the application work.

## Preferences

The **Preferences** tab contains settings that affect how the application is displayed and how selected editors open by default.

<figure><img src="../.gitbook/assets/image (417).png" alt=""><figcaption></figcaption></figure>

### Managing Language

The **Language** setting allows you to change the language of the DecisionRules application.

The new language is applied immediately after you select it.

### Managing Currency

The **Currency** setting allows you to choose the currency used for displaying plan prices and other billing-related prices.

Available currencies are:

* EUR
* USD
* GBP

Please note that this option is available only before you subscribe to a specific plan. After a purchase, the currency is fixed and cannot be changed from this setting.

### Managing Appearance

The **Appearance** setting allows you to switch the application between **Light** and **Dark** mode.

The selected appearance is applied immediately and is remembered for future use.

### Managing Default Model Editor Type

The **Default Model Editor Type** setting defines which editor is used by default when working with rule input and output models.

Available options are:

* **Simple Editor** - displays the model in a structured visual editor.
* **JSON Editor** - displays the model directly as JSON.

This setting changes the default editor view. It does not change the model data.

### Managing Default Test Bench Editor Type

The **Default Test Bench Editor Type** setting defines which editor is used by default in the Test Bench.

Available options are:

* **Simple Editor** - provides a structured editor for test input and output.
* **JSON Editor** - allows editing test data directly as JSON.

This setting changes the default Test Bench editor view. It does not change saved test data.

## Hard Restart

The **Hard Restart** tab provides a way to refresh your workspace without deleting your rules, settings, or content.

Use **Hard refresh page** when you want to reload the application, clear temporary cache, and apply the latest configuration.

This can be useful when the application does not reflect recent changes or when you want to make sure it is running with the latest available settings.

No rules, settings, or content are removed by Hard Restart.

<figure><img src="../.gitbook/assets/image (418).png" alt=""><figcaption></figcaption></figure>

## Danger Zone

The **Danger Zone** tab is available only in Docker deployments. It is not available in DecisionRules Cloud.

Danger Zone allows you to permanently delete your account from the Docker environment.

This action removes your personal data, preferences, and access. It cannot be undone.

Before using this option, make sure you understand the impact of deleting the account. The deletion is permanent and irreversible.
