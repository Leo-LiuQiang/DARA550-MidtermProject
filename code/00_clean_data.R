here::i_am ("code/00_clean_data.R")

#Reading in data
# Read data from a CSV file
covid <- read.csv (file = here::here("data/raw_data", "covid_sub.csv"))

#clean the data
library(dplyr)
library(labelled)


#Step 1: create the death variable 
covid$Death <- ifelse(!is.na(covid$DATE_DIED), 1, 0)

##Step 2: Create a dataset without any missing variables

# Create a new dataset Finalcovid with rows that have complete data for specified variables
Finalcovid <- covid[complete.cases(covid$AGE, covid$SEX, covid$PATIENT_TYPE, 
                                   covid$DIABETES, covid$OBESITY, covid$RENAL_CHRONIC, 
                                   covid$TOBACCO, covid$CLASIFFICATION_FINAL), ]



Finalcovid <- Finalcovid %>%
  mutate(SEX = ifelse(SEX == "female", 1, 2),
         PATIENT_TYPE = ifelse(PATIENT_TYPE == "hospitalization", 1, 0),
         DIABETES = ifelse(DIABETES == "Yes", 1, 0),
         OBESITY = ifelse(OBESITY == "Yes", 1, 0),
         RENAL_CHRONIC= ifelse(RENAL_CHRONIC == "Yes", 1, 0),
         TOBACCO = ifelse(TOBACCO == "Yes", 1, 0),
         CLASIFFICATION_FINAL= ifelse(CLASIFFICATION_FINAL <= 3, 1, 0))

dim(Finalcovid)

Finalcovid <- subset(Finalcovid, CLASIFFICATION_FINAL==1)
dim(Finalcovid)




var_label(Finalcovid) <- list(
  PATIENT_TYPE= "Hospitilization Status (%Yes)",
  RENAL_CHRONIC= "Renal Failure (% Yes)",
  TOBACCO= "Tobacco Use (% Yes)",
  CLASIFFICATION_FINAL= "COVID19 Diagnosis (% Yes)",
  Death= "Did patient die (% Yes)?",
  DIABETES= "Diabetes (% Yes)",
  OBESITY= "Obesity (% Yes)",
  AGE= "Age (years)",
  SEX= "Sex"
)

saveRDS(
  Finalcovid, 
  file = here::here("data/derived_data/data_clean.rds")
)

#Note or reminder for self: You can save R objects as .rds files using the saveRDS() 
#function, and you can load .rds files back into R using the readRDS() function.
#This format is particularly useful when you want to save data in a way that is 
#independent of the R environment and can be easily transferred between different R 
#sessions or shared with others.
