Spark Syntax: Python/Scala/SQL
==============================

.. Syntax references:
   https://docutils.sourceforge.io/docs/user/rst/quickstart.html
   https://docutils.sourceforge.io/docs/ref/rst/directives.html

In the examples on this page:

* *df*, *df1*, *df2*, *...*, *dfn* stand for data frames
* *c1*, *c2*, *...*, *cn* stand for column names
* *v1*, *v2*, *...*, *vn* stand for values
* *e1*, *e2*, *...*, *en* stand for logical expressions (for example: ``c1 = v1 AND c2 = v2``)
* Words between angle brackets (e.g. ``<expression>`` ) are placeholders for something else

Note that this page does not try to be exhaustive 🙂.

Main
----

.. list-table::
   :header-rows: 1

   * - 
     - Python
     - Scala
     - SQL
   * - Common imports
     - .. code:: python

          from pyspark.sql import *
          import pyspark.sql.functions as F
          from pyspark.sql.types import *
     - .. code:: scala

          import org.apache.spark.sql._
          import org.apache.spark.sql.functions._
          import org.apache.spark.sql.types._
          import java.time.LocalDateTime
          import java.sql.Timestamp
     - N/A
   * - Visualize a data frame
     - * ``display(df)``
       * ``df.display()`` (broken as of 2024)
       * ``df.show()`` (ugly)
     - * ``df.display()``
       * ``df.show()`` (ugly)
       * *TODO: Snippet for ``df.disp()``*
     - N/A
   * - Count rows
     - ``df.count()``
     - *See Python*
     - ``SELECT count(*) FROM ...``
   * - Filtering rows
     - ``df.filter(<expression>)``
     - *See Python*
     - ``... WHERE <expression>``
   * - Expressions: equality
     - | ``(c1 == v1)`` ⚠️ extra parentheses
       | ``(c1 != v1)`` ⚠️ extra parentheses
       | ``c1.isNull()``
     - | ``c1 === v1``
       | ``c1 =!= v1`` ⚠️ do not use ``!==``
       | ``c1.isNull``
     - | ``c1 = v1``
       | ``c1 != v1``
       | ``c1 IS NULL``
   * - Expression: boolean
     - | ``~e1``
       | ``e1 & e2``
       | ``e1 | e2``
     - | ``!e1``
       | ``e1 && e2``
       | ``e1 || e2``
     - | ``NOT e1``
       | ``e1 AND e2``
       | ``e1 OR e2``
   * - Expression: other
     - | ``c1.isin(v1, v2)``
     - | ``c1.isin(v1, v2)`` / ``c1.isInCollection(Seq(v1, v2))``
     - | ``c1 IN (v1, v2)``
   * - Limit rows
     - ``df.limit(10)``
     - *See Python*
     - ``... LIMIT 10``
   * - Read CSV
     - .. code:: python

          df = (
              spark.read.format("csv")
              .options(
                  delimiter=";",
                  quote='"',
                  escape='"',
                  header="true",
                  inferSchema="false",
                  mode="FAILFAST",
                  unescapedQuoteHandling="RAISE_ERROR",
                  lineSep="\n",
              )
              .schema("id int, name string")
              .load("persons-*.csv")
          )
     - .. code:: scala

          df = spark.read.format("csv")
            .options(
              Map(
                "delimiter" -> ";",
                "quote" -> "\"",
                "escape" -> "\"",
                "header" -> "true",
                "inferSchema" -> "false",
                "mode" -> "FAILFAST",
                "unescapedQuoteHandling" -> "RAISE_ERROR",
                "lineSep" -> "\n"
              )
            )
            .schema("id int, name string")
            .load("persons-*.csv")
     -
   * - Write CSV
     - ``df.repartition(1).write.csv("data.csv")``
     - *See Python*
     -
   * - Reference column
     - | ``df.c1``
       | ``df["c1"]``
       | ``col("c1")``
       
       Benefits of ``col()``:

       * It can be re-used as it's not df specific
       * It can be used before the df is assigned

       See https://stackoverflow.com/a/55106477 for details
     - | ``$c1``
       | ``col("c1")``
     - ``c1``
   * - Select columns
     - | ``df.select(F.col("c1"), F.col("c2"))``
       | ``df[["c1", "c2"]]``
     - ``df.select(F.col("c1"), F.col("c2"))``
     - ``SELECT c1, c2 FROM ...``
   * - Rename column
     - | ``df.withColumnRenamed("c1", "foo")``
       | ``F.col("c1").alias("foo")``
     - | ``df.withColumnRenamed("c1", "foo")``
       | ``$"c1".alias("foo")``
     - ``c1 AS foo``
   * - Remove column
     - ``df.drop("c1")``
     - *See Python*
     - N/A
   * - Join
     - ``df1.join(df2, on=["c1", "c2"], how="left")``
     - ``df1.join(df2, usingColumns=Seq("c1", "c2"), joinType="left")``
     - .. code:: sql

          SELECT
            ...
          FROM
            t1 LEFT JOIN t2 ON
              (t1.c1 = t2.c1 AND t1.c2 = t2.c2)
   * - Group by
     -
     -
     -


Schema Definition / DataTypes
-----------------------------

.. list-table::
   :header-rows: 1

   * - 
     - Python
     - Scala
   * - Small differences when defining a schema
     - .. code:: python

          schema = StructType(
              [
                  StructField("transactionId", StringType(), False),
                  StructField("score", FloatType(), True),
                  StructField("modelId", StringType(), True),
              ]
          )
     - .. code:: scala

          val Schema: StructType =
            StructType(
              Seq(
              StructField("transactionId", StringType, false),
              StructField("score", FloatType, true),
              StructField("modelId", StringType, true)
            )
          )


References
----------
.. list-table::
   :header-rows: 1

   * - 
     - Python
     - Pandas
     - Scala
     - SQL
   * - API reference
     - https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/index.html
     - https://spark.apache.org/docs/latest/api/python/reference/pyspark.pandas/index.html
     - https://spark.apache.org/docs/latest/api/scala/org/apache/spark/index.html
     - https://spark.apache.org/docs/latest/sql-ref.html
   * - API reference → functions
     - https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html
     -
     -
     - https://spark.apache.org/docs/latest/api/sql/index.html
