#Model 1: Are those with diabetes at increased risk for COVID-19 death?
#Covariates: age, sex, renal failure, obesity, tobacco

library(here)
library(gtsummary)
setwd("C:/Users/sarsa/OneDrive/Desktop/DATA550/DATA550-MidtermProject")
here::i_am("code/03_model1_covid_death.R")

data <- readRDS(
  file = here::here("data/derived_data/data_clean.rds")
)

model1<-glm(Death ~ DIABETES + OBESITY + AGE +
              SEX + RENAL_CHRONIC + TOBACCO,
            family = binomial(link="logit"), data=data)

model1_regression_table <- 
  tbl_regression(model1,exponentiate = T, include = c("DIABETES"),
                 list(DIABETES ~ "Diabetes")) |>
  add_global_p()

saveRDS(
  model1_regression_table,
  file = here::here("output/Model1_table.RDS")
)

