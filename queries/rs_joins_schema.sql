CREATE TABLE IF NOT EXISTS factTable
(
    index   BIGINT  PRIMARY KEY,
    int0    BIGINT,
    int1    BIGINT,
    int2    BIGINT,
    int3    BIGINT,
    int4    BIGINT,
    int5    BIGINT,
    int6    BIGINT,
    int7    BIGINT,
    int8    BIGINT,
    int9    BIGINT,
    int10   BIGINT,
    int11   BIGINT,
    int12   BIGINT,
    int13   BIGINT,
    int14   BIGINT,
    int15   BIGINT,
    int16   BIGINT,
    int17   BIGINT,
    int18   BIGINT,
    int19   BIGINT,
    int20   BIGINT,
    int21   BIGINT,
    int22   BIGINT,
    int23   BIGINT,
    int24   BIGINT,
    int25   BIGINT,
    int26   BIGINT,
    int27   BIGINT,
    int28   BIGINT,
    int29   BIGINT,
    int30   BIGINT,
    int31   BIGINT,
    int32   BIGINT,
    int33   BIGINT,
    dttime0   timestamp,
    dttime1   timestamp,
    dttime2   timestamp,
    dttime3   timestamp,
    dttime4   timestamp,
    dttime5   timestamp,
    dttime6   timestamp,
    dttime7   timestamp,
    dttime8   timestamp,
    dttime9   timestamp,
    dttime10  timestamp,
    dttime11  timestamp,
    dttime12  timestamp,
    dttime13  timestamp,
    dttime14  timestamp,
    dttime15  timestamp,
    dttime16  timestamp,
    dttime17  timestamp,
    dttime18  timestamp,
    dttime19  timestamp,
    dttime20  timestamp,
    dttime21  timestamp,
    dttime22  timestamp,
    dttime23  timestamp,
    dttime24  timestamp,
    dttime25  timestamp,
    dttime26  timestamp,
    dttime27  timestamp,
    dttime28  timestamp,
    dttime29  timestamp,
    dttime30  timestamp,
    dttime31  timestamp,
    dttime32  timestamp,
    str0    varchar(20),
    str1    varchar(20),
    str2    varchar(20),
    str3    varchar(20),
    str4    varchar(20),
    str5    varchar(20),
    str6    varchar(20),
    str7    varchar(20),
    str8    varchar(20),
    str9    varchar(20),
    str10   varchar(20),
    str11   varchar(20),
    str12   varchar(20),
    str13   varchar(20),
    str14   varchar(20),
    str15   varchar(20),
    str16   varchar(20),
    str17   varchar(20),
    str18   varchar(20),
    str19   varchar(20),
    str20   varchar(20),
    str21   varchar(20),
    str22   varchar(20),
    str23   varchar(20),
    str24   varchar(20),
    str25   varchar(20),
    str26   varchar(20),
    str27   varchar(20),
    str28   varchar(20),
    str29   varchar(20),
    str30   varchar(20),
    str31   varchar(20),
    str32   varchar(20),
    "partition" BIGINT
) DISTKEY(index);


CREATE TABLE IF NOT EXISTS factCube (
    index    BIGINT,
    position SMALLINT,
    value    FLOAT4,
    PRIMARY  KEY (index, position)
) 
DISTKEY (index)
SORTKEY (index, position);

COPY factCube
FROM 's3://<bucket_name>/ica/data/factCube/factCube.csv.gz'
CREDENTIALS ''
DELIMITER ','
  EMPTYASNULL
  ESCAPE
  GZIP
  MAXERROR 100000
  REMOVEQUOTES
  TRIMBLANKS
  TRUNCATECOLUMNS;


COPY factTable
FROM 's3://<bucket_name>/ica/data/factTable/factTable.csv.gz'
CREDENTIALS ''
DELIMITER ','
  EMPTYASNULL
  ESCAPE
  GZIP
  MAXERROR 100000
  REMOVEQUOTES
  TRIMBLANKS
  TRUNCATECOLUMNS;