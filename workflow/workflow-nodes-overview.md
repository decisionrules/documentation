---
description: >-
  This page lists all the node types currently available in the workflow, along
  with a brief description of their functionality.
---

# Workflow Nodes Overview

{% hint style="info" %}
Release 1.19.0 is currently under preparation. Consider the info on this page preliminary.
{% endhint %}

For better navigation, the nodes are divided into logical sections and listed in the same order as they appear in the Workflow palette. You can also find a description of each node by clicking on the node in the palette or by clicking the ![How-To ](../.gitbook/assets/hint.png) (How-To) icon in the node modal.

## Basic

### &#x20;<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAdtJREFUeF7tmU1OwzAQhccN7BEhVXoBOAAVa9YIjtF2xY5jsGJF4RhwC8QFuEADTquKJWpqxC4RoZ5mkibYr8tmPPZ8fm+cH0We/5Tn9RMAQAGeE4AFPBcAmiAsAAt4TgAW8FwAOAVgAVjAcwKwgOcC4J0CiV5cGrO++U+wlOrdxtHhs23NLAu868XEGHNvS9ap64omcRQ+2NYEADZCP9ehAFigpAcwPcZRmDQm+UividRdIQ9zfdV7AHMCaXGc8Y0DSPR8TIamVQhzCpDGzNL0jDJ1kc+z1wueoujg1ZbbCQXYitx0HQA49EqPwQ71AE4Nf8VAARx6iZ6PyFDxtlLROI7CR874pmPKnlWafxbokAUkFnXCAgBQdqvOVCgUwGlQEolx8ktjJOuDAjj0JYQ5+aUxkvVBARz6u3wjFPfDwqZovRxmJnvhrHPbmEAFw+oK2HY2ZjwAQAEdtMAuP4wM+kfnebdo/XmyMl/Ft1G/7TRQpI7zfxsyb0Q02+S8gPZHrB7AtG9rYY0fg61VxpwYAJp+GGJuRGthUAAUUP3LFU6B1oxb48Te9wCtl6erdXaVZ1rrp7EaN6tzqZzoARKqACCh58JYKMCFXZTUAAVI6LkwFgpwYRclNXwDDUKOHrqLH2MAAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M540-288H144v-384h672v108h-72.33v-36H216v240h324v72Zm-324-72v-240 240Zm528 204v-132H612v-72h132v-132h72v132h132v72H816v132h-72Z&#x22;/></svg>" data-size="line">  Assign&#x20;

The **Assign** node is essential in workflows for managing data transformations and storage. It allows users to assign fixed values or the results of expressions to outputs or variables, streamlining data flow and facilitating dynamic decision-making within workflows.

#### Key Features

* **Assign Fixed Values:** Directly set specific values to variables or output fields.
* **Map Data Between Variables:** Transfer or transform data from one variable to another using simple assignments or complex mappings.
* **Expression Evaluation:** Evaluate expressions and assign the result to variables, enabling dynamic and conditional data handling.

#### Use Cases

* **Data Initialization:** Initialize variables with specific values at the start of a workflow to ensure they are ready for use.
* **Dynamic Calculations:** Use expressions to perform calculations and assign the result to a variable for later use in the workflow.
* **Data Synchronization:** Map data from inputs to internal workflow variables to maintain consistency and integrity across different workflow stages.

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAA15JREFUeF7tmE1PE1EUhs+ZKS0KraXtTAsudGGCCdEFZaEJSpCEuOI3uFBw7crf4MK1ZeXauHKhSzUaJIEq0Rg1YYELpWU6tpSvUqdzzBBqSjv9mHboR+bMdu49c85z3/fcewfB4Q86vH5gAKwAhxNgCzhcANwE2QJsAYcTYAtYFYCiKF4NXFGr84rjXYA7kuSPm81XlExUA/I2G1sk/6os466V+ZYVoCiZiQIVVqx8pHQsAcWH5dCE2fzNrVQcAcebjS2iOFENbrWYDMAqbVYAW6B+D0CApzrBTzN1oQC/I1Jw0exdQlHnSYcRs3cCwgUCuFNLsSKKUUnyf7Si6tPpAQQbLpEmQ6HQLyvJVBubSqXOawV8DwgX6wDooiZoE4RkcjdMcLhcr3gDTPftAi1CyGazof1c/gMAXmpESe0CEC1QYbUsoWdAMAYIYxWJEmwI6Lkuy4OJRooojjGK38vl3yHgZZOYXxFhpbwntKsHVAIgiHncwsPDvG74tBIC0DpS/2Q4PJhsBEImkxk6yGtLpsUDrHn6hOnDvP4IEO6VxuucAghikXDwfjqd9rcKwSg+d1h4CwhXTGCtiajflCRpJ5FUFzsFoPIoTLAYCQcXjIRbgaCqqu+vBoaKKoonoBUX0oxRvPGdbgNwpIDiim1vbwcOctob80LgG5xxTw17vUr5Cm9tqbd1gFcmnl8WBX22WPwxgBggzJeOFUAYl+WhT43YrDjGnnNAiQKKgWspgYC+D/S7b/h8vlR5sgklPQekPweAvqN3BEtAgdlIBPdKx3abAv5boDTJpiGkMreooL1EwHhYDswgYq4CVOd6QHZUo3zshPQQX4Sl4GMz6R3b4TUgXDXbzuise9rMDglVvaYHAp9HEPfN4iYV9YFONHdiF4C+u7J8bv1ULWAleCN2AIIv/R5xyu/3p5uJ3eocyz2g2Q/W3B06CKFtAOpukQgL1W6JzUJvZF5bAdSE4BQABoSk8meBiJ6cWCEG4BALsALYAtwDuAnyLsDbIJ8D+CDEJ0E+CvNdgC9DfBssJcDXYb4OO+OXmKF6Rdkb1iA/WuoAF7h/SNLAZiP/8ewc0/Z/gnYmb0csBmAHxV6OwQro5dWzI3dWgB0UezkGK6CXV8+O3FkBdlDs5RiOV8A//TVUX64702sAAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M444-192v-273.24L264-645v117h-72v-240h240v72H315l201 201v303h-72Zm138-339-51-51 114-114H528v-72h240v240h-72v-117L582-531Z&#x22;/></svg>" data-size="line">  Switch

The **Switch** node is designed to direct the workflow based on conditional logic, allowing for branching based on case evaluations. This node evaluates a series of cases, each defined by a specific set of conditions, and branches the workflow accordingly.

#### Functionality

* **Case Evaluation:** Each case within the node has a set of conditions. The workflow branches off when these conditions are met.
* **Default Case:** If no conditions are met for any case, the workflow defaults to a predefined path, ensuring that the workflow continues smoothly.
* **Visibility of Case Fulfillment:** It is possible to track whether each case's conditions have been met, providing clarity and transparency in workflow execution.

