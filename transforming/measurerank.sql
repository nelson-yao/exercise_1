###########calculate measure variation
#### to eliminate effect of outliers, use inter-quartile range
###combine the scores from different categories into one tables
DROP TABLE bigtable;
CREATE TABLE bigtable AS
SELECT providerid, measureid, score from effectivecare
UNION ALL
SELECT providerid,measureid, score from readmissions
UNION ALL
SELECT providerid, measureid,score from imaging_hosp
UNION ALL
SELECT providerid,measureid, score from complicationhosp
UNION ALL
SELECT providerid, measureid, score from haihosp;


DROP TABLE tps_iq;
CREATE TABLE tps_iq as
SELECT percentile(CAST(TPS as BIGINT) , 0.75)-percentile(CAST(TPS as BIGINT) , 0.25) as IQR
FROM hvbp_tps;

DROP TABLE iqtable;
CREATE TABLE iqtable as
SELECT measureid, (percentile(CAST(score as BIGINT) , 0.75)- percentile(CAST(score as BIGINT) , 0.25)) as IQR
FROM bigtable
group by measureid
order by IQR DESC;

DROP TABLE measurerank;
create table measurerank as
select iqtable.IQR, iqtable.measureid, , measures.measurename
from iqtable
inner join measures
on iqtable.measureid=measures.measureid
order by iqtable.IQR DESC;
