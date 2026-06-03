# Permissions

## Space Permissions <a href="#the-decisionrules-permissions" id="the-decisionrules-permissions"></a>

DecisionRules offers a granular set of permissions that can be used to define very specific roles for individual users in a space. As some permissions have mutual points of contact or overlaps, their use outside of the predefined default roles may become complex if you do not know how they interact. In this section, we will provide basic principles giving clarity to mutual permission interaction.

### Rule Permissions: Logic and Guardrails <a href="#rule-type-permissions-logic-and-guardrails" id="rule-type-permissions-logic-and-guardrails"></a>

#### Core Principle <a href="#core-principle" id="core-principle"></a>

**Affects in the UI:** Rule details, designers, save buttons, settings, action menus, history actions, and folder actions.

**Principles:** Each rule type has a minimum permission set for viewing, saving, editing metadata, editing designer content, importing/exporting, and rule management. Generic rule permissions apply to most rule types, but some rule families have their own permission layer. Rule Flow uses Rule Flow permissions. Decision Flow and Integration Flow use workflow permissions. Lookup Table and AI Agent Rule require their own edit permissions for meaningful changes.

Locked rules and plan limits can still block actions even when permissions are otherwise present.

#### Viewing Rules <a href="#viewing-rules" id="viewing-rules"></a>

**Affects in the UI:** Whether a rule can appear/open in rule detail and folder structure.

**Principles:** Viewing a rule requires both the broad read permission for its rule family and the type-specific view permission, except Rule Flow, which uses its own read permission.

| Rule type                        | Required view permissions       |
| -------------------------------- | ------------------------------- |
| Decision Table                   | Read Rule + View Decision Table |
| Decision Tree                    | Read Rule + View Decision Tree  |
| Scripting Rule                   | Read Rule + View Scripting Rule |
| Lookup Table                     | Read Rule + View Lookup Table   |
| AI Agent Rule                    | Read Rule + View AI Agent Rule  |
| Decision Flow / Integration Flow | Read Rule + View Workflow       |
| Rule Flow                        | Read Rule Flow                  |

Folders themselves may be visible, but rule nodes inside them are governed by the rule’s own view permissions.

#### Save Button <a href="#save-button" id="save-button"></a>

**Affects in the UI:** Whether the Save button can become available for the current rule.

**Principles:** Save means “the user may persist at least one allowed kind of change.” It does not always mean the user can edit every part of the rule.

| Rule type                        | Save requires                                                 |
| -------------------------------- | ------------------------------------------------------------- |
| Decision Table                   | Update Rule                                                   |
| Decision Tree                    | Update Rule                                                   |
| Scripting Rule                   | Update Rule                                                   |
| Lookup Table                     | Update Rule + Edit Lookup Table                               |
| AI Agent Rule                    | Update Rule + Edit AI Agent Rule                              |
| Decision Flow / Integration Flow | Update Rule + either Update Workflow or Write Workflow Values |
| Rule Flow                        | Update Rule Flow                                              |

For flows, this is intentionally split: a user may save value/mapping changes with Write Workflow Values without being allowed to update workflow structure or settings.

#### Rule Settings and Tags <a href="#rule-settings-and-tags" id="rule-settings-and-tags"></a>

**Affects in the UI:** Status, alias/name, description, audit settings, input/output settings, and tag editing.

**Principles:** Rule settings are stricter than the Save button for some rule types. A user must first be allowed to edit the rule type in a general metadata sense, and then must have the relevant setting-level permission.

| Rule type                        | Generic settings/tag edit requires |
| -------------------------------- | ---------------------------------- |
| Decision Table                   | Update Rule                        |
| Decision Tree                    | Update Rule                        |
| Scripting Rule                   | Update Rule                        |
| Lookup Table                     | Update Rule + Edit Lookup Table    |
| AI Agent Rule                    | Update Rule + Edit AI Agent Rule   |
| Decision Flow / Integration Flow | Update Rule + Update Workflow      |
| Rule Flow                        | Update Rule Flow                   |

After that, individual settings still require their matching setting permission: change state/status, change alias/name, edit description, change audit settings, or edit input/output. Rule Flow uses the Rule Flow versions of those setting permissions.

Write Workflow Values alone is not enough to edit flow settings or tags.

#### Designer Changes <a href="#designer-changes" id="designer-changes"></a>

**Affects in the UI:** Editing cells, nodes, columns, rows, scripts, lookup data, workflow nodes, mappings, and other designer-specific content.

**Principles:** Designer actions are operation-specific. The Save button may be available, but individual controls can still be hidden or disabled when the matching edit permission is missing.

