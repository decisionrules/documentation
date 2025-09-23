---
description: >-
  A broad application redesign that brings a smoother, more consistent user
  experience across the platform, and new validations, enhanced security and
  more, to ensure safer and more reliable usage.
---

# Changes in Version 1.21.2 (09/2025)

## Application Redesign (Phase 2)

In this phase, we modernized several core components that were still on the older design system. **Decision Tables**, **Decision Trees**, **Scripting Rules**, and **Decision Flows** (partially) now follow the unified design introduced in the first redesign phase, improving clarity, navigation, and overall usability.

{% hint style="info" %}
This is part of an ongoing redesign initiative, with additional phases planned to bring the same modern, consistent experience to the rest of the platform and further improve the current functionality.
{% endhint %}

### Rule Settings – major redesign

* The Input/Output model now has its own dedicated page for better clarity and easier work with complex models.
* Other settings (rename, description, tags, audit log settings, etc.) are now organized in a toggleable left-side panel, streamlining navigation and keeping everything accessible without clutter.

<figure><img src="../../.gitbook/assets/Snímek obrazovky 2025-09-17 v 10.45.14.png" alt=""><figcaption></figcaption></figure>

### Event Logs – refreshed access and usability

* Open Event Logs directly from Rule Settings via the side panel, which redirects to the Event Logs page with the relevant rule preselected.
* Alternatively, access them from Space → Event Logs to review logs for the entire space or filter by individual rules.
* Looking ahead: Event Logs will undergo a further refactor in the near future, expanding functionality to cover rule manipulation and key aspects of user activity across spaces and rules.

Together, these updates combine visual redesign, functional improvements, and bug fixes, delivering a more seamless and reliable experience across the app.

## Validations, Security, Error Handling & more

{% hint style="danger" %}
**IMPORTANT**: Due to the changes listed below, some API requests may no longer function as they did before. Please review your implementation, testing your integrations to ensure compatibility. If you encounter any issues, don’t hesitate to contact our support team.
{% endhint %}

### Validations

The following validations were added for Management API and application:

* All names, such as space names, organization names, API key names, folder names, rule names, and rule aliases, have a maximum length of 100 characters.
* All rule types have defined constraints including maximum name and alias length, rule type, status, audit log structure, and support for positive TTL (Time to Live).
* API key can only be set for supported types.
* In organizations, the SSOConfig callback URL must be in a valid URL format.
* Space Roles can only be assigned existing Permissions.
* The validation of rules affects actions, including folder importing and others.

### Endpoint changes

* Several new endpoints have been added for **Space editing**:&#x20;
  * Renaming a Space
  * Creating a Role
  * Updating a Role
  * Deleting a Role, and assigning a Role to a User.&#x20;

{% hint style="info" %}
These changes aim to enhance exploit prevention and do not affect the Management API.
{% endhint %}

*   #### Update Overview

    The Rule Event endpoint has been updated to `/event/space/:spaceId/rule/:ruleId/:version` from `/event/rule/:ruleId/:version`. Additionally, exploit prevention measures have been integrated, which include `/event/space/:spaceId`. Security enhancements have also been implemented in the registration process.

### Error handling

#### Updated HTTP Error Response Structure:&#x20;

Backend server HTTP responses containing error codes will now include **additional headers** for improved debugging:

* **Error Type**: Specifies the category of the error.
* **Error Code**: Provides the specific error identifier.
* **Error Message**: Gives a brief description of the error.
* **Overwrite Headers**: More information about given error.

### Other Security Measures

* The space data attributes retrieved from the backend are determined by permissions, including API key read, rule read, view space users, and view space roles.
* **Rate limits** were added to these endpoints:&#x20;
  * /register - Maximum 200 request in 10 minutes
  * /forgot, /reset,/resendVerificationEmail - Maximum 3 request in 10 minutes
  * /space/invitation/:spaceId, /organization/:id/member/invite - Maximum 10 request in 10 minutes&#x20;
* #### Space Role Permissions
  *   The features **Add Condition Column** and **Add Result Column** have been merged into **Add Column**. Similarly, **Delete Condition** and **Delete Result** have been merged into **Delete Column**. The functionality of **Rename Condition** has been upgraded and is now called **Change Column Definition**, allowing you to rename columns and modify both input (condition) and output (result) targets under the column name.

      **Important:** Roles that currently have permissions for only _**Add Result**_ or _**Delete Result**_ will lose these permissions.

### Other changes

* Space modifications now auto-save.