#### Evaluation Strategies

* **All Winning Cases:** This strategy evaluates all cases that meet their conditions. If no cases are deemed profitable, the default case is executed.
* **First Winning Case:** This strategy identifies and executes the first case that meets its conditions. If no cases qualify, the default case is executed.

#### Use Cases

* **Complex Decision Making:** Ideal for scenarios requiring multiple conditions to determine the workflow path.
* **Error Handling:** Can be used to manage different error conditions and direct to appropriate recovery paths.
* **User Input Handling:** Direct workflow based on various user inputs or actions within a system.

This node is crucial for implementing complex decision-making capabilities within workflows, allowing for dynamic and condition-based workflow branching.

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAuBJREFUeF7tWz+L1FAQn8kqeNi4m79rITZWgnDHYnHgNxAEO7GxUE/80yj4JQQbFdyzshFs9QuchVgcpxY2goWNZJNNgtUhSnYkyElYsrs3b/P2ZdlJl7zfezPze/NmJi8vCCt+4YrbD0KAeMCKMyBLYBEOEEXJ5RHguTplIdJvQOv7ERy9cxznh+rY2j0gGmZbRPRcVcFZ/YhoHxAedj3n2SxsVbtWAgbD9DoQvFBRjN0HrUuB237D7aeNgDDKbiOS0qxwjfiHp2+B55zh9tVCwEJnvmTxyO0cP4m4zyGhdgLCOLmLgE+qlCCge4CtLxwFJ2GR8gcAeLHcboG17nntz5zxayVgyswTAFwJPPs1R7lp2EGUbgPCjTKmha2e657Y48iojYAwTu4g4NMK4bUbX8hoFAGLNr5RBJgwvjEEmDK+EQSYNN44AaaNN0pAmKZnMYfqXI54NXA7r8qZIIyTnfI9En4NfHvr4Jlq+yBK+4Bwc6wO2PC89ietaXA4/NnLKd8dEzIx1Q3itGj7fxHQXtdzegcPVNuNpcEqAgjgZdezr1Uxr2rgLIKa5QEE22W3LhOhkQAzlWDlEhACxANkCUgMKOX2VQyC/cC3b1WlQdVCZ1ahtDRpkFOVcbCNKoRgShrkGMXBCgGmtsS4hRBnVjlY8QDxAEO7wrIEqvYDJAtMfhniBDYOVoKgBEEJgsuxI8RZ1xysxACJARIDJAYYOSAhpbCUwhXfBuVdQN4FJn4Y4RQ3HKwUQgYLoY2c8rGzePSWsPWYM4PzYo0dlCSitWiYsY6jzmvsYfv7bmcNEX8dFl/glA5KhnHyEQHXOYJ0Ywlot+s557lylAiIonSTEN5zhenEYws2fdv+wJWhREAhpDgUDQSPEPEYV2id+OKHCcuy7vtup68yrjIBhbAsy079yeEC0eg0ER5VUUC1z9L8MqNq4KL6zeUBi1JSpxwhQCe7yzC2eMAyzJJOHf8CLgpXbktKuBAAAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M360-528h72v-144h-72v144Zm120 0h72v-144h-72v144Zm120 0h72v-144h-72v144ZM263.72-96Q234-96 213-117.15T192-168v-504l192-192h312q29.7 0 50.85 21.15Q768-821.7 768-792v624q0 29.7-21.16 50.85Q725.68-96 695.96-96H263.72Zm.28-72h432v-624H414L264-642v474Zm0 0h432-432Z&#x22;/></svg>" data-size="line">  Declare

The **Declare** node plays a critical role in managing data within workflows. It allows for the creation of runtime variables that can be modified during the execution of a workflow. All variables established by this node are accessible in the data dictionary, providing a centralized view of workflow data.

#### Key Features

* **Runtime Variable Creation:** Enables the dynamic creation of variables that can be adjusted as the workflow progresses.
* **Data Dictionary Integration:** All variables are listed in a data dictionary, making them easily accessible and manageable throughout the workflow.
* **Encapsulation:** Variables are grouped under the name of the node, which helps in organizing and isolating data within complex workflows.
* **Flexible Variable Definition:** Supports defining both entities (complex data structures) and inline variables (simple data types), providing versatility in data handling.

#### Use Cases

* **Data Handling:** Ideal for scenarios where data needs to be initialized and potentially modified based on workflow conditions or user inputs.
* **State Management:** Useful in long-running workflows where state needs to be tracked and manipulated across different stages of the workflow.

This node is essential for workflows that require a high degree of data flexibility and accessibility, ensuring efficient management and manipulation of variables during runtime.

### ![](../.gitbook/assets/dictionary\_16dp\_E8EAED\_FILL0\_wght400\_GRAD0\_opsz20.svg)  Global Variables

The **Global Variables** node is essential for establishing a set of global variables accessible throughout the entire workflow. This node is typically configured at the start of the workflow to ensure that all variables are defined and available for use from the beginning.

#### Key Features

* **Global Scope:** Variables defined in this node are available throughout the entire duration of the workflow, across all nodes.
* **Initial Configuration:** Placed right at the start of the workflow, this node sets up essential variables that are critical for the entire process.
* **Easy Access:** All global variables are readily accessible and modifiable by any part of the workflow, enhancing data sharing and manipulation.

#### Benefits

* **Consistency:** Ensures that all parts of the workflow have consistent access to the same set of variables.
* **Simplicity:** Simplifies the management of data that needs to be shared across multiple parts of the workflow.
* **Efficiency:** Reduces the need to repeatedly define the same variables in different nodes, thus optimizing workflow performance.

#### Use Cases

* **Configuration Data:** Ideal for storing configuration settings that need to be accessed by multiple nodes throughout the workflow.
* **Shared Resources:** Useful for scenarios where data needs to be shared or visible across various stages of the workflow, such as user permissions, environmental settings, or operational parameters.

This node provides foundational support for workflows that require global data accessibility, ensuring that critical information is uniformly available across all stages of the process.

### ![](../.gitbook/assets/laps\_16dp\_E8EAED\_FILL0\_wght400\_GRAD0\_opsz20.svg)  Foreach

The **Foreach** node is used for iterating over arrays within a workflow, making it essential for processing collections of data. This node utilizes a "Loop Connector" to iterate through each item in the input array, providing powerful functionality for data manipulation and analysis.

#### Key Features

* **Loop Connector** iterates over every item in the specified input array, ensuring that each element is processed sequentially.
* Access to **Current Item**: during each iteration, the current item is accessible via the `[foreach node name].currentItem` attribute, allowing for direct manipulation of each array element as an object.

