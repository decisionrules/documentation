# Creating & Running Tests

### A. Save from Test Bench

1. Open the Test Bench tab.
2. Enter input JSON and click Run.
3. Click Save as Test.
4. In the dialog, select a target Test Suite and enter a Test Name.
5. Click Save. _Note: If the input matches an existing test, the UI displays the match. If the output differs from the saved version, you can overwrite the expected output._

### B. Create Manually

1. Open the Tests tab.
2. Click Create New Test.
3. Select a Test Suite and enter a Name.
4. Input the Input JSON and Expected Output JSON.
5. _(Optional)_ Add JSON paths to Ignored output properties.
6. Click Save.

### Executing Tests (Running Tests)

#### Manual Execution

1. Select the checkboxes next to the desired Tests or Test Suites.
2. Click Run selected.
3. _(If no checkboxes are selected, click Run all to execute all tests for the rule)._

#### API Execution

Tests can be executed programmatically for automation (e.g., CI/CD pipelines) using the Rule Testing API. [rule-testing-api.md](../../../api/rule-testing-api.md "mention")

### Debugging Test Runs

The left panel displays all Test Runs for the current rule.

1. Click a Test Run to view its details.
2. Expand a Test Suite to see individual Tests.
3. Expand a Test to inspect the Input, Expected Output, and Received Output.
4. Differences between expected and received outputs are highlighted automatically.

***

This page provides a focused view of tests for an individual rule. To manage your tests from a global workspace view, navigate to the main Tests section.: [tests](../../../space/tests/ "mention")&#x20;

