

########### Compare States
#####use similar method to calculate ranking for the states
####care effectiveness:
DROP TABLE rankeff_state;
CREATE TABLE rankeff_state AS
SELECT measureid,state, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float) DESC)
  as rank
FROM effective_state
WHERE score<>"Not Available"
order by measureid, rank;

DROP TABLE avgrank_effstate;
CREATE TABLE avgrank_effstate AS
SELECT state, AVG(rank) as avgrank
FROM rankeff_state
GROUP BY state;


####readmission and death measures
#### assign a score to each state per measure as
####(number of hospitals better- number of hospitals worse)/(total hospitals compred to national average)
#### sum the scores all the measures for each state
####then rank each state according to this score

DROP TABLE scoreadm_state;
CREATE TABLE scoreadm_state AS
SELECT measureid,state, (num_better- num_worse)/(num_better+num_worse+num_same) as score
FROM readmissions_state
order by measureid, score;


DROP TABLE rankadm_state;
CREATE TABLE rankadm_state AS
SELECT state, SUM(score) as scoresum,RANK() OVER(
  ORDER BY SUM(score) DESC
) as rank
FROM scoreadm_state
WHERE score IS NOT NULL
GROUP BY state
ORDER BY rank;

###imaging efficiency
###rank each state within each score measure, then calculate average rank for each state
DROP TABLE rankimg_state;
CREATE TABLE rankimg_state AS
SELECT measureid,state, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float))
  as rank
FROM imaging_state
WHERE score <> "Not Available"
order by measureid, rank;

DROP TABLE avgrank_imgstate;
CREATE TABLE avgrank_imgstate AS
SELECT state, AVG(rank) as avgrank
FROM rankimg_state
GROUP BY state;


###complication and infection
###use similar measure as for state readmission and death measures
DROP TABLE scorecomp_state;
CREATE TABLE scorecomp_state AS
SELECT measureid,state, (num_better- num_worse)/(num_better+num_worse+num_same) as score
FROM complicationstate
order by measureid, score;

DROP TABLE rankcomp_state;
CREATE TABLE rankcomp_state AS
SELECT state, SUM(score), DENSE_RANK() OVER(
  ORDER BY SUM(score) DESC
) as rank
FROM scorecomp_state
WHERE score IS NOT NULL
Group by state
order by rank;

####healthcare-associated infections
####
DROP TABLE rankhai_state;
CREATE TABLE rankhai_state AS
SELECT measureid,state, CAST(score as float) as score, DENSE_RANK() OVER (
  PARTITION BY measureid
  ORDER BY CAST(score as float))
  as rank
FROM haistate
WHERE score <> "Not Available"
order by measureid, rank;

DROP TABLE avgrank_haistate;
CREATE TABLE avgrank_haistate AS
SELECT state, AVG(rank) as avgrank
FROM rankhai_state
GROUP BY state;

####join the tables
DROP TABLE joinrank_state;
CREATE TABLE joinrank_state AS
SELECT avgrank_effstate.state as state,
avgrank_effstate.avgrank as eff,
rankadm_state.rank as adm,
avgrank_imgstate.avgrank as img,
rankcomp_state.rank as comp,
avgrank_haistate.avgrank as hai
FROM avgrank_effstate
  FULL OUTER JOIN rankadm_state
  ON rankadm_state.state=avgrank_effstate.state
  FULL OUTER JOIN avgrank_imgstate
  on avgrank_imgstate.state=rankadm_state.state
  FULL OUTER JOIN rankcomp_state
  on rankcomp_state.state=avgrank_imgstate.state
  FULL OUTER JOIN avgrank_haistate
  on avgrank_haistate.state=avgrank_effstate.state;


DROP TABLE stateranks;
CREATE TABLE stateranks AS
SELECT state, eff from joinrank_state
UNION ALL
SELECT state, adm from joinrank_state
UNION ALL
SELECT state, img from joinrank_state
UNION ALL
SELECT state, comp from joinrank_state
UNION ALL
SELECT state, hai from joinrank_state;


DROP TABLE stateresult;
CREATE TABLE stateresult as
SELECT state, avg(eff) as rankscore
from stateranks
group by state
order by rankscore;
