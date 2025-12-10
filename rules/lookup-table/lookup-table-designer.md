---
description: >-
  In this section, you can easily create and manage your Lookup Tables,
  organizing reference data that can be queried by other rules in your space.
---

# Lookup Table Designer

<figure><img src="../../.gitbook/assets/image (5).png" alt="Lookup Table Overview"><figcaption><p>Lookup Table Overview</p></figcaption></figure>

### Editing and Saving Changes

When editing a Lookup Table, you can make changes directly in the table designer. Use the control buttons in the top-right corner to manage your edits:

* **Undo** ⟲ – reverts your last action
* **Redo** ⟳ – restores the reverted change
* **Save** 💾 – saves the current version of the table

<figure><img src="../../.gitbook/assets/image (6).png" alt="Lookup Table Overview"><figcaption><p>Save Controls</p></figcaption></figure>

These actions help you safely adjust the table before saving. Each time you save, a new snapshot of the Lookup Table is created and recorded in the **History** panel, where you can review or restore past versions.

{% hint style="info" %}
All changes are made to the current table version. Use rule versioning to maintain different states of your data.
{% endhint %}

### Table Structure

A Lookup Table consists of:

* **Columns**: Define the structure and schema of your data
* **Rows**: Contain the actual data values
* **Primary Key**: One column that uniquely identifies each row

#### Column Types

Unlike Decision Tables, Lookup Tables have a simpler column structure:

| Element              | Description                                 |
| -------------------- | ------------------------------------------- |
| **Column Name**      | The display name shown in the column header |
| **Primary Key Flag** | Indicates if this column is the primary key |
| **Order**            | Position of the column in the table         |

### Column Operations

#### Add Column

To add a new column, click the **+** button next to your rightmost column.

![Add Column](<../../.gitbook/assets/image (7).png>)

{% hint style="warning" %}
You cannot add a new primary key column. If you need to change the primary key, you must create a new Lookup Table.
{% endhint %}

#### Rename Column

To rename a column, double-click on the column name in the header and type the new name. Press **Enter** or click outside the field to confirm. You can also find a rename option in the context menu when right-clicking a column header.

![Rename Column](<../../.gitbook/assets/image (8).png>)

#### Reorder Columns

To change the position of a column:

1. Click and hold the column header
2. Drag the column to its new position
3. Release to drop

{% hint style="info" %}
The primary key column is always pinned to the left side and cannot be moved.
{% endhint %}

#### Delete Column

To delete a column:

1. Click the dropdown arrow (or right-click) in the column header
2. Select **Delete Column**
3. Confirm the deletion in the modal

{% hint style="warning" %}
The primary key column cannot be deleted.
{% endhint %}

### Row Operations

Multiple Row Edits

To Edit multiple rows hold **Ctrl** (or **Cmd** on Mac) and click to select multiple rows and right-click to open the context menu. Alternatively hold **Shift** and click on the first and last row headers of the range you wish to select.

#### Add Row

To add a new row, click the **+ Row** button in the bottom toolbar. A new row will be added at the end of the table with empty values.

New rows are also automatically added when pasting content from other spreadsheet editors or when importing CSV data

![Add Row](<../../.gitbook/assets/image (9).png>)

#### Copy Row

To duplicate a row:

1. Right-click a row header (or a group of headers)
2. Select **Duplicate Row**

The duplicated row will appear below the original. Remember to change the primary key value to maintain uniqueness.

#### Insert Row

To insert a row at a specific position:

1. Right-click a row header (or a group of headers)
2. Select **Insert Row Above** or **Insert Row Below**

#### Delete Row

To delete a row:

1. Right-click a row header (or a group of headers)
2. Select **Delete Row**

### Primary Key Validation

The Lookup Table Designer automatically validates primary key integrity:

#### Duplicate Detection

When you enter a primary key value that already exists in the table:

* The cell is highlighted in red
* A validation error appears
* You cannot save until the duplicate is resolved

![Duplicate Key and Empty Key Errors](<../../.gitbook/assets/image (10).png>)

#### Empty Primary Key

Primary key cells cannot be empty:

* Empty primary key cells are highlighted
* A validation error appears
* The row with an empty primary key will not be saved

#### Error Navigation

When validation errors exist, use the **Error Navigator** in the toolbar to:

* See the total error count
* Navigate to the next/previous error
* Jump directly to specific error rows

![Error Navigator](<../../.gitbook/assets/image (12).png>)

### Search

To search through your Lookup Table:

1. Find the input in the bottom bar
2. Select **Search**
3. Type your search term

The search will:

* Highlight matching cells in green
* Show the number of rows containing matches
* Allow navigation between matches using arrow buttons

![Search](<../../.gitbook/assets/image (11).png>)

#### Go to Row

Alternative to the **Search** feature if you know the row number:

1. Click **'#'** icon in the input in the bottom bar
2. Enter the row number
3. Press **Enter**

The table will scroll to that row and highlight it.

### Performance Considerations

Lookup Tables are optimized for large datasets:

* **Virtual scrolling**: Only visible rows are rendered, enabling smooth performance with hundreds of thousands of rows
* **Efficient indexing**: Primary key lookups are O(1) complexity

{% hint style="info" %}
Lookup Tables can support up to **hundreds of thousands of rows** depending on your plan.
{% endhint %}

### Keyboard Shortcuts

| Shortcut        | Action                     |
| --------------- | -------------------------- |
| **Tab**         | Move to next cell          |
| **Shift + Tab** | Move to previous cell      |
| **Enter**       | Confirm edit and move down |
| **Escape**      | Cancel current edit        |
| **Ctrl + Z**    | Undo                       |
| **Ctrl + Y**    | Redo                       |
| **Ctrl + S**    | Save                       |
| **Ctrl + F**    | Open search                |