| Rule type                        | Designer edit principle                                                                                                                                                                                                     |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Decision Table                   | Update Rule is the base requirement, then granular table actions require their matching permissions, such as Edit Cell, Add/Delete Row, Add/Delete Column, Change Column Definition, Set Valid Values, Set Filter, or Sort. |
| Decision Tree                    | Update Rule is the base requirement, then tree actions require matching permissions, such as edit/add/move/clone/delete node or edit/move/delete condition.                                                                 |
| Scripting Rule                   | Script editing follows Update Rule.                                                                                                                                                                                         |
| Lookup Table                     | Lookup table editing requires Update Rule + Edit Lookup Table.                                                                                                                                                              |
| AI Agent Rule                    | AI Agent Rule configuration editing requires Update Rule + Edit AI Agent Rule .                                                                                                                                             |
| Decision Flow / Integration Flow | Structural workflow changes require Update Rule + Update Workflow. Value/mapping edits can be allowed with Update Rule + Write Workflow Values.                                                                             |
| Rule Flow                        | Rule Flow editing requires Update Rule Flow, with more specific Rule Flow permissions controlling mappings, global variables, start/end/rule nodes, and rule changes.                                                       |

#### READ ONLY and LIMITED Badges <a href="#read-only-and-limited-badges" id="read-only-and-limited-badges"></a>

**Affects in the UI:** The rule top panel badges that explain the user’s effective edit access.

**Principles:** READ ONLY means the user does not have the minimum permission needed for Save on that rule type. LIMITED means the user can save at least some allowed changes, but does not have the full set of common and type-specific edit permissions for that rule type.

Examples:

* A Decision Flow user with Write Workflow Values but without Update Workflow is not read-only, because value edits can be saved, but the user is limited.
* A Lookup Table user without Edit Lookup Table is read-only, even if they have generic rule update permissions.
* A Decision Table user with Update Rule but missing some granular table permissions can save, but may be limited for specific table operations.

#### Import and Version Overwrite <a href="#import-and-version-overwrite" id="import-and-version-overwrite"></a>

**Affects in the UI:** Import Version, Import as New Version, Overwrite Current Version, and version overwrite actions.

**Principles:** Import permission controls whether importing is available. Rule Flow uses Rule Flow import permission. Other rule types use the generic rule import permission.

| Rule type            | Import requires  |
| -------------------- | ---------------- |
| Rule Flow            | Import Rule Flow |
| All other rule types | Import Rule      |

Overwriting an existing version is stricter than importing a new version. It requires import permission plus full edit authority for that rule type. Full edit authority means the user can save the type and has all common and type-specific edit permissions for it.

Locked rules hide or block overwrite-style actions.

#### Restore Version <a href="#restore-version" id="restore-version"></a>

**Affects in the UI:** Restore Version in rule history.

**Principles:** Restoring a historical version is treated as a rule overwrite. It requires full edit authority for the rule type and the rule must not be locked.

This is stricter than simple viewing history and stricter than Save, because restoring a version can replace the whole rule state.

#### Export <a href="#export" id="export"></a>

**Affects in the UI:** Export actions on rules and folder exports.

**Principles:** Export permission is type-family based. Rule Flow uses Rule Flow export permission. Other rule types use generic rule export permission.

| Rule type            | Export requires  |
| -------------------- | ---------------- |
| Rule Flow            | Export Rule Flow |
| All other rule types | Export Rule      |

Folder export is recursive: every contained rule must be readable and exportable. Modify Folders is not what grants export authority.

#### Create, Clone, and Delete <a href="#create-clone-and-delete" id="create-clone-and-delete"></a>

**Affects in the UI:** New rule actions, clone actions, delete actions, and folder tree bulk actions.

**Principles:** Rule Flow uses Rule Flow management permissions. Other rule types use generic rule management permissions.

| Action | Rule Flow requires | Other rule types require |
| ------ | ------------------ | ------------------------ |
| Create | Create Rule Flow   | Create Rule              |
| Clone  | Create Rule Flow   | Create Rule              |
| Delete | Delete Rule Flow   | Delete Rule              |

Delete is also blocked for locked rules.

For bulk or folder-level clone/delete, every selected or contained rule must individually satisfy the required rule-type permission. One unauthorized child blocks the folder-level action.

#### Modify Folders <a href="#modify-folders" id="modify-folders"></a>

**Affects in the UI:** Creating folders, renaming folders, moving items in the folder tree, drag/drop, cloning folders, and deleting folders.

**Principles:** Modify Folders controls folder structure, not rule content authority.

Modify Folders allows folder operations only when the folder action itself is permitted. It does not replace rule permissions. For example:

* Cloning a folder requires Modify Folders and clone permission for every contained rule.
* Deleting a folder requires Modify Folders and delete permission for every contained rule.
* Moving folder tree items requires Modify Folders and unlocked items.
* Exporting a folder depends on read/export permissions for contained rules, not Modify Folders.

In short: Modify Folders controls the container; rule-type permissions control the rules inside it.
