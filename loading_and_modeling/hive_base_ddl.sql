DROP TABLE hospital_info;
CREATE EXTERNAL TABLE hospital_info(
providerid string,
hospitalname string,
address string,
city string,
hosstate string,
zip string,
county string,
phone string,
hostype string,
ownership string,
emergency string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospital_info';


DROP TABLE effectivecare;
CREATE EXTERNAL TABLE effectivecare(
providerid string,
hospitalname string,
address string,
city string,
hosstate string,
zip string,
county string,
phone string,
condition string,
measureid string,
measurename string,
score int,
sample int,
footnote string,
measurestart string,
measureend string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

ALTER TABLE effectivecare
CHANGE score score float;


DROP TABLE effective_state;
CREATE EXTERNAL TABLE IF NOT EXISTS effective_state(
  state string,
  condition string,
  measurename string,
  measureid string,
  score INT,
  footnote string,
  measurestart TIMESTAMP,
  measureend TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_state';




DROP TABLE readmissions;
CREATE EXTERNAL TABLE readmissions(
providerid string,
hospitalname string,
address string,
city string,
hosstate string,
zip string,
county string,
phone string,
condition string,
measurename string,
measureid string,
compare string,
denominator int,
score decimal,
lower float,
higer float,
footnote string,
measurestart TIMESTAMP,
measureend TIMESTAMP)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';
ALTER TABLE effectivecare
CHANGE score score float;

DROP TABLE measures;
CREATE EXTERNAL TABLE measures(
measurename string,
measureid string,
measurestartquarter string,
measurestartdate TIMESTAMP,
measureendquarter string,
measureenddate TIMESTAMP)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';

DROP TABLE hcahps;
CREATE EXTERNAL TABLE hcahps(
providerid string,
hospitalname string,
address string,
city string,
state string,
zip string,
county string,
phone string,
survey_measureid string,
survey_question string,
survey_answerdes string,
rating int,
rating_footnote string,
answer_percent int,
answer_footnote string,
num_complete string,
num_complete_footnote string,
response_percent int,
response_percent_footnote string,
measurestart TIMESTAMP,
measureend TIMESTAMP)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hcahps_assess';


DROP TABLE imaging_hosp;
CREATE EXTERNAL TABLE imaging_hosp(
providerid string,
hospitalname string,
address string,
city string,
hosstate string,
zip string,
county string,
phone string,
measureid string,
measurename string,
score float,
footnote string,
measurestart DATE,
measureend DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/imaginghosp';

DROP TABLE imaging_state;
CREATE EXTERNAL TABLE imaging_state(
state string,
measureid string,
measurename string,
score float,
footnote string,
measurestart DATE,
measureend DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/imagingstate';


DROP TABLE readmissions_state;
CREATE EXTERNAL TABLE readmissions_state(
state string,
measurename string,
measureid string,
num_worse int,
num_same int,
num_better int,
num_toofew int,
footnote string,
measurestart DATE,
measureend DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions_state';



DROP TABLE surveyhvbp;
CREATE EXTERNAL TABLE surveyhvbp(
providerid string,
hospitalname string,
address string,
city string,
hosstate string,
zip string,
county string,
com_nurs_ach string,
com_nurs_imp string,
com_nurs_dim string,
com_doc_ach string,
com_doc_imp string,
com_doc_dim string,
resp_ach string,
resp_imp string,
resp_dim string,
pain_ach string,
pain_imp string,
pain_dim string,
com_med_ach string,
com_med_imp string,
com_med_dim string,
clean_ach string,
clean_imp string,
clean_dim string,
dis_ach string,
dis_imp string,
dis_dim string,
rating_ach string,
rating_imp string,
rating_dim string,
basescore float,
consisscore float)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey';

DROP TABLE complicationhosp;
CREATE EXTERNAL TABLE complicationhosp(
  providerid string,
  hospitalname string,
  address string,
  city string,
  hosstate string,
  zip string,
  county string,
  phone string,
  measurename string,
  measureid string,
  compare string,
  denominator float,
  score float,
  lowerest float,
  higherest float,
  footnote string,
  measurestart TIMESTAMP,
  measureend TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/complication_hosp';

DROP TABLE complicationstate;
CREATE EXTERNAL TABLE complicationstate(
  state string,
  measurename string,
  measureid string,
  num_worse int,
  num_same int,
  num_better int,
  num_toofew int,
  footnote string,
  measurestart TIMESTAMP,
  measureend TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/complication_state';

DROP TABLE haihosp;
CREATE EXTERNAL TABLE haihosp(
  providerid string,
  hospitalname string,
  address string,
  city string,
  hosstate string,
  zip string,
  county string,
  phone string,
  measurename string,
  measureid string,
  compare string,
  score float,
  footnote string,
  measurestart TIMESTAMP,
  measureend TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/HAI_hosp';


DROP TABLE haistate;
CREATE EXTERNAL TABLE haistate(
  state string,
  measurename string,
  measureid string,
  score float,
  footnote string,
  measurestart TIMESTAMP,
  measureend TIMESTAMP
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/HAI_state';

DROP TABLE hvbp_tps;
CREATE EXTERNAL TABLE hvbp_tps(
  providerid string,
  hospitalname string,
  address string,
  city string,
  hosstate string,
  zip string,
  county string,
  CPC_uw float,
  CPC_w float,
  PEC_uw float,
  PEC_w float,
  O_uw float,
  O_w float,
  E_uw float,
  E_w float,
  TPS float
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hvbp_tps';
