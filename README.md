# Data and Programming for Public Policy II - R Programming: Final Project
# Ezra Serrins

## Demographics and Discipline at CPS Schools

### Research Question

**Research Question:** Are discipline outcomes (specifically misconduct reports, suspensions, and expulsions) at CPS schools explained by school demographic data (specifically, the racial and ethnic demographic information for students and the proportion of students who are low income, special education, or bilingual)? If so, how?

### Data Collection and Processing

All data comes from the Chicago Public Schools [District Data page](https://www.cps.edu/about/district-data/). Specifically, demographic data comes from the [demographics page](https://www.cps.edu/about/district-data/demographics/) and discipline data comes from the [metrics page](https://www.cps.edu/about/district-data/demographics/). All shapefiles used in creating plots are sourced from the [City of Chicago Data Portal](https://data.cityofchicago.org/). Specific shapefiles imported are an outline of the city of Chicago and the locations of CPS schools in each school year documented. The data covers all school years between 2021-2022 and 2013-2014 (including 2020-2021 which was heavily impacted by COVID-19) because these are the years for which school level discipline data is available. All attendance data is based on attendance on the 20th day of school, which is used because it gives four weeks for any early in the year fluctuations in attendance (e.g. students enrolling late or being moved away from a school and to another school).

For demographics, the number of students at each school who are White, African American, Asian, and Hispanic (non-White) was recorded for each school year and then these numbers were converted into a proportion of students at a school. Additionally, the number of students who are low income (defined as being at 185% of the Federal Poverty Level, as this was the old free and reduced lunch metric), special education, or bilingual was recorded for each school and each school year and then converted into a proportion of students at a school. Whether a school is elementary (K-8) or high (9-12) school was also recorded. For the discipline data, three outcomes (number of misconducts, number of suspensions (both in and out of school), and number of students expelled) were observed for each school and school year at the end of the school year and then these numbers were converted into a number of the incident per capita (this number was not a proportion because the data used was the total number of each type of event rather than the number of students involved in each event). Charter school data was excluded as only expulsion data is recorded in the data. All other schools were included.

The datasets were then merged so that all data for each year and school appear in the same row, along with simple features information about the location of that school. The data was then subsetted based on whether a school was an elementary or middle school that way the correct data could be displayed on each plot. 

### Plots and Maps

Two interactive Shiny maps were created based on the data (one for elementary school and one for high school). Each map gives the user an option for school year, demographic, and outcome they would like to view data about. For each school that exists in the selected school year, a point is plotted on the map, with the size of the point being determined by the number of the disciplinary outcome per capita at that school and the color of that point being determined by the proportion of that school's students belonging to the specified demographic. Several insights are clear from  looking at these plots. First, it is far easier to have segregated elementary schools than high schools because these schools are smaller. For example, the highest proportion of white students at an elementary school is over 0.8 whereas the highest proportion of white students at a high school is below 0.5, as can be seen on the plot keys. Second, some racial and ethnic demographic trends are visible from the map alone. Dots representing elementary schools on the South and West side with higher proportions of Black students are noticeably larger for all disciplinary outcomes. Third, city-wide trends in income are visible on the elementary and high school maps, with noticeably lower proportions of low income students at schools on the North Side (especially along the lake front) and at particular schools on the South and Northwest Sides. 

Two static plots were also created based on the data (one for elementary school and one for high school). In these plots, the aggregate attendance by demographic for all elementary and high schools over time was plotted. There were two noticeable differences in the trends between these two graphs. First, the proportion of white students at all CPS high schools was consistently lower than the proportion of white students at all CPS elementary schools. Second, over time there was a slight negative trend in the proportion of Black students and a slight positive trend in the proportion of Hispanic (non-White) students at elementary schools. For high schools, this trend is far more pronounced, with the proportion of Hispanic (non-White) students surpassing the proportion of Black students at high schools in the 2020-2021 school year (the year most impacted by the COVID-19 pandemic). A trend noticeable in both plots is a significant decline in the proportion of Black students enrolled during the 2020-2021 school year which is not observed for other race/ethnic groups.

### Text Analysis

As part of this project, I conducted textual analysis on two [Chalkbeat Chicago](https://chicago.chalkbeat.org/) (a non-profit online journalism source specializing in Education policy) articles. [One article](https://chicago.chalkbeat.org/2022/8/16/23308391/chicago-public-schools-police-school-resource-officers-restorative-justice-whole-school-safety-plan) covered ongoing discussions and progress in removing police officers from CPS high schools. [The other](https://chicago.chalkbeat.org/2022/9/28/23377565/chicago-school-enrollment-miami-dade-third-largest) covered the decline in CPS enrollment this year, which saw the District's enrollment drop behind Miami-Dade County's schools to the fourth highest in the country. These two articles were selected becuase they were related to the broader analysis' themes of disciplinary policy and school enrollments. Unlike the broader analysis, these two articles did not emphasize demographic information in their reporting, with demographics not appearing in the top 20 most used non-stop words for either article.

### Data Analysis

After having processed and plotted the data, I performed linear regressions which used the demographic information about each school to predict each discipline outcome. For each outcome, I ran six regressions: one utilizing all demographic information to explain the discipline outcome, one each utilizing the proportion of low income, special education, and bilingual students to explain the discipline outcome, one utilizing only the race and ethnicity demographic information to explain the discipline outcome, and one utilizing only the school year to explain the discipline outcome. For all three discipline outcomes, the general trends of the results were similar. 

First, the regressions utilizing only race and ethnicity factors indicated that a higher proportion of Black students predicted higher per capita amounts of each discipline outcome at a school. This was followed by Hispanic (non-White) students, White students, and then Asian students. None of these findings were statistically significant, but the finding was consistent for all three discipline outcomes. 

Second, the regressions explaining the discipline outcomes based on the proportion of the student body that was low income and proportion of the students that were special education consistently predicted that a higher proportion of the student body being low income predicts higher per capita amounts of each discipline outcome at a school. The coefficient for this was statistically significant for all three discipline outcomes. There is evidence that schools with a higher proportion of low income and special education students are more likely to have worse discipline outcomes. 

Third, the regressions explaining discipline outcomes based on the proportion of the student body that is bilingual consistently predicted that more bilingual students predicts lower per capita discipline outcomes. The coefficient for this was statistically significant for all three discipline outcomes. There is evidence that schools with a higher proportion of low income and special education students are more likely to have better discipline outcomes. 

Finally, the regressions explaining discipline outcomes based on the school year generally show that each type of discipline outcome has become less frequent over time. An exception to this for all three discipline outcomes is that there were more predicted discipline incidents based on school year in the 2021-2022 school year than the 2020-2021 school year, likely due to the return to in-person schooling. However, the predicted discipline incidents based on school year in 2021-2022 was still lower than in the 2018-2019 school year (the most recent school year not impacted by the COVID-19 pandemic) for all discipline outcome. These coefficients were statistically significant (at a significance level of 5%) for all years for expulsions and suspensions and statistically significant for the 2019-2020, 2020-2021, and 2021-2022 school years for misconduct reports. Broadly, this indicates that district wide changes has improved discipline outcomes between the 2013-2014 school year and the present. 

### Future Research

While these results are helpful in predicting discipline outcomes based on some factors, there is still further research to be done. If better data was available, better conclusions could be made with data about the demographics of students who are suspended, have misconduct reports, or are expelled, rather than just demographic information about the schools. Better data would also provide information about Charter schools. Future resarch could attempt to separate schools based on type (i.e. neighborhood, selective enrollment, Charter schools, etc.) and determine if this explains any of the variation in discipline outcomes.