Iteration Context provides additional iteration parameters such as:

* `index`: Indicates the number of the current iteration.
* `length`: Indicates the total length of the input array.

#### Advanced Usage — Nested Loops

* For nested arrays, multiple Foreach nodes can be nested within each other. This allows for the handling of complex data structures and multi-dimensional arrays with ease.

#### Use Cases

* **Data Processing**: Ideal for scenarios requiring detailed processing or transformation of each item within an array.
* **Batch Operations**: Efficient for performing operations on batches of data, such as calculations, filtering, or aggregation.
* **Complex Data Structures**: Useful in workflows that need to navigate and manipulate nested or hierarchical data structures.

This node is crucial for workflows that involve array processing, providing robust tools for iterating over data and applying specific operations to each element effectively.

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAw5JREFUeF7tmjuLE1EUx/9nzHa7ojuZyUPEUmzNggoWYiEoC4K1xeKS3Q/gl3F9sAi2NiI2lsIWSiorO0EwmVcICBaavUciCEkMmTNzZzLJ5Ka9557H7/7vvWcmQ1jzH615/TAAjALWnIDZAmsuAHMImi2QdAuEYXjlt6LrFuGiUrCSzs/D3rKgFONbhTZOHOfslyQxEinAC/sPWfExgEqSIIuyZcYv6wzt16rbr6QxxQA8L3zARK+ljgu1I+t+3Tn/RpKDCIDv86ZC1AVoU+J0CWwGytm+0CT6GZeLEED/pgJ/iHO2TONs8bVGtfoxLicRgJ4fPQLwYtIZv2WmTlyARYwTcQug3fFYFnjPdasv4+KLAHhB/5CZn0w4IxzWHftpXIBFjOvkZwBIVkiHsMS/ro1OfkYBEvo6hCX+dW108jMKkNDXISzxr2ujk59IAb0gOgDjKO4aHNmxQlO3oHnzycL36etXmt8svyIAUsJdP+wQ6GqeABjcabjVnfEY0vwMgBkEjAIkcpVKrLRboBdEbTAm+37CQd2xn40DDIJBawjekkBNa1MB/XCccxMPYdL8cj8D0halO0+qUAMg70NQdyXTzjcK0HhfUfg1WHdtUQ7z1LE0CkhzDRoARgErsAWkjUbPi46Y+HKS07zhVm9NNlPB1hCVVhIfUGqXCI+nnlb/a9RWog8IgsHOKZ9+SgRgdmWit9aiE1jneTtpIVkBIMadWs1+HxdfBEDnmolLYHo8AwDMwH7DtUd/4sb+ygYgUfEjOmUCkLj4MgFIVXxZAKQuvgwAtIpfdQDaxa8ygEyKX1UAmRW/igAyLV4MoOuHewSa6qzy+USGgCYI7Zkt3Iw30bGtXoyBqBHKoD3VzTPzlf+XkAjAyLjrRV+JcEm3klTzCe26Yz9PNTcLBYx8+H7/rgK/yyOJOT5zW/nECvirAr9/j1gdg8hdAIjcixcfgtPF9sLBbajhDWbayAuEBXyu1ezcP80VnwF5FVq0XwOg6BUoOr5RQNErUHR8o4CiV6Do+EYBRa9A0fH/AFUN2V/N3TTYAAAAAElFTkSuQmCC" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M216-216h336v-192h192v-336H216v528Zm0 72q-29.7 0-50.85-21.15Q144-186.3 144-216v-528q0-29.7 21.15-50.85Q186.3-816 216-816h528q29.7 0 50.85 21.15Q816-773.7 816-744v360L576-144H216Zm72-264v-72h192v72H288Zm0-144v-72h384v72H288Zm-72 336v-528 528Z&#x22;/></svg>" data-size="line">  Sticky Note

The **Sticky Note** node is used to create notes within the workflow. This node serves as a simple yet effective way to add annotations, comments, or reminders directly in the workflow, enhancing clarity and communication among team members.&#x20;

#### Key Features

* **Annotation**: Add textual notes to any part of the workflow to explain the purpose of nodes, document decisions, or provide additional information.
* **Visibility**: Notes are visible within the workflow interface, making it easy for anyone reviewing the workflow to understand the context and reasoning behind specific nodes.
* **Non-Functional**: This node does not affect the workflow's execution; it is purely for documentation and informational purposes.

#### Use Cases

* **Documentation**: Use Sticky Notes to document the logic and reasoning behind complex workflow sections.
* **Collaboration**: Facilitate better communication among team members by adding notes that explain specific parts of the workflow.
* **Reminders**: Add reminders for future modifications or considerations that need to be addressed.

This node is essential for maintaining clear and comprehensive documentation within your workflow, ensuring that all stakeholders understand the workflow's structure and intent.

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAA3tJREFUeF7tmktrE1EUgM+5mdSFpTZNZpoo4sKFuLWCFrWiO0UR3IggUrQP3OgfcOd/EJ+UgogbN+JjqSB0oYgrhYqo4GLeIRtd9DFHRkxJbJN7JjOdzHRmtvc8v3PuucmdQcj4gxnPH3IAeQdknEC+BTLeAPkQzLdA0C3gOM7+ZQ8PC4TdngciqP5myAsBnkfwU8HigqoOLQbxEagDTKd+iTyaAwAliJO4ZIlgSRTw6mhl5BHXJxuAaTrnCfEp13Bf5VCcq6qlZ5wYWAAsiwY9cHUAHOQYTYBMw1NHdu1E/C2LhQmgftQDeiszlqR1EnSoVqm8k8XEAmBY7hUAeNhujJ4T4QeZgzjWEWkMAM+0+hJAk5pWmZf5ZwEw7fosEd1pM4YwW1XL92QO4lgPE18OgFOhMIQ59sPKhIkv7wAOfcN2p4Ggfb8jzFTV8n2OfpQyhuXeKGDxlaoOfWnate1ftRVY2tfqR4GBRVXdrst8p6oDDMu9BQA3gciEbcp4dXj4uyxB2XpqAOi2cxsJr60lFBEEFgDDdmeA4G6/jkHDrl8EosfrqklkFcTARNA/QK12WADCTFlZC3LXdcuZR8DLG0Aw/0FYmwlcm75cagD4wXaCQASOIopHWgcjF0KqAGwGhNQBiBpCKgFECSG1AKKCwAIQ9hi07cbYird6ljuYAsghIlwHgOH/dYjABQUmauXy5272WADCHoMb6gfIsldRzumwpQH44GQQMgEAFDjeaStsaQCy6rN/CaZ4CPqV/9T3IdjrEJPpRfHTOJYtIEukl/UokmdvgbDHYC8JdtOJKvlUAogy+dQB2Iw7gdTMgG7Jh7kfZAEIewyGnQGG5V4AgCcdrsSO9XIR0rTFApCEIdjXS9EkAPAr1rdrccN2p4Cg/SUIwnRVLT8I295B9f0XIwKUF5q242tTNzMvRjrBCtOhqZkB3TolBxDi+4W8AzhDSLecSQT0P49reTL0iYxtNw6u0up7DqykyAgQBzSt9FEWD2sL+EZ00/2BCHtkBhOxTvCtOlrey4mFDcCy6qc8oJcco/2WIRQnamrpDScONoC/XWDVTyN5c4CocYzHL0M6gZiqaSPsQgUC0EzIcBonwVsZJ8Ji/Emu94hIy4SFhZpaeh00np4ABHWSZPkcQJKrE0dseQfEQTnJPvIOSHJ14ogt74A4KCfZxx+xCaZfDkdZcgAAAABJRU5ErkJggg==" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M216-144q-29.7 0-50.85-21.15Q144-186.3 144-216v-528q0-29.7 21.15-50.85Q186.3-816 216-816h528q29.7 0 50.85 21.15Q816-773.7 816-744v72h-72v-72H216v528h528v-72h72v72.21Q816-186 794.85-165T744-144H216Zm456-144-51-51 105-105H384v-72h342L621-621l51-51 192 192-192 192Z&#x22;/></svg>" data-size="line">  End

