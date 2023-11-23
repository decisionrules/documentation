---
description: >-
  This article helps with basic navigation of the Folders functionality of
  Decision Rules
---

# Folders

{% embed url="https://www.youtube.com/watch?t=21s&v=0L0YsddlEUs" %}

### Navigating Folders

Clicking the <img src="../.gitbook/assets/image (261).png" alt="" data-size="line"> button in the app sidebar opens the Folders menu.

<figure><img src="../.gitbook/assets/image (253).png" alt=""><figcaption></figcaption></figure>

Clicking on a Folder selects it and displays the contents on the screen.

<figure><img src="../.gitbook/assets/image (207).png" alt=""><figcaption><p>Secret Folder contains only one rule - Tall Tree, therefore only Tall Tree is displayed in the overview </p></figcaption></figure>

### Folders overview screen controls bar

<figure><img src="../.gitbook/assets/image (66) (1).png" alt=""><figcaption></figcaption></figure>

The **View**, **Filter** and **Sort by** selectors help us manage which rules we'd like to display.

The **View** selector lets us choose whether to display only the rules inside our selected Folder or all rules across the entire Space we're currently in.

Using the **Filter** selector, we can define the types of rules to be displayed.

Lastly, the **Sort by** selector controls the ordering of the displayed rules.&#x20;

* Name - Sorts rules in an alphabetical order by name
* Time - Sorts rules from the latest updated rule to the oldest.
* Default - Sorts rules as they appear in the Folder manager.

{% hint style="info" %}
The controls bar also lets us create new Rules inside the current Folder or import existing Rules into it.
{% endhint %}

### Folders tree controls

#### At the top of the Folders manager you can find four controls icons.

1. The ![](<../.gitbook/assets/image (102) (1).png>)/![](<../.gitbook/assets/image (138).png>) Icon Expands/Collapses the Folder structure i.e. Opens/Closes all Folders.
2. The ![](<../.gitbook/assets/image (123).png>) Icon creates a new Folder.
3. The ![](<../.gitbook/assets/image (211).png>) Icon refreshes the Folder tree incase you want to be sure everything is up to date.
4. The ![](<../.gitbook/assets/Screenshot 2023-07-19 at 15.28.16.png>) Icon allows you to filter by rule state (published/unpublished)
5. And finally the ![](<../.gitbook/assets/image (257).png>) Icon closes the Folder manager.

#### Right-clicking the items

Right-clicking on Rules and Folders in the Folder manager brings up different context menus.

The context menu for a Rule: ![](<../.gitbook/assets/image (255).png>)

The context menu for a File:  ![](<../.gitbook/assets/image (247).png>)

{% hint style="info" %}
The ![](<../.gitbook/assets/image (147).png>) Folder works the same as all other Folders except you can't Rename it, Clone it nor Delete it.
{% endhint %}

#### The Search functionality

Underneath the Folders header is a Search input field. Entering characters then filters your rules to show only the ones containing your input.

![](<../.gitbook/assets/image (143).png>) -> ![](<../.gitbook/assets/image (249).png>)

### Export Folder

Clicking on the "**Export folder**" option in the context menu allows you to initiate the process of exporting the selected folder and its contents to **JSON** format.

<figure><img src="../.gitbook/assets/Screenshot from 2023-08-02 13-55-16.png" alt=""><figcaption><p>Folder context menu</p></figcaption></figure>

<details>

<summary>Export example</summary>

