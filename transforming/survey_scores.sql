DROP TABLE surveyavg;
create TABLE surveyavg as
select providerid, AVG(cast(rating as double)) as surveyscore
from hcahps
group by providerid;

DROP TABLE survey_scores;
create table survey_scores as
select hospscore.hospital, hospscore.rankscore, surveyavg.surveyscore
from hospscore inner join surveyavg
on hospscore.hospital=surveyavg.providerid;
