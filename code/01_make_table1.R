here::i_am("code/01_make_table1.R")

data <- readRDS(
  file = here::here("data/derived_data/data_clean.rds")
)

library(gtsummary)
param=2

table_one <- data |>
  # Recode SEX variable to labels
  dplyr::mutate(SEX = ifelse(SEX == 1, "Female", "Male")) |>
  dplyr::mutate(DIABETES = ifelse(DIABETES == 1, "Diabetic", "Non-Diabetic")) |>
  # Recode CLASSIFICATION_FINAL variable to labels
  dplyr::mutate(CLASIFFICATION_FINAL = ifelse(CLASIFFICATION_FINAL == 1, "COVID", "NO COVID")) |>
  # Create summary table
  select("SEX", "PATIENT_TYPE", "AGE", "OBESITY", "TOBACCO", "DIABETES", "RENAL_CHRONIC", "Death") |>
  tbl_summary(by = DIABETES, digits=list(everything() ~ param)) |>
  add_overall() |>
  add_p()

saveRDS(
  table_one,
  file = here::here("output/table_1.rds")
)
