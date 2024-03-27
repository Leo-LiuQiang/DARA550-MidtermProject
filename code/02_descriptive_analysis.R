library(tidyverse)
library(ggplot2)
library(gtsummary)
library(patchwork)
library(ggeasy)
library(cowplot)
library(colorspace) 

here::i_am("code/02_descriptive_analysis.R")

covid <- readRDS(file = here::here("data/derived_data/data_clean.rds"))

# Preprocess -------------------------------------------------------------------
col_names <- c("Death", "DIABETES", "PATIENT_TYPE","SEX", "OBESITY", "RENAL_CHRONIC", "TOBACCO")
covid[, col_names] <- lapply(covid[, col_names], as.factor)

# Outcome variable -------------------------------------------------------------
death_barplt <- ggplot(data = covid) + 
  geom_bar(aes(x = Death, y = ..count../sum(..count..),fill = Death)) + 
  ggtitle("Distribution of Death Status") + 
  ylab("Proportion") + 
  scale_y_continuous(limits = c(0, 1), labels = scales::percent) + 
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_x_discrete(labels = c("No", "Yes")) +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1") 

png(filename = here::here("output", "descriptive_outcome_barplt.png"),
    width = 1000, height = 700, res = 200)
death_barplt
dev.off()

# Continuous Variable ----------------------------------------------------------
## Histograms  -------------------
### Histogram: Age by Death
age_by_death_histplt <- ggplot(data = covid) + 
  geom_histogram(aes(x = AGE, fill = Death), binwidth=1) + 
  ylab("Count") + 
  xlab("Age") +
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1")
age_by_death_histplt 

## Bar plots -------------------
### Box: Age by Diabetes grouped by Death
age_by_diabetes_death_boxplt <- ggplot(data = covid) + 
  geom_boxplot(aes(y=AGE, x=DIABETES, fill=Death)) + 
  xlab("Diabetes") +
  ylab("Age") +
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1") +
  scale_x_discrete(labels = c("No", "Yes"))
age_by_diabetes_death_boxplt 

### Box: Age by patient type
age_by_patient_boxplt <- ggplot(data = covid) + 
  geom_boxplot(aes(y = AGE, x = PATIENT_TYPE, fill = PATIENT_TYPE)) + 
  ylab("Age") +
  xlab("Patient Type") +
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Patient Type", labels = c("Return Home", "Hospitalization"), palette = "Pastel1") +
  theme(legend.position = "none") +
  scale_x_discrete(labels = c("Return Home", "Hospitalization"))
age_by_patient_boxplt 

# Save the figure
png(filename = here::here("output", "descriptive_countinuous_plt.png"),
    width = 3000, height = 700, res = 200)
age_by_death_histplt + age_by_diabetes_death_boxplt  + age_by_patient_boxplt
dev.off()

# Categorical Variables --------------------------------------------------------
## Pie charts -------------------
categorical_names <- c("DIABETES", "PATIENT_TYPE","SEX", "OBESITY", "RENAL_CHRONIC", "TOBACCO")

# Set titles for pie charts 
pie_title <- data.frame(SEX = "Sex", DIABETES = "Diabetes", OBESITY = "Obesity", 
                        RENAL_CHRONIC = "Renal Failure", TOBACCO = "Tobacco Use",
                        PATIENT_TYPE = "Patient Type")

# Set labels for pie charts 
pie_df <- covid[, (colnames(covid) %in% categorical_names)] %>%
  mutate(SEX = ifelse(SEX == 1, "Female", "Male"),
       PATIENT_TYPE = ifelse(PATIENT_TYPE == 1, "Hospitalization", "Return Home"),
       DIABETES = ifelse(DIABETES == 1, "Yes", "No"),
       OBESITY = ifelse(OBESITY == 1, "Yes", "No"),
       RENAL_CHRONIC= ifelse(RENAL_CHRONIC == 1, "Yes", "No"),
       TOBACCO = ifelse(TOBACCO == 1, "Yes", "No"))

# Function for plotting pie charts
Pie_fn <- function(col){
  pie_df_sub <- as.data.frame(table(pie_df[col]))
  colnames(pie_df_sub)[1] <- "levels"
  ggplot(pie_df_sub, aes(x = "", y = Freq, fill = levels)) +
    geom_bar(width = 1, stat = "identity") +
    coord_polar("y", start = 0) +
    theme_void() + 
    ggeasy::easy_center_title() +
    labs(title = pie_title[1, col], fill = "") +
    scale_fill_brewer(palette = "Pastel1")
} 

pie_list <- lapply(colnames(pie_df), Pie_fn)

# Save the figure
png(filename = here::here("output", "descriptive_categorical_pieplt.png"),
    width = 3000, height = 700, res = 200)
plot_grid(plotlist = pie_list, align = "vh", nrow = 2)
dev.off()

## Bar plots -------------------
### Box: Diabetes by death
diabeties_by_death_barplt <- ggplot(data = covid, aes(x=DIABETES, fill = Death)) + 
  geom_bar(aes(y = (..count../tapply(..count.., ..x.. ,sum)[..x..])), position="dodge") + 
  ylab("Proportion") +
  xlab("Diabetes") +
  scale_y_continuous(limits = c(0, 1), labels = scales::percent) + 
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1") +
  scale_x_discrete(labels = c("No", "Yes"))
diabeties_by_death_barplt

### Box: Renal failure by death
renal_by_deathl_barplt <- ggplot(data = covid, aes(x=RENAL_CHRONIC, fill = Death)) + 
  geom_bar(aes(y = (..count../tapply(..count.., ..x.. ,sum)[..x..])), position="dodge") + 
  ylab("Proportion") +
  xlab("Renal Failure") +
  scale_y_continuous(limits = c(0, 1), labels = scales::percent) + 
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1") +
  scale_x_discrete(labels = c("No", "Yes"))
renal_by_deathl_barplt

### Box: Patient type by death
patient_by_death_barplt <- ggplot(data = covid, aes(x=PATIENT_TYPE, fill = Death)) + 
  geom_bar(aes(y = (..count../tapply(..count.., ..x.. ,sum)[..x..])), position="dodge") + 
  ylab("Proportion") +
  xlab("Patient Type") +
  scale_y_continuous(limits = c(0, 1), labels = scales::percent) + 
  theme_classic() + 
  ggeasy::easy_center_title() +
  scale_fill_brewer(name = "Death Status", labels = c("No", "Yes"), palette = "Pastel1") +
  scale_x_discrete(labels = c("Return Home", "Hospitalization"))
patient_by_death_barplt

# Save the figure
png(filename = here::here("output", "descriptive_categorical_barplt.png"),
    width = 3000, height = 700, res = 200)
diabeties_by_death_barplt + renal_by_deathl_barplt + patient_by_death_barplt
dev.off()



