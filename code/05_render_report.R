library(here)

here::i_am("code/05_render_report.R")

rmarkdown::render(
  here::here("reports/Group11_COVID_Final_Report.Rmd")
)