The **End** simplifies output mapping at the end of a workflow branch. While not mandatory, as output mapping can also be performed with the Value Assignment node, the End Node offers additional features that enhance workflow clarity and functionality.

#### Key Features

* **Simplified Output Mapping:** Provides a straightforward way to define and manage output mappings at the end of a workflow branch.
* **Workflow Inspection:** Displays the data associated with the relevant workflow path in the inspector, offering a clear view of the output data and making it easier to debug and verify the workflow's final state.
* **Optional Use:** Though the End Node is not required (since output mapping can also be achieved with the Value Assignment node), it provides a dedicated endpoint for workflow branches, enhancing organization and readability.

This node is beneficial for workflows that require clear termination points and simplified output mapping, ensuring both ease of use and enhanced workflow clarity.

## DecisionRules

### <img src="../.gitbook/assets/dr_logo_new_solo.svg" alt="" data-size="line">  Business Rule

The **Business Rule** node allows you to connect and execute various types of business rules such as decision tables, decision trees, rule flows, or even entire workflows. This node is versatile and can operate in two distinct modes to accommodate different use cases.

#### Modes

* **Static Mode:** Select a specific business rule and, optionally, a particular version of that rule.
* **Dynamic Mode:** Select a business rule and its version based on workflow variables. If no version is explicitly selected, the latest published version of the rule is used.

#### Solving Strategies

You can choose from different solving strategies for evaluating business rules and determining the format in which the results are returned.

**Standard**&#x20;

* Always returns an array of results from the solved business rule.
* Automatically attaches a Loop connector to the node, allowing iteration over the results.
* During iteration, the current item is accessible via `[node name].currentItem`, and the iteration index is available via `index`.
* All returned data in the array is accessible through `[node name].output`.

**Evaluates All**

* Similar to the Standard strategy but specifically evaluates all rows in a decision table.
* Returns an array of results and allows for iteration as in the Standard strategy.

**First Match**

* Returns a single **output** object containing the result data.
* This strategy does not return an array but a single object representing the first matching result.

#### Use Cases

* **Decision Automation:** Ideal for scenarios where complex business logic needs to be automated through decision tables or trees.
* **Dynamic Rule Selection:** Useful when the specific business rule or its version needs to be selected based on runtime conditions.
* **Batch Processing:** Employ the Standard or Evaluates All strategies to handle multiple results from business rules, enabling batch processing and comprehensive evaluations.

This node is pivotal for integrating complex business logic into your workflows, ensuring that decisions are made based on the latest rules and data.

## Array Functions

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAzJJREFUeF7tmr9rFEEUx79v7/xZxIt3u3ebUkEELYSkUxPRVkEU/4AImkbMf2AaCwsLLQQVFGsRRLSy8Sd2AQstxCI2ye3turmACCK5fXJFIBfumLd5bm4vN9fOm+985/PezNzuDmHIfzTk84cFYCtgyAnYJTDkBWA3QbsE0i6BKFqZaKF1jICxJIGTtn8W8Y6DhBmLBSp8dt3SfJoxUlVAI4rnmDEH5HbpMMA3al7lphSCGEAQ/rwO0F2pcD/jGHzN9yr3JB5EAJrNZunP31adiHZLRPsew/y74LDvuu4vkxcRgHrUPEWcvDGJ5amdGMer1fInkycRgCCMLwN41CnGr5gp1YZjMrPZdiIeB+js+v4Mnva9yhOTpghAI1qeYeb7HWKEmZpbfmgaYCvaNf4sAEmGNIQl+toYjT9bARL6GsISfW2Mxp+tAAl9DWGJvjZG489WgIS+hrBEXxuj8SergEZ8kQnPtEa3sj8xX6hWK89NY4oA1OP4CLXwxSSWp/YC7TjsuiPfTJ5EANoi9TB+R8CkSTAP7Qx89L3ySYkXMYAgWDkAZ/U1QAclwn2LYSzwTue0Pzr6Q+JBDKAtxsx7GlFzFpwcBWGMkY9XYgQkYCyCnK81b/8tycTXYlIBSCM8KLEWwKBkKiuftgKyIjsourYC0mRqqI/BQfojhF2FM7VSaUGSXPESqIfxBwJOSET7HcPAe98rT0l8iAAM4sOQg+Ihz9v33QRBBiCMLxHw1CSWq3bHOV+rjL4weRIB0LxwMBnod7sFIMmArYCcfxuUJLFXjF0CEnpBFF8F40FHbI6+DkfRyvhq0jq33l/RKbyU3BfaFhWg2aMsAMkS0BCW6GtjNP5EFVAP42kCHnca3ZorMuRgaeNNlI1rvtsVGaDTX689QQQgippTLU7eajO1mf4Mnve9ysT6vl0zbhLvsWmLAPTzmlw3AF1PpSwBtLWDMJ4FcMc0zv9uz0UFrE0qiOIrYNwGMPK/J9pLL1cA2iaXmPcWo+XJBDzBTMWsQeRiE8x6klr9zI9BrcGs+1sAiqdV0TGYdQa1+pk/DGkN5rn/tqgADWALQENvO/Qd+gr4B/PgGF/vcb+fAAAAAElFTkSuQmCC" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M216-216v-144 16-4 132Zm-.3 72q-32.7 0-52.2-19.5T144-216v-144q0-33 19.5-52.5T216-432h528q33 0 52.5 19.5T816-360H216v144h396v72H215.7Zm.3-384q-33 0-52.5-19.5T144-600v-144q0-33 19.5-52.5T216-816h528q33 0 52.5 19.5T816-744v144q0 33-19.5 52.5T744-528H216Zm0-72h528v-144H216v144Zm0 0v-144 144ZM744-84v-60h-60v-72h60v-60h72v60h60v72h-60v60h-72Z&#x22;/></svg>" data-size="line">  Append

