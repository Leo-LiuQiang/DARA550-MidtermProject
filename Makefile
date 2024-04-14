Group11_COVID_Final_Report.html: code/05_render_report.R \
	reports/Group11_COVID_Final_Report.Rmd Exploratory_data_analysis Models
	Rscript code/05_render_report.R

.PHONY: Exploratory_data_analysis
Exploratory_data_analysis: data/derived_data/data_clean.RDS \
	output/table_1.RDS \
	output/descriptive_outcome_barplt.png output/descriptive_countinuous_plt.png output/descriptive_categorical_pieplt.png output/descriptive_categorical_barplt.png

.PHONY: Models
Models: output/Model1_table.RDS \
	output/Model2_table.RDS

data/derived_data/data_clean.RDS: code/00_clean_data.R
	Rscript code/00_clean_data.R

output/table_1.RDS: code/01_make_table1.R data/derived_data/data_clean.RDS
	Rscript code/01_make_table1.R


output/descriptive_outcome_barplt.png output/descriptive_countinuous_plt.png output/descriptive_categorical_pieplt.png output/descriptive_categorical_barplt.png: data/derived_data/data_clean.rds
	Rscript code/02_descriptive_analysis.R


output/Model1_table.RDS: code/03_model1_covid_death.R data/derived_data/data_clean.RDS
	Rscript code/03_model1_covid_death.R


output/Model2_table.RDS: code/04_model2_hospital_admissions.R data/derived_data/data_clean.RDS
	Rscript code/04_model2_hospital_admissions.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f reports/*.html && rm -f output/*RDS && rm -f reports/*.pdf

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"