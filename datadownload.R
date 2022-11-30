datadest <- "~/GitHub/Data Class I/data-2-final-project/data"

lepsed <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_lepsped_20thday_2023.xlsx"
race <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/demographics/demographics_racialethnic_20thday_2023.xlsx"
college <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/metrics/metrics_collenrollpersist_schoollevel_20222.xlsx"
freshmen <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/metrics/metrics_fot_schoollevel_2022-1.xlsx"
discipline <- "https://www.cps.edu/globalassets/cps-pages/about-cps/district-data/metrics/misconduct_report_police_and_expulsion_thru_eoy_2022_school_level.xlsx"

file.lepsed <- str_c(datadest, "/lepsed.xlsx")
file.race <- str_c(datadest, "/race.xlsx")
file.college <- str_c(datadest, "/college.xlsx")
file.freshmen <- str_c(datadest, "/freshmen.xlsx")
file.discipline <- str_c(datadest, "/discipline.xlsx")


download.file(lepsed, file.lepsed)
download.file(race, file.race)
download.file(college, file.college)
download.file(freshmen, file.freshmen)
download.file(discipline, file.discipline)