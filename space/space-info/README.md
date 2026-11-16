# Space Info

The **Space Info** page provides a detailed overview of the selected space, displaying essential details that help you manage and identify it. This section allows you to monitor key attributes of the space, including user access, API key usage, and rule count.

<figure><img src="../../.gitbook/assets/space_info_detail.png" alt=""><figcaption></figcaption></figure>

### **Space Details**

This section includes fundamental information about the space:

* **Name** - The assigned name of the space, which can help distinguish it from others.
* **Space ID** - A unique identifier used to reference the space, often needed for API calls and integrations.
* **Space Owner** - The user who owns the space and has the highest level of control, including managing settings, users, and permissions.
* **Organization** - The organization to which the space belongs, typically representing a company or team using the platform.
* **Your Space Role** - Your assigned role within the space, defining what actions and features you are allowed to access. On organization spaces the card is called **Your Space Roles**.
* **Number of Users** - Displays the total number of users who have access to the space, helping administrators manage permissions effectively.
* **Number of Rules** - Shows the total number of rules created within the space, helping track its complexity and usage.
* **Number of API Calls Today and Per Period** - Displays the number of API requests executed today and within the current billing period, helping monitor usage.

### **Space Versioning**

The **Space Versioning** card shows whether the space keeps its changes as revisions: an **Enabled** or **Disabled** badge and one sentence, "This space has active revision management." or "Revision management is turned off for this space." On a private space it says "Space Versioning is available only on organization-owned spaces."

On an organization space the card has a **Revision Settings** button. It opens [Space Settings](../settings.md), tab **Revision Settings**, where Space Versioning is switched on and off:

* **Enable Versioning** shows a confirmation that explains what changes for editors and integrations.
* **Disable Versioning** asks you to type the space name to confirm.

Both buttons are shown only to users with the **Change Versioning Settings** permission. Space Versioning is available to accounts that have it: during the trial, or as an add-on from our sales team. Self-hosted deployments need a licence that includes it. Read more in [Space Version Control](../space-version-control/).

### **Removing a Space**

If a private space is no longer needed, you have the option to delete it using the **Delete** button. This action **permanently deletes** the space along with all its associated data, including rules and API keys, other users permissions. <mark style="color:red;">Since this process</mark> <mark style="color:red;">**cannot be undone**</mark><mark style="color:red;">, it should be performed with caution.</mark> Only users with the necessary permissions can remove a space.
