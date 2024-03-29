
#Model 2: Are those with Diabetes at increased risk for COVID-19 complications (i.e. Hospital admission)?
#Covariates: age, sex, renal failure, obesity, tobacco

library(gtsummary)

here::i_am("code/04_model2_hospital_admissions.R")

data <- readRDS(
  file = here::here("data/derived_data/data_clean.rds")
)

#Model construction
model2 <-glm(PATIENT_TYPE ~ DIABETES + OBESITY + AGE +
              SEX + RENAL_CHRONIC + TOBACCO, 
            family = binomial(link="logit"), data=data)

#Table
model2_reg_table <-
  tbl_regression(model2, exponentiate = T, data=data) %>%
  add_global_p()%>%
  modify_caption("**Risk of Hospitalization**")

model2_reg_table

#Saving Model2 table as RDS file
saveRDS(
  model2_reg_table,
  file = here::here("output/Model2_table.RDS")
)
