######## COMPARE HOSPITALS
####calculate the rank of hospitals within each procedures, in the effctive care category

DROP TABLE rankeff;
CREATE TABLE rankeff AS
SELECT measureid,providerid, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float) DESC)
  as rank
FROM effectivecare
WHERE score <> "Not Available"
order by measureid, rank;
###hanle procedure "EDV", which has special score values
DROP TABLE rankeff2;
CREATE TABLE rankeff2 AS
SELECT measureid,providerid, score, rank, CASE
    WHEN measureid="EDV" AND score="Very High (60,000+ patients annually)" then 1
    WHEN measureid="EDV" AND score="High (40,000 - 59,999 patients annually)" then 2
    WHEN measureid="EDV" AND score="Medium (20,000 - 39,999 patients annually)" then 3
    When measureid="EDV" AND score="Low (0 - 19,999 patients annually)" then 4
    ELSE rank
    END as rank_final
    from rankeff;

###calculate average rank in effectiveness category
DROP TABLE avgrank_eff;
CREATE TABLE avgrank_eff AS
SELECT providerid, AVG(rank_final) as avgrank
FROM rankeff2
GROUP BY providerid;


#####rank hospitals in readmission procedures, lower scores rank higher, and calculate average ranks
DROP TABLE rankadm;
CREATE TABLE rankadm AS
SELECT measureid,providerid, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float)) as rank
FROM readmissions
WHERE score <> "Not Available"
order by measureid, rank;

DROP TABLE avgrank_adm;
CREATE TABLE avgrank_adm AS
SELECT providerid, AVG(rank) AS avgrank
FROM rankadm
GROUP BY providerid;

###rank hospitals wihtin in imaging efficiencies, lower scores rank higher, and calculate average rank
DROP TABLE rankimg;
CREATE TABLE rankimg AS
SELECT measureid,providerid, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float)) as rank
FROM imaging_hosp
WHERE score <> "Not Available"
order by measureid, rank;

DROP TABLE avgrank_img;
CREATE TABLE avgrank_img AS
SELECT providerid, AVG(rank) as avgrank
FROM rankimg
GROUP BY providerid;

####rank within procedures that are under the category of complication, and calculate average ranks
### the measures that were omited are components of 'PSI_90_SAFETY'
DROP TABLE rankcomp;
CREATE TABLE rankcomp AS
SELECT measureid,providerid, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float)) as rank
FROM complicationhosp
WHERE score <> "Not Available" and
measureid in ('COMP_HIP_KNEE', 'PSI_4_SURG_COMP', 'PSI_90_SAFETY')
ORDER BY measureid, rank;

DROP TABLE avgrank_comphosp;
CREATE TABLE avgrank_comphosp AS
SELECT providerid, AVG(rank) as avgrank
FROM rankcomp
GROUP BY providerid;

####rank by HAI and calculate average rank
DROP TABLE rankhai;
CREATE TABLE rankhai AS
SELECT measureid,providerid, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float)) as rank
FROM haihosp
WHERE score <> "Not Available"
ORDER BY measureid, rank;

DROP TABLE avgrank_haihosp;
CREATE TABLE avgrank_haihosp AS
SELECT providerid, AVG(rank) as avgrank
FROM rankhai
GROUP BY providerid;

###Rank by Total Performance score of HVBP program
DROP TABLE ranktps;
CREATE TABLE ranktps AS
SELECT providerid, CAST(TPS AS FLOAT) AS TPS, DENSE_RANK() OVER(
  ORDER BY CAST(TPS AS FLOAT) DESC
) as rank
FROM hvbp_tps;



###join the tables together
DROP TABLE joinrank_hosp;
CREATE TABLE joinrank_hosp AS
SELECT avgrank_eff.providerid as hospital,
avgrank_eff.avgrank as eff,
avgrank_adm.avgrank as adm,
avgrank_img.avgrank as img,
avgrank_comphosp.avgrank as comp,
avgrank_haihosp.avgrank as hai,
ranktps.rank as tps
FROM avgrank_eff
  FULL OUTER JOIN avgrank_adm
  ON avgrank_adm.providerid=avgrank_eff.providerid
  FULL OUTER JOIN avgrank_img
  on avgrank_img.providerid=avgrank_adm.providerid
  FULL OUTER JOIN avgrank_comphosp
  on avgrank_comphosp.providerid=avgrank_img.providerid
  FULL OUTER JOIN avgrank_haihosp
  on avgrank_haihosp.providerid=avgrank_comphosp.providerid
  FULL OUTER JOIN ranktps
  on ranktps.providerid=avgrank_eff.providerid;

####sum the ranks, add hospital names and sort the hospitals,
#### hospitals with higher ranks (lower rank numbers) have higher qualityies

DROP TABLE rankcombine;
CREATE TABLE rankcombine AS
SELECT hospital, eff from joinrank_hosp
UNION ALL
SELECT hospital, adm from joinrank_hosp
UNION ALL
SELECT hospital, img from joinrank_hosp
UNION ALL
SELECT hospital, comp from joinrank_hosp
UNION ALL
SELECT hospital, hai from joinrank_hosp
UNION ALL
SELECT hospital, tps from joinrank_hosp;


DROP TABLE hospscore;
CREATE TABLE hospscore AS
SELECT hospital, AVG(eff) as rankscore
from rankcombine
group by hospital;

DROP TABLE hosprank;
CREATE TABLE hosprank as
select hospscore.hospital, hospscore.rankscore, hospital_info.hospitalname
from hospscore
inner join hospital_info
on hospscore.hospital = hospital_info.providerid
order by hospscore.rankscore;
