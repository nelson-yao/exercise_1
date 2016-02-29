Delaware and Vermont are among the top states in terms of healthcare facilities. 
The query to the final score table “stateresult” produces the following results:

State	Average_rank score

The score of each states were calculated in similar way to the average rank score for the hospitals, except for the readmission measure table and complication measure table.  For these two tables, within each measure, I subtract the number of hospitals worse than national average from the number better than national average. I then divide this difference by the total number of hospitals that have available information, which is number better+number same+number worse. These scores are then averaged within each hospital. 

This approach helps compare the states at an aggregate level, taking into account of hospitals that have good qualities and those that are bad. 