Array append involves adding elements to an existing array. Unlike merging, where elements are combined from two different arrays, appending adds new elements to the end of an array.

Let's say you have an existing JSON array:

```javascript
// Original Array:

[
    { "id": 1, "name": "John" },
    { "id": 2, "name": "Alice" }
]
```

Now, you want to append a new element to this array:

```javascript
// Element to Append:

{ "id": 3, "name": "Bob" }
```

After appending, the resulting array would be:

```javascript
// Appended Array:

[
    { "id": 1, "name": "John" },
    { "id": 2, "name": "Alice" },
    { "id": 3, "name": "Bob" }
]
```



**In this appended array:**

* The original elements remain unchanged.
* The new element `{ "id": 3, "name": "Bob" }` is added to the end of the array.

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAA7hJREFUeF7tWt1OE0EUPme7qMSYwna3bN9Ai/FCTLzTICZGUtREH0HgQh9HE0WfwSigxERDjBdGo5j401dgYbYrjZGfsN1jFoS0dH9mO1sEdno75/eb75ydOR2EjP8w4/mDBEAyIOMIyBLIOAFkE5QlwFMCjK0MuV5jjEc2SAYV/Gwa2mwSfYs5Y+TRUBKdZllVyc0YRt+XOH0uBiwxZ5KIHsUZC10nmDIHCpNJ9K2l2hQgjCfRaZFFmDSNwlScvgQgDiF/XTIg6yVgsdoEEDxuZQvNEmFsk/F1ut0EEf1miZX97QGcTYanxERlAkuUM77OmyCnA9HkePQlAEE9inODJAO6TTEe+6IysgRkCQQc1dPsAYHngD0OLItOklobLOn6J1FKR+lbtn0R3MIP08Q/O3I88YXZTKUJMsZOuYTzQFBWVBwZKBQ+dAMExn5ddr3GHCBUVaRhwzB+hx7V02RAVJOp1+va2ro7Dwjn/GCIaE1VctcNo/9dmiD8S/41Ih7fskvw7VgPXtI0rd71Jhg0D/Dv27qe/2mx2lcEPL03WULlSsnon08DBMu2R8DDN20+CKqlgcJgWHypzQOiklhctu8h4IP24GhDVXLXRJlg2fZVasDs7s43OSKg+6Wi/lAEZK4eEOcgCgTMQcXU9bbdi7Ppr/vJg4evAKCnTR5h3DQKT3nsRMmkAsBWsKx2FwieBDjbBIVGk4IQkTwBwkQayfuxhgJgMadCHl1IgjAC3AGEwSAdBXC0WNTmeOz580Agmg6UJfhOAM947OzIRF3HwwEQncm1R7hJgLdKRc2ndOhvcdkZRaAXAKAmSTJSNmImuZ8A+DG6BHgzDISuJL/9yQwdykoAwqgjPJYWK4HngZ2/05roiAEd/DGBALcB4WxQnIRYKRnaS54c/AYMRDP/tQnyBNosc+Q+g0kAyPRBKBNHYcZWzrte40YzK1QlN63r+arFnAUEONO8RkSroOQqaV6GqAEziNjb6geqZlEbsu16OSg+w+hbiGMy11E47jq8uu6+R4Ty1ieXaK0bM4Gg63DvCXU4n887Xb8OxzlwHCe/4Xpvj+xAxGK1cf801UKn7QvJ7uXHnwo1EMumrn+Mo53IeshILDa+MJ/CJSCSTFq6cQyN8iMB4NkFEYR57IvKiMQnGcCDvgjCPPZFZUTikwzgQV8EYR77ojIi8XExQD6RyfojKflMTjIg409lM/9YWvQzdZD1uT6DBzkB0dgkAKIIHnZ9yYDDvoOi8UsGiCJ42PUzz4C/aG1XbkizXH8AAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M144-144v-240h72v168h168v72H144Zm432 0v-72h168v-168h72v240H576ZM288-336l-51-51 57-57H96v-72h198l-57-57 51-51 144 144-144 144Zm384 0L528-480l144-144 51 51-57 57h198v72H666l57 57-51 51ZM144-576v-240h240v72H216v168h-72Zm600 0v-168H576v-72h240v240h-72Z&#x22;/></svg>" data-size="line">  Join

Joining two JSON arrays by a key involves combining the arrays based on a common identifier or key within the JSON objects.

Let's say you have two JSON arrays:

```javascript
// Array 1:

[
    {"id": 1, "name": "John"},
    {"id": 2,"name": "Alice"}
]

// Array 2:

[
    {"id": 1, "age": 30},
    {"id": 3, "age": 25}
]
```

You want to join these arrays based on the "id" key. After merging, the resulting array should contain all unique elements from both arrays, with matching elements combined based on the "id" key. If an element exists in one array but not the other, it should still be included in the merged array.

```javascript
// Merged Array:

[
    {"id": 1, "name": "John", "age": 30},
    {"id": 2, "name": "Alice"},
    {"id": 3, "age": 25}
]
```



**In this join array:**

