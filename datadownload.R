library(readxl)

datadest <- "~/GitHub/Data Class I/data-2-final-project/data"

discipline <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/metrics/misconduct_report_police_and_expulsion_thru_eoy_2022_school_level.xlsx"
file.discipline <- str_c(datadest, "/discipline.xlsx")
download.file(discipline, file.discipline)

yrs <- 2021:2013

race <- c(
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2022_v10272021.xls", #2021
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2021_v10072020.xls", #2020
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2020.xls", #2019
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2019.xls", #2018
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2018.xls", #2017
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_2017.xls", #2016
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/fy16_student_racial_ethnic_report_20151023.xls", #2015
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/fy15_racial_ethnic_survey.xls", #2014
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/fy14_racial_ethnic_survey.xls" #2013
)
lepsed <- c(
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2022_v10272021.xls", #2021
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2021_v10072020.xls", #2020
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2020_10202020.xls", #2019
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2019_10202020.xls", #2018
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2018_10202020.xls", #2017
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2017_10202020.xls", #2016
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/lep_sped_frl_report_2016_20151023.xls", #2015
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_2015.xls", #2014
  "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/lep_iep_frl_report_2014.xls" #2013
)

for(i in 1:9) {
  download.file(race[i], str_c(datadest, "/race", yrs[i], ".xlsx"))
  download.file(lepsed[i], str_c(datadest, "/lepsed", yrs[i], ".xlsx"))
}