```
{
    "export": {
        "exportType": "FOLDER",
        "version": 1,
        "createdAt": "2023-08-02T10:13:03.825Z",
        "data": {
            "structure": {
                "id": "f600f63a-2281-669a-9aa6-1aa3110ccc26",
                "name": "Test Import",
                "type": "FOLDER",
                "children": [
                    {
                        "baseId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                        "type": "RULE",
                        "version": 1
                    },
                    {
                        "baseId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                        "type": "RULE",
                        "version": 1
                    }
                ]
            },
            "rules": [
                {
                    "name": "Scripting rule 2",
                    "description": "Sample scripting rule",
                    "inputSchema": {
                        "value1": {},
                        "value2": {}
                    },
                    "outputSchema": {
                        "result": {}
                    },
                    "script": "/* \n    1.  Input variables\n    Input body is set in input variable \n*/\nlet a = input.value1;\nlet b = input.value2;\n\n/*\n    2.  Define simple \"multiply\" function\n*/\nfunction multiply(a, b) {\n    return a * b;\n}\n\n/*\n    3.  Execute multiply function and store value result variable\n*/\nlet resultMultiply = multiply(a, b);\n\n/*\n    4.  Set output model which is returned in REST API\n*/\noutput.result = resultMultiply;\n\n/*\n    Optionally: It is possible print values to console\n*/\nlog('Result multiply:', resultMultiply);\n\n/*\n    5.  Return output  \n*/\nreturn output;",
                    "type": "complex-rule",
                    "status": "published",
                    "auditLog": {
                        "active": false,
                        "debug": {
                            "active": false
                        },
                        "ttl": 14
                    },
                    "ruleId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                    "baseId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                    "version": 1,
                    "ruleAlias": "specific-roadrunner",
                    "createdIn": "2023-08-02T08:12:56.738Z",
                    "lastUpdate": "2023-08-02T08:12:56.738Z",
                    "tags": []
                },
                {
                    "name": "Scripting rule 1",
                    "description": "Sample scripting rule",
                    "inputSchema": {
                        "value1": {},
                        "value2": {}
                    },
                    "outputSchema": {
                        "result": {}
                    },
                    "script": "/* \n    1.  Input variables\n    Input body is set in input variable \n*/\nlet a = input.value1;\nlet b = input.value2;\n\n/*\n    2.  Define simple \"multiply\" function\n*/\nfunction multiply(a, b) {\n    return a * b;\n}\n\n/*\n    3.  Execute multiply function and store value result variable\n*/\nlet resultMultiply = multiply(a, b);\n\n/*\n    4.  Set output model which is returned in REST API\n*/\noutput.result = resultMultiply;\n\n/*\n    Optionally: It is possible print values to console\n*/\nlog('Result multiply:', resultMultiply);\n\n/*\n    5.  Return output  \n*/\nreturn output;",
                    "type": "complex-rule",
                    "status": "published",
                    "auditLog": {
                        "active": false,
                        "debug": {
                            "active": false
                        },
                        "ttl": 14
                    },
                    "ruleId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                    "baseId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                    "version": 1,
                    "ruleAlias": "interested-mackerel",
                    "createdIn": "2023-08-02T08:12:42.965Z",
                    "lastUpdate": "2023-08-02T08:12:42.965Z",
                    "tags": []
                }
            ]
        }
    }
}
```

</details>

#### Warning dialog

Folder to export contains rules that have connections or dependencies with other rules located outside of the export folder. Such dependencies might be crucial for the proper functioning of the rules, and exporting the folder without considering these dependencies could lead to errors or issues.

<figure><img src="../.gitbook/assets/Screenshot from 2023-08-02 14-10-58.png" alt=""><figcaption><p>Export Warning dialog</p></figcaption></figure>

#### Possible errors

* **Rule not in folder -** exported rule has a dependency outside of the exported folder &#x20;
* **Rule not found -** rule with the identifier (id, alias) was not found
* **Duplicity id / alias -** more rules with the same identifier (id, alias) &#x20;

{% hint style="warning" %}
Rule dependencies won't be found when rules point to each other dynamically (e.g., using for loop).
{% endhint %}

### Import Folder

Clicking on the "**Import**" option in the context menu allows you to initiate the process of importing folder into the selected folder. The expected format of the file to import is **JSON.**

<figure><img src="../.gitbook/assets/Screenshot from 2023-08-02 14-16-19.png" alt=""><figcaption><p>Folder context menu</p></figcaption></figure>

