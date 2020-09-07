# How to use this package

This package creates a sample dataset that mimick a financial Cube, like for example daily P&L values or MtM values in the financial risk domain. These values or called facts. 

Other dimensions contain categorical values of various type (string, integer, datetime) to mimick attributes from our financial cube.

1. ClickHouse environment : This dataset uses a distributed MergeTree that may use a cluster of server, in order to take advantage of the distributed nature of ClickHouse.

1. First execute the ``init.sh`` to instanciate environment variables.

    ```bash
    source init.sh
    ```
    You can modify any ENVIRONNEMENT VARIABLE in this script as you wish:
    host, port, user password.

    To specify the number of ROWS in the target table, set the *NB_PART* variable. This drives the number of times the dataset is duplicated:
    * NB_PART = 1 --> 10k ROWS
    * NB_PART = 2 --> 20k ROWS
    * NB_PART = 3 --> 40k ROWS
    * NB_PART = 4 --> 80k ROWS
    * ...



1. execute the ``dataset_gen.py`` python script to generate the dataset, and insert it into the clickhouse DB.
    ```bash
    python dataset_gen.py
    ```

    The script creates a table named factTable that contains:
    * 100 scalar columns (1/3 string, 1/3 integer, 1/3 datetime), that represent attributes of the cube
    * 1 index column
    * 1 partition column
    * 1 array column to store the vectors that represent the fact column of our cube

    The factTable is a MergeTree table using PARTITION *partition* to distribute the data.

1. export the data set from the clickhouse DB to the Redshift DB by executing the ``export_to_redshift.sh`` script.

1. benchmark: in the file `bench_queries.sql` you can find :
    * 3 queries to compute the quantile (Value at Risk for example) of our P&L vectors with 3 different levels of aggregation
    * 1 query to flatten the data with the using the vector's indexes.
