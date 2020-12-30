use "/Users/finndobkin/Desktop/usa_00008.dta"

/* Relabel variables */
 label var year "Year"
 label var sample "2019 American Community Survey"
 label var statefip "State"
 label var sex "Gender"
 label var race "Race"
 label var hinscaid "Insurance Status"
 
 /* Generate Dummy variables */
 gen gender = 1 if sex == "female"
 replace gender = 0 if sex == "male"
 
 /* Generate Age Cohorts */
gen age_cohort = 1 if age >= 0 & age <= 9
replace age_cohort = 2 if age >= 10 & age <= 19
replace age_cohort = 3 if age >= 20 & age <= 29
replace age_cohort = 4 if age >= 30 & age <= 39
replace age_cohort = 5 if age >= 40 & age <= 49
replace age_cohort = 6 if age >= 50 & age <= 59
replace age_cohort = 7 if age >= 60 & age <= 69
replace age_cohort = 8 if age >= 70 & age <= 79
replace age_cohort = 9 if age >= 80 & age <= 89
replace age_cohort = 10 if age >=90 & age <= 99
 
/* Tabulations */
collapse (count) hinscaid, by (age_cohort state)
