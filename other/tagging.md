---
description: '*Applies to all Rule types - Decision Rules, Scripting Rules and Rule Flows.'
---

# Tagging

Tags provide a simple way to keep track of your rules and filter them in search results.

Every rule can be labeled by an arbitrary set of tags. These come in several colors to enable simple visual identification of distinct rules (as well as their versions). Tags contain arbitrary text of your choice. The management and usage of tags, although intuitive, is described in detail below.

## Manage tags

Tags can be managed either separately for each version of a given rule, or for all rule versions at once. Let us describe these two cases separately.

### On Rule versions

The tags belonging to a certain rule version can be managed either in the rule list or inside the rule settings of the respective version. The operations performed in these two places have the exact same effect.

![Tags in rule list](<../.gitbook/assets/tag\_example\_1 (1).jpg>) ![Tags in rule detail](../.gitbook/assets/tag\_example\_13.jpg)

The management of tags belonging to individual rule versions involves the following operations.

#### Adding a tag

Click on the +Add tag button and start typing. You may either find an existing tag to add or create a completely new tone. Press Enter to enter the tag text. When creating a new tag, you may then select its color by clicking on one of the available tag colors. Confirm by clicking on the ![](../.gitbook/assets/tag\_add\_button.jpg) button. Your tag should be now added to the rule version.

#### Removing a tag

Click on the tag you wish to remove and select the "Remove from this version" option. Your tag should be now removed from the rule version.

#### Changing tag color

Tag color can only be changed globally for all tags in your space that have the same text. To do that, click on the tag whose color you wish to change (anywhere in the respective space) and choose the new color under the "Change color globally" option.

{% hint style="info" %}
Note that tags exist on the level of the space, i.e., different kinds of rules may be labeled by the same tags. For example, if you create a tag for a Decision Rule, you may as well use it to label your Rule flows.
{% endhint %}

It is suggested that you choose the text of your tags carefully, as it cannot be globally changed later. If you need to change the text of a tag used to label a certain set of rules, you need to remove it from each of the rules separately and then add new tags that replace the removed one.

### On Rules themselves

Aside from the tags labeling the individual rule versions, there is also a tag list visible in every rule header within the rule list.

![Tags on a rule. You can see the overall tag list in the top right part of the image.](<../.gitbook/assets/tag\_example\_2 - Copy (1).jpg>)

This overall tag list contains the set of all tags used in any of the versions of the respective rule. It allows you to perform the same tag operations as the one described above (Adding a tag, Removing a tag, Changing tag color), only with different effect of the first two:

* Adding a tag will result in adding the tag to all versions of the respective rule.
* Removing a tag will result in removing the tag from all versions of the respective rule.

The effect of changing tag color in the rule header remains the same.

## Use tags to search

Aside from allowing for a clear visual differentiation and classification of your rules and rule versions, tags may be also used to filter search results.

![Search with the use of tags](../.gitbook/assets/search1.jpg)

When you start typing in the search bar, the existing tags are suggested to you in a dropdown menu. Upon selecting some tag from the menu, it is placed into the search bar and used to filter your search results. A rule enters the search results only if at least one of its versions contains the specified tags. The versions themselves are not filtered (you can see all of them in search results).

The functionality of searching by text is of course preserved. You may enter search text simply by typing the desired phrase and pressing Enter without selecting any tags.