{% hint style="warning" %}
When importing a folder, it may take a bit longer to process. The duration of the import process can vary depending on the number of rules and subfolders in the folder.
{% endhint %}

<details>

<summary>Import Example</summary>

```
{
    "export": {
        "exportType": "FOLDER",
        "version": 1,
        "createdAt": "2023-08-02T10:13:03.825Z",
        "data": {
            "structure": {
                "id": "f600f63a-2281-669a-9aa6-1aa3110ccc26",
                "name": "Test Import",
                "type": "FOLDER",
                "children": [
                    {
                        "baseId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                        "type": "RULE",
                        "version": 1
                    },
                    {
                        "baseId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                        "type": "RULE",
                        "version": 1
                    }
                ]
            },
            "rules": [
                {
                    "name": "Scripting rule 2",
                    "description": "Sample scripting rule",
                    "inputSchema": {
                        "value1": {},
                        "value2": {}
                    },
                    "outputSchema": {
                        "result": {}
                    },
                    "script": "/* \n    1.  Input variables\n    Input body is set in input variable \n*/\nlet a = input.value1;\nlet b = input.value2;\n\n/*\n    2.  Define simple \"multiply\" function\n*/\nfunction multiply(a, b) {\n    return a * b;\n}\n\n/*\n    3.  Execute multiply function and store value result variable\n*/\nlet resultMultiply = multiply(a, b);\n\n/*\n    4.  Set output model which is returned in REST API\n*/\noutput.result = resultMultiply;\n\n/*\n    Optionally: It is possible print values to console\n*/\nlog('Result multiply:', resultMultiply);\n\n/*\n    5.  Return output  \n*/\nreturn output;",
                    "type": "complex-rule",
                    "status": "published",
                    "auditLog": {
                        "active": false,
                        "debug": {
                            "active": false
                        },
                        "ttl": 14
                    },
                    "ruleId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                    "baseId": "595e7659-641d-8200-ba42-40b683ca1c5c",
                    "version": 1,
                    "ruleAlias": "specific-roadrunner",
                    "createdIn": "2023-08-02T08:12:56.738Z",
                    "lastUpdate": "2023-08-02T08:12:56.738Z",
                    "tags": []
                },
                {
                    "name": "Scripting rule 1",
                    "description": "Sample scripting rule",
                    "inputSchema": {
                        "value1": {},
                        "value2": {}
                    },
                    "outputSchema": {
                        "result": {}
                    },
                    "script": "/* \n    1.  Input variables\n    Input body is set in input variable \n*/\nlet a = input.value1;\nlet b = input.value2;\n\n/*\n    2.  Define simple \"multiply\" function\n*/\nfunction multiply(a, b) {\n    return a * b;\n}\n\n/*\n    3.  Execute multiply function and store value result variable\n*/\nlet resultMultiply = multiply(a, b);\n\n/*\n    4.  Set output model which is returned in REST API\n*/\noutput.result = resultMultiply;\n\n/*\n    Optionally: It is possible print values to console\n*/\nlog('Result multiply:', resultMultiply);\n\n/*\n    5.  Return output  \n*/\nreturn output;",
                    "type": "complex-rule",
                    "status": "published",
                    "auditLog": {
                        "active": false,
                        "debug": {
                            "active": false
                        },
                        "ttl": 14
                    },
                    "ruleId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                    "baseId": "6fb875d8-5e1a-4139-7d47-c22fea912c0b",
                    "version": 1,
                    "ruleAlias": "interested-mackerel",
                    "createdIn": "2023-08-02T08:12:42.965Z",
                    "lastUpdate": "2023-08-02T08:12:42.965Z",
                    "tags": []
                }
            ]
        }
    }
}
```

</details>

{% hint style="info" %}
The imported rules and folders will be assigned with new unique IDs. However, the dependencies between the rules will remain the same.
{% endhint %}