* The object with `id` equal to 1 exists in both arrays, so their properties are joined into one object.
* The object with `id` equal to 2 only exists in the first array, so it's included as is.
* The object with `id` equal to 3 only exists in the second array, so it's included as is.&#x20;

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAA+pJREFUeF7tmctrE1EUxr/Tl1UhNDOdyeRfEHTjTmupKIh051rdqC1KK4oKorgrdFOrooIvEBFculRExbfgxoWC/gmdSTqTVPDZmiM3bWqaTDKT5M5MIJNl7rnnnu93v3Mzd0Lo8A91uH7EAGIHdDiBuAU63ADxIRi3QNwCHU4gboEoDcDM/WJ9IvoVVR2ROYCZ+6ys/UQIT2nqHiL6EwWESAD8F08jy6L5ZVQQQgdQLb6079FACBVAbfHRQQgNgLf4aCCEAsC/+PAhBA5A/NRZWfsxUDrw/J714ZwJgQIois84z0HY5lf22rjgIQQGoHXxa9phb1APS4EAYOb1VsZ55rbzDOQIuA/geIUrrjBwkIBklVsY71O6spuIfjbnpNqzpAOot/NCPLoxRAUMgXFzTVmEMe7CO/zF2zoQdsl2glQAfsSnVfWLmbXH3AAYmnp7zrY3hQlBKgDTsmdBOFlpOGY41EsjhqJ8FmNm1j4Cxq1KBwgA4jvLcrYUwC+IoLjkmkmn1DOyWkEuAJM3cpf9ikBbV4+wFduLnS99Z2WdcWa+UQFg3NDUVSiuTmB8SOnKTplngVQAQpBt24nFJbwBYUup58vFF3fYBwARVw6BwR+poA4bBn2Xtfsij3QAIunCwoLy4/fiQ+rpmizZvrxoM2sfBqNo99UP4YihqXcqxZmOsxlLhSvrerv3JZPJvEzxgQHwKtKvA7zyyBgPxAFehcUAfJ4BXiBljMcOkEGx0RxxC8Qt4P0g1Kirmo2Pz4BmybUyz/UyBJ429MFzreRtZm77OABgEMbcngabEeZ3TiQAzPn53SjQU7ciieloKqWsvSj5VdNEXCQARJ2WlTvAVLjneh+pcS9oQp/nlFAA5PP55MDAQK7qouP2XmAliMGTaX3wmqeCFgMCB2Bm7EsAj27o79uWSCTmK+uN2gmBAlgWjxNCNANf1/d1b3dzQj0IDJ5I64PXW9zomtMDA1AufnV1xqfeHuxQVfVbI04IEkIgAOYse4YIp9ywM2g0rSuP3MbMjH0IQNVLEREr8qU0dVa2E6QDMDPz0wCddSm0AKIDhqY8qCci7HaQCqBV8SUw9SAQ4XRKUy/KcoI0ALLEhw1BCgDZ4sOE0DKAOuIZRPu9et7LykG3gwQAzhTA5yuEMAOH0rp610ugn/E6EKYMXb3gJ0etmJYBiMRmxrkK8ETpKVam+DrtcNnQ1aq/4RqFIQVAEYJl3wLhcBDiKyEw8Y20NnisUbFu8dIAiORz2dxIWku+lFFYrRyZTG5Y15OvZa0hFYCsosLMEwMIk3Y7rhU7oB13JcyaYgeESbsd14od0I67EmZN/wAzpxBfiXnXhgAAAABJRU5ErkJggg==" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M669-144 444-369v-261L339-525l-51-51 192-192 192 192-51 51-105-105v231l204 204-51 51Zm-378 0-51-51 138-138 51 51-138 138Z&#x22;/></svg>" data-size="line">  Combine

The **Array Combine** node is used to combine multiple values and nodes into a single array. This node consolidates various data inputs and returns the combined array, making it a valuable tool for data aggregation within workflows.

#### Key Features

* **Combining Values:** Allows the inclusion of multiple values from different nodes or direct inputs into a single array.
* **Output:** The combined data is returned as `[node name].value`, providing a straightforward way to access the aggregated array.

#### Use Cases

* **Data Aggregation:** Useful for scenarios where data from multiple sources or nodes needs to be combined into one array for further processing.
* **Batch Processing:** Ideal for workflows that require the consolidation of data points before applying batch operations or transformations.
* **Simplifying Outputs:** Helps in organizing and simplifying outputs by combining related data into a single array structure.

This node is essential for workflows that involve combining and organizing data from various sources into a single array, facilitating efficient data handling and processing.

#### Example

If you have several nodes generating different pieces of data, you can use the Array Combine node to gather all these pieces into one array:

**Input Nodes:**

* Node A: Generates value `1`
* Node B: Generates value `2`
* Node C: Generates value `3`

**Array Combine Node Configuration:**

* Combines values from Node A, Node B, and Node C

**Output:**

* `[node name].value` will be `[1, 2, 3]`

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAABOdJREFUeF7tWt9rHFUU/s5kkwq2qTs/dmej9UWrCD4IDZgHteJDRExo0FeRqk3ig6Ci4H8gCloFEU2siNhHBdFSFF/USiDaPulLfatKd3Z+bNMoPjS798iIm+5uJp0zO7PbxJ15veee893vfPfcX0MY8o+GfPzICcgVMOQM5FNgyAWQF8F8CiSdAr7v37WhaEojHFAKWtL+/bDXNCjF+L1AoyuWNX4+SYxECqj59SdY8UcACkmCDMqWGVe0EXqmbOonpTHFBNRq/mNM9JnU8XW1I+2IbRW/kGAQEeC6vFchqAK0V+J0B9isKUu/eYLo7zgsQgLq9ynwmThnO6mdNb63Ypo/xmESEeC4wdMAPux0xqeY6VxcgEG0E/EhgGbaY2ngo6WS+XFcfBEBNa++yMzvdzgjLNqWsRwXYBDtafDlBEgylIZhif+0Nmnw5QqQsO94wTwYnfOdsGBbxgfd/atu8BQxz4GwapfMV7vbPW/9zgZfWZLEjbIhpvN22Vhsb0uCr9unSAHSAI4XvADGW60gzPxJpWw+2R7U89Ymm9z8qVcCGHyuUjInB03AAhidWYtYBaqu/y2BDl8Fx3/aJXN8AASI8EUqSpIJxwtEARy3/g7Az20qAPxdpWQ++H8gQFQDPM/b11T0HohmGVjZU6BFXdd/GwABInw9KyDNMiNRWFqbNPhERTBNgLSDk/RPgy8noN8MS/yntckVkOKwJpoC0o1QmEnXvXy7osYsiFds01zduhP0JhpKW+g166ThYvcpNAm+vu4Ea7Vgmglft4IQ4aWyZRwfmmWw6gZfEfDw5oCZXbtslvtNwI6pAY4bhNmfbiOgZpdNe9cTIJ1jrlt/RIFPbw6Y8KJtGW/3mwApvp53gkkCuO7lg4oaM0z8Q8U0t5z6PG93FsFjYHSe/QnztmWc6LWaZ9kvCIJbNpp4HMyTAN0Dwt0Q4pMug6LTYJaDSuMrCIIDG0T7bV3/Jc6PiIA0VTYOwPVuzwmQZGDoFSBdBcI3xCaCdwk0B8bqnjFtvlgsXpAugwxcogIdtnX9Z0lisrARTQH5lVgQrvnPt4AxcKZSMh6QEkCM6XLZ+CZuYJ63dqihmrPtdgVt5EvLuinxU52UANGVU9UNvifg/qvA+C+7ZO4TEnDCLhnzcYMP26WKlPiSEiBaBh3Xfw2gV9oUcLpSMh6NI4AZ9RvGtNuKxeKaBLRUkRJfUgJECvgvO8egeJZJW6mU9Ne7QUQ9jBDRySSbqoErYKetAlniESkgy4ASWcbZZIknJyCO7ayrriReaON563c00JyItFdqJrxtam9jxpvQtFNR9gWMXLSs8V+j2kQKqLr+UQKFv8e1fdn8IjNWwHHDMNa7wTm1YDk80UkJu6YdY8kuG8/2TEC48Why82wmYLqcjI5g/zYELIHQ8+VpZ65SEhA6q9aCC0S4NWsSlKXfGPU7m1MLdhYBjn/pCJT6PGsCRkdwwDCMP/o8BZa7f6poxRPVgJZxzffnVBPLRGRlRoTGU1HvB45Xn2EV3vBs/aJ+iwO2r0mk0Vnb0iMLZCICWlAcf+0hqMYUM42lJYJG6VPJzU17nIFvhdMOMuv+A98IZT2AtP5yAlI8hnaT31MNSJvBtP1zBQy7Av5dIlm93K4kIu2N7Za6ayluV06BtFOog7gsne1GX0OvgH8Ax2OcbvWqL2cAAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M684-48v-108H576v-72h108v-108h72v108h108v72H756v108h-72ZM216-216v-528 528Zm.37 72Q186-144 165-165.15 144-186.3 144-216v-528q0-29.7 21.15-50.85Q186.3-816 216-816h528q29.7 0 50.85 21.15Q816-773.7 816-744v333q-17-8-35-12.5t-37-6.5v-314H216v528h266q-2 18-1 36t5 36H216.37Zm107.42-144q15.21 0 25.71-10.29t10.5-25.5q0-15.21-10.29-25.71t-25.5-10.5q-15.21 0-25.71 10.29t-10.5 25.5q0 15.21 10.29 25.71t25.5 10.5Zm0-156q15.21 0 25.71-10.29t10.5-25.5q0-15.21-10.29-25.71t-25.5-10.5q-15.21 0-25.71 10.29t-10.5 25.5q0 15.21 10.29 25.71t25.5 10.5Zm0-156q15.21 0 25.71-10.29t10.5-25.5q0-15.21-10.29-25.71t-25.5-10.5q-15.21 0-25.71 10.29t-10.5 25.5q0 15.21 10.29 25.71t25.5 10.5ZM432-444h240v-72H432v72Zm0-156h240v-72H432v72Zm0 312h68q9-20 21.5-38t27.5-34H432v72Z&#x22;/></svg>" data-size="line">  Collect

