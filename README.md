# DATA 500 Midterm Project Group 11
##### Project Title: Examining Risk Factors for Adverse COVID-19 Outcomes

##### Group Members: Khadijah Abdallah, Leo Liu, Manju Ramakrishnan, Sarina Abrishamcar, Weiwei Wu

##### Data: Covid-19

##### Description: information regarding covid-19 cases in Mexico (20% of the full data set)

##### Source: https://datos.gob.mx/busca/dataset/informacion-referente-a-casos-covid-19-en-mexico 

# Team Designations and Coding Element

#### Lead:  Leo Liu
#### Role includes:
- Maintaining config file
- Creating and maintaining the GitHub repository
- Merging/testing/correcting codes  
- Combining reports
- README file

#### Coder 1: Khadijah Abdallah
#### Role includes:
- Data cleaning: this will involved complete case analysis, and perhaps recoding categorical variables if needed Write-up of the introduction 
- Output: Make a table 1: Descriptive Analysis of age, sex, co-morbidities, COVID-19 outcomes (death, hospital admissions, etc)
- Child report 1 (with the description of results)
- code/00_clean_data.R
- code/01_make_table1.R

#### Coder 2: Weiwei Wu 
#### Role includes:
- Data distributions for continuous and categorical variables 
- Child report 2  (with the description of results)
- 02_descriptive_analysis.R

#### Coder 3: Sarina Abrishamcar 
#### Role includes:
- Model 1: Research question: Are those with Diabetes at increased risk for COVID-19 death?
- Covariates: age, sex, renal failure, obesity, Tobacco 
- Model type: logistic regression
- Output: Parameter estimates and 95% CI  (table 2) 
- Child report 3 (with the description of results)
- 03_model1_covid_death.R

#### Coder 4: Manju Ramakrishnan 
#### Role includes:
- Model 2: Research question: Are those with Diabetes at increased risk for COVID-19 complications (i.e. Hospital admission)?
- Covariates: age, sex, renal failure, obesity, Tobacco 
- Model type: logistic regression 
- Output: parameter estimates and 95% CI (table 3)
- Child report 4 (with the description of results)
- LR: death~ diabetes + covids status + coveriates
- 04_model2_hospital_admissions.R
- 05_render_report.R

# Organizational Structure
- README.md (Project and repository description)
- config.yml (config for the format of the report)
- .gitignore (files not be uploaded to GitHub)
- Makefile
- /reports (Report .Rmd and final output are stored here)
- /data (Original dataset and cleaned data are stored here)
- /code (Each coders’ code are saved here)
- /output (Each coders’ output are saved here)

# How to reproduce the report in terminal
- cd "/workpath_where_files_stored"
- make clean (clean all outputs)
- make install (will automatically install all packages needed)
- make (will automatically generate all results and report)

# Customized version of report
## Using config to change output format in terminal
- export WHICH_OUTPUT=pdf (Eligible choices: default (html), pdf, tufte)
- make

## Change self-selected parameters in rmarkdown
- You can change params in reports/Group11_COVID_Final_Report.Rmd to change format of tables.