##Prepare Data##
library(readr)
library(tidyverse)
library(xlsx)
setwd("/Users/Desktop")

av_enrolled <- read.csv(file = "plan_attributes.csv")
crosswalk <- read.csv(file = "crosswalk.csv")
plans_hix <- read.csv(file = "plans.csv")
oep_puf <- read.csv(file = "oep_puf.csv")

plans_hix <- plans_hix %>%
  select(PLANID, ST, AREA, METAL, PREMI27) %>%
  filter(METAL == c("Bronze", "Silver", "Gold")) %>%
  rename(
    plan_id = PLANID,
    state = ST,
    area = AREA,
    metal = METAL,
    premium = PREMI27
  )

oep_puf <- oep_puf %>%
  select(Cnsmr, Brnz, Slvr, Gld, APTC_Cnsmr, CSR_Cnsmr_73,
         CSR_Cnsmr_87, CSR_Cnsmr_94, State_Abrvtn, Cnty_FIPS_Cd) %>%
  rename(
    total_consumers = Cnsmr, 
    aptc_consumers = APTC_Cnsmr,
    silver_73 = CSR_Cnsmr_73,
    silver_87 = CSR_Cnsmr_87,
    silver_94 = CSR_Cnsmr_94,
    fips = Cnty_FIPS_Cd,
    state = State_Abrvtn,
    bronze = Brnz,
    silver = Slvr,
    gold = Gld
  )

av_enrolled <- av_enrolled %>%
  select(StateCode, StandardComponentId, MetalLevel, AVCalculatorOutputNumber) %>%
  rename(
    state = StateCode,
    plan_id = StandardComponentId, 
    metal = MetalLevel,
    actuarial_value = AVCalculatorOutputNumber
    )

plans_hix_low <- plans_hix %>%
  group_by(area, metal) %>%
  mutate(premium == min(premium)) %>%
  filter(premium != FALSE)

crosswalk <- merge(crosswalk, oep_puf, by = "fips")

#Upload Libraries
library(readr)
library(naniar)

#Import File
setwd("/Users/Desktop")
impute_file <- read.csv(file = "premiums_to_impute.csv")

#Replace 1s with NAs
impute_file <- impute_file %>%
  mutate(AV.Bronze = na_if(AV.Bronze, 1.0000000)) %>%
  mutate(AV_Silver = na_if(AV_Silver, 1.0000000)) %>%
  mutate(AV_Gold = na_if(AV_Gold, 1.0000000))
  
#Impute with Mean
impute_file <- impute_file %>%
  group_by(STATE) %>%
  mutate(AV.Bronze = ifelse(is.na(AV.Bronze), mean(AV.Bronze, na.rm = TRUE), AV.Bronze)) %>%
  mutate(AV_Silver = ifelse(is.na(AV_Silver), mean(AV_Silver, na.rm = TRUE), AV_Silver)) %>%
  mutate(AV_Gold = ifelse(is.na(AV_Gold), mean(AV_Gold, na.rm = TRUE), AV_Gold))
  
#Remove NaNs:
impute_file <- impute_file %>%
  replace_with_na(replace = list(x = "NaN"))
  
#Export CSV:
write.csv(impute_file, "premium_impute_file.csv")
