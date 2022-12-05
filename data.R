library(tidyverse)
library(readxl)
library(sf)

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

merged$bilingual_pct <- merged$bilingual / merged$total
merged$sped_pct <- merged$sped / merged$total
merged$econ_pct <- merged$econ / merged$total
merged$white_pct <- merged$white / merged$total
merged$african_american_pct <- merged$african_american / merged$total
merged$hispanic_pct <- merged$hispanic / merged$total
merged$asian_pct <- merged$asian / merged$total

merged$misconducts <- as.numeric(merged$misconducts)
merged$suspensions <- as.numeric(merged$suspensions)
merged$expelled <- as.numeric(merged$expelled)
merged <- merged %>% drop_na() # The NA rows are Charter schools, which aren't a part of our question
merged$misconducts_percap <- merged$misconducts / merged$total
merged$suspensions_percap <- merged$suspensions / merged$total
merged$expelled_percap <- merged$expelled / merged$total

setwd("~/GitHub/Data Class I/data-2-final-project/schools")

schools <- c()
schools[[1]] <- read_csv("Chicago_Public_Schools_-_School_Locations_SY2122.csv")
schools[[2]] <- read_csv("Chicago_Public_Schools_-_School_Locations_SY2021.csv")
schools[[3]] <- read_csv("Chicago_Public_Schools_-_School_Locations_SY1920.csv")
schools[[4]] <- read_csv("School_Locations_1819.csv")
schools[[5]] <- read_csv("School_Locations_SY1718.csv")
schools[[6]] <- read_csv("CPS_School_Locations_1617.csv")
schools[[7]] <- read_csv("CPS_School_Locations_SY1516.csv")
schools[[8]] <- read_csv("CPS_School_Locations_SY1415.csv")
schools[[9]] <- read_csv("Units2013_14.csv")

schools_all <- data.frame()
for(i in c(1, 2, 7)) {
  colnames(schools[[i]])[6] <- "Y"
  colnames(schools[[i]])[7] <- "X"
}

for(i in 5:6) {
  colnames(schools[[i]])[10] <- "Y"
  colnames(schools[[i]])[11] <- "X"
}

schools[[4]] <- separate(schools[[4]], the_geom, into = c("point", "X", "Y"), sep = " ")
schools[[4]]$X <- gsub("[(]", "", schools[[4]]$X)
schools[[4]]$Y <- gsub("[)]", "", schools[[4]]$Y)

colnames(schools[[8]])[2] <- "School_ID"
colnames(schools[[9]])[1] <- "School_ID"
colnames(schools[[8]])[5] <- "Grade_Cat"
colnames(schools[[9]])[5] <- "Grade_Cat"

schools_all <- data.frame()
for(i in 1:9) {
  schools[[i]]$year <- schoolyrs[i]
  schools[[i]] <- schools[[i]] %>% select(X, Y, School_ID, year, Grade_Cat)
}

for(i in 1:9) {
  schools_all <- rbind(schools_all, schools[[i]])
}

colnames(schools_all)[3] <- "id"
schools_all$id <- as.character(schools_all$id)

merged <- inner_join(merged, schools_all, by = c("id", "year"))
merged <- st_as_sf(merged, coords = c("X", "Y"), crs = 4269)
merged$Grade_Cat[merged$Grade_Cat == "MS"] <- "ES"
merged_ES <- merged %>% filter(Grade_Cat == "ES")
merged_HS <- merged %>% filter(Grade_Cat == "HS")

setwd("~/GitHub/Data Class I/data-2-final-project")
unzip("cityboundary.zip")
city <- st_read("cityboundary.shp")
