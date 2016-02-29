Provider ID	average_rank	Hospital Name501311	       	1	EAST ADAMS RURAL HOSPITAL161378	       	2	MERCY MEDICAL CENTER-DYERSVILLE53302	       	3.5	CHILDREN'S HOSP OF LOS ANGELES53309	       	3.5	MILLER CHILDREN'S HOSPITAL233300		3.5	CHILDREN'S HOSPITAL OF MICHIGAN463301		3.75	PRIMARY CHILDRENS HOSPITAL393303		4	CHILDREN'S HOSPITAL OF PHILADELPHIA173300		4.67	CHILDREN'S MERCY  SOUTH63301		5	CHILDRENS HOSPITAL COLORADO503300		5	SEATTLE CHILDREN'S HOSPITAL


The top hospital in the nation is East Adams Rural Hospital. The above table shows the top 10. 



I chose 6 tables in the section of Appendix A to compare hospitals. These are:

Timely_and_Effective_Care_-_Hospital
Outpatient_Imaging_Efficiency_-_Hospital
Complications_-_Hospital
Healthcare_Associated_Infections_-_Hospital
Readmissions_and_Deaths_-_Hospital
hvbp_tps_05_28_2015 (total performance score)

There are a total of 4458 hospitals in the hospital general information table. These six tables cover a large proportion of the hospitals, compared to other tables such as HOSPITAL_QUARTERLY_QUALITYMEASURE_IPFQR_HOSPITAL. 

In each table there are a number of measures listed under each hospitals. One problem is that these measures have very different scales. For example, the measure “Deaths among Patients with Serious Treatable Complications after Surgery” ranges from 100 to above, while the measure “Collapsed lung due to medical treatment” mostly stay under 1. If I took a simple average among these measures, some measures would matter more than others.
To prevent these differences to bias the results, I first ranked the hospitals within each measure based on the scores for that measure, with hospitals that have the better scores getting lower rank number (higher ranks).

This is similar to the rank-sum test which is  used to combat distributions that are not normal. But instead of summing the within-measure ranks for each hospital, I took an average. This is because many hospitals have missing data in these tables. Summing the rank would penalize the hospitals that have less score measures available.  

These average-rank scores were calculated for each hospitals and then used to compare the hospitals. Hospitals with lower average rank number have higher quality measures. 







