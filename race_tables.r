library(tidyverse)
library(haven)
library(magrittr)
file <- read_dta(file = "usa.dta")
race <- file



###Switch ethnicities to 1 and 0###
race$asian <- ifelse(race$racasian == 2, 1, 0)
race$black <- ifelse(race$racblk == 2, 1, 0)
race$pacific_islander <- ifelse(race$racpacis == 2, 1, 0)
race$white <- ifelse(race$racwht == 2, 1, 0)
race$other <- ifelse(race$racother == 2, 1, 0)

###Select columns###
race <- race %>%
  select(statefip, sex, age, hispan, asian, black, pacific_islander,
         white, other, hinscaid)

###Make Medicaid 1 and 0###
race1 <- race
race1$medicaid <- ifelse(race$hinscaid == 2, 1, 0)

###For ethnicity, 1 = no and 2 = yes###
race2 <- race1 %>%
  mutate(hispanic = 
           asian == 0 &
           black == 0 &
           pacific_islander == 0 &
           white == 0 &
           other == 0 &
           hispan == 1) %>%
race3$hispanic <- as.integer(race3$hispanic == "TRUE")
counthisp <- length(which(race3$hispanic == 1))

###Recode ethnicity to exclude Hispanic###
race4 <- race3 %>%
  mutate(asian1 = hispanic == 0 & asian == 1) %>%
  mutate(black1 = hispanic == 0 & black == 1) %>%
  mutate(pacific1 = hispanic == 0 & pacific_islander == 1) %>%
  mutate(white1 = hispanic == 0 & white == 1) %>%
  mutate(other1 = hispanic == 0 & other == 1)

race4 <- race4 %>%
  select(asian1, black1, pacific1, white1, other1, statefip, sex, age,
         hinscaid)

###Switch from True to False
race5 <- race4
cols <- sapply(race5, is.logical)
race5[,cols] <- lapply(race5[,cols], as.numeric)

###Change Medicaid and Sex to 1 and 0###
race5$medicaid <- ifelse(race5$hinscaid==2, 1, 0)
race5$gender <- ifelse(race5$sex == 2, 1, 0)
