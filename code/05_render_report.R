library(here)
here::i_am("code/05_render_report.R")

library(config)
config <- config::get(
  config = Sys.getenv("WHICH_OUTPUT")
)
output_format <- config$output

library(rmarkdown)
rmarkdown::render(
  here::here("reports/Group11_COVID_Final_Report.Rmd"),
  output_format = output_format
)
