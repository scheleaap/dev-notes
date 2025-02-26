# SQL

## Joins

Because I always forget.

Type | What it does
--- | ---
Inner join | Keep rows with the same values in a column. The default.
Left (outer) | Returns all the rows from the left side and the matching rows from the right side. If there are no matching values on the right side, then it returns a null.
Right (outer) | The same as left (outer join), but with the sides flipped.
(Full) (outer) | Returns all the rows from both sides, including the matching and non-matching rows. If there are no matching values, then the result will contain a null value in place of the missing data.
Cross | Returns all possible combinations of rows from both sides.
Left anti | Returns only the rows from the left side that do not have matching values on the right side.
Left semi | Returns only the rows from the left side that have matching values on the right side. The columns from the right side are _not_ included in the result.
Self | Not sure.

**Source:** https://medium.com/plumbersofdatascience/exploring-the-different-join-types-in-spark-sql-a-step-by-step-guide-49342ffe9578
