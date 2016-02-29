#!/bin/bash
## as root

cd /home/w205/hospital_compare

## replace spaces in file names with underscore “_”
for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done

##change file names


mv hvbp_hcahps_05_28_2015.csv surveys_responses.csv 
mv Hospital_General_Information.csv hospitals.csv
mv Timely_and_Effective_Care_-_Hospital.csv effective_care.csv
mv Readmissions_and_Deaths_-_Hospital.csv readmissions.csv
mv Measure_Dates.csv Measures.csv
mv Outpatient_Imaging_Efficiency_-_Hospital.csv  imaging_hosp.csv
mv Outpatient_Imaging_Efficiency_-_State.csv  imaging_state.csv
mv HOSPITAL_QUARTERLY_QUALITYMEASURE_IPFQR_HOSPITAL.csv  quarterlymeasure_hosp.csv
mv HOSPITAL_QUARTERLY_QUALITYMEASURE_IPFQR_STATE.csv  quarterlymeasure_state.csv
mv Readmissions_and_Deaths_-_State.csv readmissions_state.csv
mv HCAHPS_-_Hospital.csv hcahps_assess.csv
mv Healthcare_Associated_Infections_-_Hospital.csv HAI_hosp.csv
mv Healthcare_Associated_Infections_-_State.csv HAI_state.csv
mv Timely_and_Effective_Care_-_State.csv effectivecare_state.csv
mv hvbp_tps_05_28_2015.csv hvbp_tps.csv
mv HOSPITAL_QUARTERLY_QUALITYMEASURE_IPFQR_STATE.csv ipfqr_state.csv

## put files in HDFS
su - w205
hdfs dfs -mkdir /user/w205/hospital_compare 

hdfs dfs -mkdir /user/w205/hospital_compare/hospital_info
hdfs dfs -put hospital_compare/hospitals.csv /user/w205/hospital_compare/hospital_info

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put hospital_compare/effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put hospital_compare/readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put hospital_compare/Measures.csv /user/w205/hospital_compare/measures

hdfs dfs -mkdir /user/w205/hospital_compare/survey
hdfs dfs -put hospital_compare/surveys_responses.csv /user/w205/hospital_compare/survey

hdfs dfs -mkdir /user/w205/hospital_compare/imaginghosp
hdfs dfs -put hospital_compare/imaging_hosp.csv /user/w205/hospital_compare/imaginghosp

hdfs dfs -mkdir /user/w205/hospital_compare/imagingstate
hdfs dfs -put hospital_compare/imaging_state.csv /user/w205/hospital_compare/imagingstate

hdfs dfs -mkdir /user/w205/hospital_compare/quarterlymeasure_hosp
hdfs dfs -put hospital_compare/quarterlymeasure_hosp.csv /user/w205/hospital_compare/quarterlymeasure_hosp

hdfs dfs -mkdir /user/w205/hospital_compare/quarterlymeasure_state
hdfs dfs -put hospital_compare/quarterlymeasure_state.csv /user/w205/hospital_compare/quarterlymeasure_state

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_state
hdfs dfs -put hospital_compare/readmissions_state.csv  /user/w205/hospital_compare/readmissions_state

hdfs dfs -mkdir /user/w205/hospital_compare/hcahps_assess
hdfs dfs -put hospital_compare/hcahps_assess.csv  /user/w205/hospital_compare/hcahps_assess


hdfs dfs -mkdir /user/w205/hospital_compare/complication_hosp
hdfs dfs -put hospital_compare/Complications_-_Hospital.csv  /user/w205/hospital_compare/complication_hosp

hdfs dfs -mkdir /user/w205/hospital_compare/complication_state
hdfs dfs -put hospital_compare/Complications_-_State.csv  /user/w205/hospital_compare/complication_state

hdfs dfs -mkdir /user/w205/hospital_compare/HAI_hosp
hdfs dfs -put hospital_compare/HAI_hosp.csv  /user/w205/hospital_compare/HAI_hosp

hdfs dfs -mkdir /user/w205/hospital_compare/HAI_state
hdfs dfs -put hospital_compare/HAI_state.csv  /user/w205/hospital_compare/HAI_state

hdfs dfs -mkdir /user/w205/hospital_compare/effective_state
hdfs dfs -put hospital_compare/effectivecare_state.csv  /user/w205/hospital_compare/effective_state

hdfs dfs -mkdir /user/w205/hospital_compare/hvbp_tps
hdfs dfs -put hospital_compare/hvbp_tps.csv  /user/w205/hospital_compare/hvbp_tps