The **Collect Outputs** node is used to create an object by collecting multiple values and nodes into a single object. This node aggregates various data inputs and adds them to a specified target, making it a valuable tool for data consolidation within workflows.

#### Key Features

* **Creating Objects:** Allows the inclusion of multiple values from different nodes or direct inputs into a single object.
* **Target Addition:** Adds the collected data to a specified target object, providing an organized way to manage aggregated data.

#### Use Cases

* **Data Consolidation:** Useful for scenarios where data from multiple sources or nodes needs to be combined into one object for further processing.
* **Structured Outputs:** Ideal for workflows that require the aggregation of data points into a structured object before applying further operations or transformations.
* **Organizing Data:** Helps in organizing and simplifying outputs by combining related data into a single object structure.

This node is essential for workflows that involve combining and organizing data from various sources into a single object, facilitating efficient data handling and processing.

#### Example

If you have several nodes generating different pieces of data, you can use the Collect Outputs node to gather all these pieces into one object `newTarget`

**Input Nodes:**

* **Node A:** Generates value `1` with key `a`
* **Node B:** Generates value `2` with key `b`
* **Node C:** Generates value `3` with key `c`

**Configuration**

* **Select or Create Target:** Choose or create the target object where the collected data will be added.
* **Object Mapping:** Map the attributes from each input node to the corresponding keys in the target object.

**Output**

* `newTarget` will contain `{a: 1, b: 2, c: 3}`. This reflects the newly created or updated object with the collected data in the specified target.



## Data & Integrations

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAoVJREFUeF7tV0ty00AQfS2xoIpNsKwfBwj7OAfgAj5GPpUtB4BbBPkcLOAEsEhgDQdAVoRSLLIENyXZEorxjKZcU4QptVayPN3z5vV73RJh5BeN/PwQAkQBI2dALDByAUgTFAuIBUbOgFhg5AKQKSAWEAuMnAGxwMgFIFNALCAWGDkDYoGRC8BsCpTlj9nP1a95TRZ5+JaEwaIlLi+q1+39I+9xFoZP8vr3sryd84pnQwSncdDFL8vqlFd4povR7b8rzid8jKLgnSqnkQVqYGBkdRIGX6fR9LhNuLypuL33yZ+F4cGnhoCiWoBwMkRAEgUdhvzm+xWBtKTp9lcekug8DicN/u3LlIATMJqq6wB48I6i6OnnDQEZCKf/AwFMfJmG04t/SkBRVi9XzI1tAKQEOlzf8h0D1y2YNJq+6NRUVBkTP2+sBhwClG5icga+Ns+ZviRxcLZLgXVxANz9Fc/Ikjg435uAorw9Y+Y3QwrwyT8Ow4PucO2GuniVQu5ZiLHoH7ofs2XBbn/TeFMLdD0A4JyZuiZIhFe7esA9kJoeYkiAsoJ9AmqbMtA0YRDPCXS0Fp1FBeg8/dAKUGLTKGgPBagp6E+BB1GAAhoxXcTx5HLvHrAsq24K6CzQnwJbBCiniMYCf6aIRsJKC2wSe8CHOA7eq/YxUoCLTVBn1f5/QoAJU6IAB98DTAq7eWEaXrrPx1A/qy5e2QR7H1Pk0VUSTt7uWqv6GBs+1XqFUQ8wTebiOiHAxarZxCwKsMmmi7lEAS5WzSZmUYBNNl3MJQpwsWo2MYsCbLLpYi5RgItVs4lZFGCTTRdziQJcrJpNzKIAm2y6mEsU4GLVbGIWBdhk08VcvwGC1eRQFRnijgAAAABJRU5ErkJggg==" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M144-384v-192h48v72h48v-72h48v192h-48v-72h-48v72h-48Zm240 0v-144h-48v-48h144v48h-48v144h-48Zm192 0v-144h-48v-48h144v48h-48v144h-48Zm144 0v-192h120q9.6 0 16.8 7.2 7.2 7.2 7.2 16.8v72q0 9.6-7.2 16.8-7.2 7.2-16.8 7.2h-72v72h-48Zm48-120h48v-24h-48v24Z&#x22;/></svg>" data-size="line">  REST API Client

