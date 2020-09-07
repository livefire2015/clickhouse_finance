set -e

REDSHIFT_CLUSTER=redtest
REDSHIFT_USER="julien"
REDSHIFT_PASSWORD="Coucou112"
S3_BUCKET="test-redshift-ica"
AWS_READ_BUCKET_KEY_ID="AKIAWFACNN66TJDKELOW"
AWS_READ_BUCKET_ACCESS_KEY="SKkd2x8tuzOtmFquA13rjDkIXK54wqyO0HWB5lXg"

launch() {
    aws redshift create-cluster \
        --cluster-identifier $REDSHIFT_CLUSTER \
        --node-type dc2.8xlarge \
        --master-username $REDSHIFT_USER \
        --master-user-password $REDSHIFT_PASSWORD \
        --publicly-accessible \
        --number-of-nodes 2
}
status() {
    aws redshift describe-clusters --cluster-identifier $REDSHIFT_CLUSTER --query 'Clusters[*].[ClusterStatus,ClusterIdentifier]' --output text
}

wait() {
    while aws redshift describe-clusters --cluster-identifier $REDSHIFT_CLUSTER | grep ClusterStatus | grep creating; do
        sleep 1
        status
    done
    status
    printf "authorize manually inbound from my ip in security group"
}

clickhouse="clickhouse client --port 9000 "

tos3() {
    parts=$($clickhouse --query 'select distinct partition from factTable format TabSeparated')
    for part in $parts; do
        echo $part
        $clickhouse --query 'select * from factTable ARRAY JOIN arrFloat as arrFloat where partition=$part format CSV' |
            aws s3 cp - s3://test-redshift-ica/Position$part.csv
    done
}

tos3
exit

endpoint=$(aws redshift describe-clusters --cluster-identifier ${REDSHIFT_CLUSTER} --query 'Clusters[*].Endpoint.Address' --output text)
securitygroup=$(aws redshift describe-clusters --cluster-identifier ${REDSHIFT_CLUSTER} --query 'Clusters[*].VpcSecurityGroups[*].VpcSecurityGroupId' --output text)

configure() {
    aws ec2 authorize-security-group-ingress \
        --group-id $securitygroup \
        --ip-permissions IpProtocol=tcp,FromPort=5439,ToPort=5439,IpRanges=[{CidrIp=176.162.183.225/32}] && true
}
configure

sql_create=$(cat create_table_ps.sql)
psurl="host=$endpoint user=${REDSHIFT_USER} password=${REDSHIFT_PASSWORD} dbname=$(db) port=5439"

create_tables() {
    psql "$psurl" -c "\dt"
    psql "$psurl" -c "$sql_create"
}
create_tables

parts=$($clickhouse --query 'select distinct partition from factTable format TabSeparated')
echo $parts
psql "$psurl" -c "truncate table factTable;"
echo "psql \"$psurl\""
psql "$psurl" -c "
    COPY factTable
    FROM 's3://test-redshift-ica/Position20'
    CREDENTIALS 'aws_access_key_id=${AWS_READ_BUCKET_KEY_ID};aws_secret_access_key=${AWS_READ_BUCKET_ACCESS_KEY}'
    REGION 'eu-west-3'
    FORMAT CSV
"
