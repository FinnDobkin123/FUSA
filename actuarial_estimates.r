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