The **REST API Client** node is used to request data from an external API. This node facilitates communication with external services, making it a valuable tool for integrating third-party data into your workflows.

#### Key Features

* **Request Type:** Supports various HTTP request types such as GET, POST, PUT, DELETE, etc.
* **Enter URL:** Allows the user to specify the URL of the external API endpoint.
* **Headers:** Enables the inclusion of custom headers for authentication and other purposes.
* **Body:** Allows the user to define the body of the request.

#### Use Cases

* **Data Retrieval:** Useful for scenarios where data needs to be fetched from external APIs for processing within the workflow.
* **Data Submission:** Ideal for workflows that require sending data to external services.
* **Integration:** Helps in integrating third-party services by facilitating API communication.

This node is essential for workflows that involve requesting data from or sending data to external APIs, facilitating seamless integration with third-party services.

#### Example

If you need to request data from an external API, you can use the REST API Client node to set up and send the request:

**Configuration**

* **Request Type:** Select the type of HTTP request (e.g., GET, POST).
* **Enter URL:** Specify the URL of the API endpoint (e.g., `https://api.example.com/data`).
* **Headers:** Add any necessary headers (e.g., `Authorization: Bearer <token>`, `Content-Type: application/json`).
* **Body:** Define the body of the request if needed, with the option to use formats like JSON, plain text, or HTML (e.g., `{ "key1": "value1", "key2": "value2" }` for a JSON POST request).

**Output**

The response from the API will be accessible via the following properties:

* `[node name].data`**:** The main data returned from the API.
* `[node name].status`**:** The HTTP status code of the response.
* `[node name].responseOk`**:** A boolean indicating whether the request was successful (status in the 200-299 range).
* `[node name].responseHeaders`**:** The headers returned by the API response.
* `[node name].state`**:** The state of the request, which can be used for handling different stages of the API call.



## Advanced

### <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAl9JREFUeF7tl81u00AURr87rikSmyQTuzULxIp9k/Kz4wnCA8CW0gUSKx6AF2DBCgrsEIglbwECAqyRkJBAxPXYoSBUqUB8UVIc3NC4SIwiwtxZWRrbmnv8nbljguODHK8fAkAS4DgBUcDxAMgmKAqIAo4TEAUcD4B0AVFAFHCcgCjgeACkC4gCooDjBEQBxwMwmy5gzFb7ez7oDGGTwoflQN+eBJ8kH1eY8nN5/vuaiHjH9+ie1vq97Q82EwVik10CY2O4eAZ3o7C5Wi4kzrIzGOBxVXHMvL3oq6ONRuOTTQizArAGxuir7wvAZOP5quIU1EoY1l/95wD4CwPdokgCnS2uFVQrDOsv5xFAtQIVivQ2s2tFwQvq8EYQHOnNHYBN019n5lvTFDho3mbBk+/6R/aA/nkw399d3F4FRp0DtEOKby41m49sw7AKoJekzwnUHi2SsLYc6LvDy9hkF8G4My0BzLyYpP3LzNzh4ZOlUd4DfA/HtNbvbEKwDaBLoNZPAOtFv/+biMdJxkXBHnmrQVAbb5A2QNgGUE7AGMBB54Cqg9IEgHYQ1F7YKPxXl7H4trICDH4NoNixIwKd+LNzwBy3wV6SPiXQycoTHfhZFDZPle8p7xFzfRCKk+wGgCuVABjXoyV9dQ+AND2NnJ5UP8fbhxYo0lp/thhauz9DzOzHJrsApuP7LVJBvQnD2kMi+jY5b8xWK8egM+Vn6Cv73oOoXn9rs/jdZuX4EACOB0AUEAVEAccJiAKOB0C6gCggCjhOQBRwPADSBUQBUcBxAqKA4wGQLiAKiAKOE/gBoigTUFwSrkwAAAAASUVORK5CYII=" alt="<svg xmlns=&#x22;http://www.w3.org/2000/svg&#x22; height=&#x22;20px&#x22; viewBox=&#x22;0 -960 960 960&#x22; width=&#x22;20px&#x22; fill=&#x22;#e8eaed&#x22;><path d=&#x22;M312-384q-10 0-17-7t-7-17v-72h48v48h48v-144h48v168q0 10-7 17t-17 7h-96Zm216 0q-10.2 0-17.1-6.9-6.9-6.9-6.9-17.1v-36h48v12h48v-36h-72q-10.2 0-17.1-6.9-6.9-6.9-6.9-17.1v-60q0-10.2 6.9-17.1 6.9-6.9 17.1-6.9h96q10.2 0 17.1 6.9 6.9 6.9 6.9 17.1v36h-48v-12h-48v36h72q10.2 0 17.1 6.9 6.9 6.9 6.9 17.1v60q0 10.2-6.9 17.1-6.9 6.9-17.1 6.9h-96Z&#x22;/></svg>" data-size="line">  Custom Code

The **Custom Code** node is used to execute custom JavaScript code within your workflow. This node provides a flexible way to perform operations or transformations that are not covered by standard nodes.

#### Key Features

* **JavaScript Execution:** Allows you to write and execute custom JavaScript code.
* **Custom Logic:** Enables the implementation of bespoke logic and algorithms tailored to your specific needs.
* **Input Access:** Provides access to inputs from other nodes, allowing for dynamic and context-aware code execution.
* **Output:** Returns the result of the JavaScript code execution, which can be used for further processing in the workflow.

#### Use Cases

* **Custom Transformations:** Ideal for scenarios where standard nodes do not meet your requirements, and custom logic is needed.
* **Data Processing:** Useful for performing complex data manipulations or calculations.
* **Integration:** Helps in integrating with other systems or APIs that require specific JavaScript code execution.

#### Example

If you need to perform a custom calculation or data transformation, you can use the Custom Code node to run JavaScript code:

**Configuration**

* **JavaScript Code:** Write the JavaScript code to be executed. For example, you can perform a calculation or transform input data:

```javascript
// Example JavaScript code

let inputData = items[0].json; // Access input data
let result = inputData.value * 2; // Perform a calculation
return { result: result }; // Return the result
```



## Conclusion

With the new workflow feature, you have access to a variety of nodes that allow you to create powerful, automated processes without needing extensive coding knowledge. Each node type serves a specific purpose, and by combining them, you can easily build workflows tailored to your needs.

Our intuitive interface is designed to make it easy to get started: experiment with different nodes, explore their functionalities, and see how they can simplify your tasks and processes.&#x20;
