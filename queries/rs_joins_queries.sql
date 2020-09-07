/* Q1 */

SELECT str0, val
FROM (
        select str0, sum(value) as val, row_number() OVER (PARTITION BY str0 ORDER BY val) as number
        from factTable
                INNER JOIN factCube USING (index)
        group by str0, position
    )
WHERE number = 50;

/* Q2 */

SELECT str0, str1, int10, int11, dttime10, dttime11, val
FROM (
        SELECT str0, str1, int10, int11, dttime10, dttime11,
                sum(value) as val,
                row_number()
                OVER (PARTITION BY str0, str1, int10, int11, dttime10, dttime11 ORDER BY sum(value))            as number
        from factCube
                INNER JOIN factTable USING (index)
        group by str0, str1, int10, int11, dttime10, dttime11, position
    )
WHERE number = 50;


/* Q3 */

SELECT str0, str1, str2, str3,
    int10,
    int11,
    int12,
    int13,
    dttime10,
    dttime11,
    dttime12,
    dttime13,
    val
FROM (
        SELECT str0,
            str1,
            str2,
            str3,
            int10,
            int11,
            int12,
            int13,
            dttime10,
            dttime11,
            dttime12,
            dttime13,
            sum(value)   as val,
            row_number()
            OVER (PARTITION BY str0, str1, str2, str3, int10, int11, int12, int13, dttime10, dttime11, dttime12, dttime13 ORDER BY val) as number
        from factTable
                INNER JOIN factCube USING (index)
        group by str0, str1, str2, str3, int10, int11, int12, int13, dttime10, dttime11, dttime12, dttime13, position
    )
WHERE number = 50;


/* Q4 */

select str0, sum(value) as val, position
from factCube
INNER JOIN factTable USING (index)
WHERE str1 = 'KzORBHFRuFFOQm'
group by str0, position
