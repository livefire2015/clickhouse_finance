#!/bin/bash

# ClickHouse Ops
export CLICKHOUSE_HOST='review_samplemodulegeneration.the-ica.ninja'
export CLICKHOUSE_HOST='localhost'
export CLICKHOUSE_PORT=9000
export CLICKHOUSE_USER='default'
export CLICKHOUSE_PASSWORD='root'
export ckh_connect="--host ${CLICKHOUSE_HOST} --port ${CLICKHOUSE_PORT} --user=${CLICKHOUSE_USER} --password=${CLICKHOUSE_PASSWORD}"

# Redshift Ops
table_rs='factTable'

# DB stuff
export ARRAY_LENGTH=1000
export NB_ROWS=10000
export NB_PART=13
# NB_PART=10 --> around 1.12M rows
# NB_PART=13 --> around 9M rows

printenv |grep CLICKHOUSE
