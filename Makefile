Group11_COVID_Final_Report.html: code/05_render_report.R \
	Group11_COVID_Final_Report.Rmd
	Rscript code/05_render_report.R


data/derived_data/data_clean.RDS: code/00_clean_data.R
	Rscript code/00_clean_data.R

output/table_1.RDS: code/01_make_table1.R data/derived_data/data_clean.RDS
	Rscript code/01_make_table1.R


#WeiWei please update makefile here for your descriptive analysis

output/Model1_table.RDS: code/03_model1_covid_death.R data/derived_data/data_clean.RDS
	Rscript code/03_model1_covid_death.R

#Manju please update makefile here for Model 2