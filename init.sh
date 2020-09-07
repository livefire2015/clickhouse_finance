#!/bin/bash

# ClickHouse Ops
export CLICKHOUSE_HOST='localhost'
export CLICKHOUSE_PORT=9000
# set your user / password here 
export CLICKHOUSE_USER='default'
# export CLICKHOUSE_PASSWORD='XXX'
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
