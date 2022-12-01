library(tidyverse)
library(readxl)

data <- "~/GitHub/Data Class I/data-2-final-project/data"

# Download
discipline <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/metrics/misconduct_report_police_and_expulsion_thru_eoy_2022_school_level.xlsx"
file.discipline <- str_c(data, "/discipline.xlsx")
download.file(discipline, file.discipline, method = "curl")

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
  download.file(race[i], str_c(data, "/race", yrs[i], ".xls"), method = "curl")
  download.file(lepsed[i], str_c(data, "/lepsed", yrs[i], ".xls"), method = "curl")
}

# Cleaning
setwd(data)
discipline <- read_xlsx("discipline.xlsx", sheet = "School Level Behavior Data")
discipline <- discipline %>% filter(`Time Period` == "EOY")
discipline <- discipline[c(1, 4, 6, 10, 29)]
names(discipline) <- c("id", "year", "misconducts", "suspensions", "expelled")

schoolyrs <- c("2021-2022", "2020-2021", "2019-2020", "2018-2019", "2017-2018", "2016-2017", "2015-2016", "2014-2015", "2013-2014")

race_names <- c("id", "total", "white", "african_american", "hispanic", "asian")

racedata <- c()
for(i in c(1:4, 6)) {
  racedata[[i]] <- read_xls(str_c("race", yrs[i], ".xls"), sheet = "Schools", skip = 1)
  racedata[[i]] <- racedata[[i]][c(2, 4, 5, 7, 13, 17)]
  names(racedata[[i]]) <- race_names
  racedata[[i]] <- racedata[[i]][-c(1),]
  racedata[[i]]$year <- schoolyrs[i]
}

for(i in 5) {
  racedata[[i]] <- read_xls(str_c("race", yrs[i], ".xls"), sheet = "Schools", skip = 1)
  racedata[[i]] <- racedata[[i]][c(1, 4, 5, 7, 13, 17)]
  names(racedata[[i]]) <- race_names
  racedata[[i]] <- racedata[[i]][-c(1),]
  racedata[[i]]$year <- schoolyrs[i]
}

for(i in 7:9) {
  racedata[[i]] <- read_xls(str_c("race", yrs[i], ".xls"), sheet = "Educational Units", skip = 1)
  racedata[[i]] <- racedata[[i]][c(2, 4, 5, 7, 13, 17)]
  names(racedata[[i]]) <- race_names
  racedata[[i]] <- racedata[[i]][-c(1),]
  racedata[[i]]$year <- schoolyrs[i]
}

race_all <- data.frame()
for(i in 1:9) {
  race_all <- rbind(race_all, racedata[[i]])
}

lepsed_names <- c("id", "total", "bilingual", "sped", "econ")

lepseddata <- c()
for(i in 1:6) {
  lepseddata[[i]] <- read_xls(str_c("lepsed", yrs[i], ".xls"), sheet = "Schools", skip = 1)
  lepseddata[[i]] <- lepseddata[[i]][c(2, 4, 5, 7, 9)]
  names(lepseddata[[i]]) <- lepsed_names
  lepseddata[[i]] <- lepseddata[[i]][-c(1),]
  lepseddata[[i]]$year <- schoolyrs[i]
}

for(i in 7) {
  lepseddata[[i]] <- read_xls(str_c("lepsed", yrs[i], ".xls"), sheet = "All Schools", skip = 1)
  lepseddata[[i]] <- lepseddata[[i]][c(2, 4, 5, 7, 9)]
  names(lepseddata[[i]]) <- lepsed_names
  lepseddata[[i]] <- lepseddata[[i]][-c(1),]
  lepseddata[[i]]$year <- schoolyrs[i]
}

for(i in 8:9) {
  lepseddata[[i]] <- read_xls(str_c("lepsed", yrs[i], ".xls"), sheet = "All Schools", skip = 1)
  lepseddata[[i]] <- lepseddata[[i]][c(1, 4, 5, 7, 9)]
  names(lepseddata[[i]]) <- lepsed_names
  lepseddata[[i]] <- lepseddata[[i]][-c(1),]
  lepseddata[[i]]$year <- schoolyrs[i]
}

lepsed_all <- data.frame()
for(i in 1:9) {
  lepsed_all <- rbind(lepsed_all, lepseddata[[i]])
}

lepsedrace <- inner_join(lepsed_all, race_all, by = c("id", "year", "total"))
merged <- inner_join(lepsedrace, discipline, by = c("id", "year"))

merged[is.na(merged)] <- 0