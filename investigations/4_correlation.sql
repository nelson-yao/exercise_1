###find correlation between hospital rank score and patient survey response_percent
select corr(rankscore, surveyscore)
from survey_scores;
