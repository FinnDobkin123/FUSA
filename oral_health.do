/*/*/*/*/* Tabulate Sex and Age */*/*/*/*/


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


/*/*/*/*/* Defining Hispanic Variable */*/*/*/*/

/* Upload file */
use "/Users/finndobkin/Desktop/usa_00009.dta"

/* Rename variables */
rename stateicp state
rename gp group_quarters
rename hispan hispanic
rename hinscaid medicaid_user

/* Slim down file */
 keep year sample serial state gq race hispanic medicaid_user
 
/* Code strings */
encode race, gen(ethnic)
encode hispanic, gen(hispanic)
encode state, gen(state)
 
 /* Recode race */
gen ethnicity = 1 if race == "white" 
replace ethnicity = 2 if race == "Black/African American/Negro"
replace ethnicity = 3 if race == "American Indian or Alaska Native"
replace ethnicity = 4 if race == "Chinese" | "Japanese" | "Other Asian or Pacific Islander"
replace ethnicity = 5 if race == "Other race, nec" | "Two major races" | "Three or more major races"

 
/* Code strings */
encode race, gen(ethnic)
encode hispanic, gen(hispanic)
encode state, gen(state)
 
