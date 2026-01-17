Backlog Guide
=============

This project includes a backlog table that tracks our review of all
top-level comments posted to the [HN thread][HNT] for this project.

[HNT]: https://news.ycombinator.com/item?id=46618714


Backlog Table
-------------

The backlog table is available here:

**[backlog.md][]**

[backlog.md]: backlog.md


Maintain Table
--------------

Here is how to maintain this table:

1. Column **COMMENT**: Review each link one by one and visit the link
   (if any) shared by the commenter.  If there are multiple links,
   decide which one among them represents the primary website of the
   author.  We will pick at most one primary link from each comment to
   keep things simple.

2. Column **URL**: Insert the primary link in this column.  If no
   primary link was found, insert hyphen (`-`) in this column.

3. Column **D**: This is the decision column.  After reviewing the
   website, decide whether we should include it in our directory.
   Enter the decision in the **D** column as `Y` or `N` or `-`
   described as follows:

   - `Y`: Yes, we want to include this website in the directory.
   - `N`: No, we do not want to include the website in the directory.
   - `-`: No relevant link or website address was found.

4. Column **I**: This is the inclusion status that reflects whether a
   website has already been added to the directory.  Enter as follows:

   - `Y`: Yes, the website has already been added to the directory.
   - `-`: Otherwise.

4. Column **REM**: If the answer to the **D** column was `N`, write a
   very brief justification here.  Otherwise, leave it blank.

Formatting guideline: Susam uses Emacs to edit the table which
automatically reformats the table neatly to align all the columns
perfectly.  However, other collaborators do not have to do this if
their editor does not support such a feature.  It is okay to make the
alignment messy as long as the data in it is correct.  However,
everytime Susam touches this file, the table will get reformatted and
realigned.


Refresh Table
-------------

The table can be updated anytime with the latest comments from the HN
thread by entering the following command:

```sh
make update
```

**CAUTION:** Remember to save your current edits to `backlog.md`
before running the above command.

The above command will fetch all the top-level comments from the
aforementioned HN thread and insert the missing comments into the
table.  While doing so, it will preserve all existing comments and our
edits in the file.
