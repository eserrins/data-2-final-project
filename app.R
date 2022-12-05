library(tidyverse)
library(ggplot2)
library(plotly)
library(sf)
library(shiny)
library(rlang)

ui <- fluidPage(
  fluidRow(
    column(6, h2("Elementary School")),
    column(6, h2("High School"))
  ),
  fluidRow(
    column(6, 
      selectInput(
        inputId = "factor_ES", 
        label = "Demographic",
        choices = c(
          "White",
          "Black", 
          "Hispanic (non-white)", 
          "Asian", 
          "Bilignual", 
          "Special Education", 
          "Low Income"
        )
      ),
    ),
    column(6, 
      selectInput(
        inputId = "factor_HS", 
        label = "Display based on what demographic data",
        choices = c(
          "White",
          "Black", 
          "Hispanic (non-white)", 
          "Asian", 
          "Bilignual", 
          "Special Education", 
          "Low Income"
        )
      ),
    )
  ),
  fluidRow(
    column(6, 
      selectInput(
        inputId = "outcome_ES", 
        label = "Type of Discipline",
        choices = c(
          "Misconducts", 
          "Suspensions", 
          "Expulsions"
        )
      )
    ),
    column(6, 
      selectInput(
        inputId = "outcome_HS", 
        label = "What type of Discipline outcome?",
        choices = c(
          "Misconducts", 
          "Suspensions", 
          "Expulsions"
        )
      )
    )
  ),
  fluidRow(
    column(6, 
      selectInput(
        inputId = "year_ES", 
        label = "Year",
        choices = schoolyrs
      )
    ),
    column(6, 
      selectInput(
        inputId = "year_HS", 
        label = "What year data do you wish to see",
        choices = schoolyrs
      )
    )
  ),
  fluidRow(
    column(6,
      plotlyOutput("elem")
    ),
    column(6,
      plotlyOutput("high")
    )
  ),
  fluidRow(
    column(6, plotOutput("elem_static")),
    column(6, plotOutput("high_static"))
  )
)

server <- function(input, output) {
  #Source: https://rstudio-pubs-static.s3.amazonaws.com/646750_c7b8cb026d154c3f810b6c15c5a41258.html#341_Make_the_table_interactive
  
  yearInput_ES <- reactive({
    merged_ES %>% filter(year == input$year_ES)
  })
  
  factorInput_ES <- reactive({
    switch(input$factor_ES,
           "White" = yearInput_ES()$white_pct,
           "Black" = yearInput_ES()$african_american_pct, 
           "Hispanic (non-white)" = yearInput_ES()$hispanic_pct, 
           "Asian" = yearInput_ES()$asian_pct, 
           "Bilignual" = yearInput_ES()$bilingual_pct, 
           "Special Education" = yearInput_ES()$sped_pct, 
           "Low Income" = yearInput_ES()$econ_pct
           )
  })
  
  outcomeInput_ES <- reactive({
    switch(
      input$outcome_ES,
      "Misconducts" = yearInput_ES()$misconducts_percap, 
      "Suspensions" = yearInput_ES()$suspensions_percap, 
      "Expulsions" = yearInput_ES()$expelled_percap
      )
  })
  
  yearInput_HS <- reactive({
    merged_HS %>% filter(year == input$year_HS)
  })
  
  factorInput_HS <- reactive({
    switch(input$factor_HS,
           "White" = yearInput_HS()$white_pct,
           "Black" = yearInput_HS()$african_american_pct, 
           "Hispanic (non-white)" = yearInput_HS()$hispanic_pct, 
           "Asian" = yearInput_HS()$asian_pct, 
           "Bilignual" = yearInput_HS()$bilingual_pct, 
           "Special Education" = yearInput_HS()$sped_pct, 
           "Low Income" = yearInput_HS()$econ_pct
    )
  })
  
  outcomeInput_HS <- reactive({
    switch(
      input$outcome_HS,
      "Misconducts" = yearInput_HS()$misconducts_percap, 
      "Suspensions" = yearInput_HS()$suspensions_percap, 
      "Expulsions" = yearInput_HS()$expelled_percap
    )
  })
  
  output$elem <- renderPlotly({
    schools_ES <- ggplot() +
      geom_sf(city, mapping = aes(geometry = geometry)) +
      geom_sf(yearInput_ES(), mapping = aes(geometry = geometry, color = factorInput_ES(), size = outcomeInput_ES())) +
      guides(color = guide_colorbar(title = input$factor_ES)) +
      theme(legend.position = "bottom") +
      theme_void() +
      labs(
        title = "Elementary Schools"
      )
    
    ggplotly(schools_ES)
  })
  
  output$high <- renderPlotly({
    schools_HS <- ggplot() +
      geom_sf(city, mapping = aes(geometry = geometry)) +
      geom_sf(yearInput_HS(), mapping = aes(geometry = geometry, color = factorInput_HS(), size = outcomeInput_HS())) +
      guides(color = guide_colorbar(title = input$factor_HS)) +
      theme(legend.position = "bottom") +
      theme_void() +
      labs(
        title = "High Schools"
      )
    
    ggplotly(schools_HS)
  })
  
  merged_yrs_ES <- merged_ES %>% 
    group_by(year) %>% 
    summarise(
      white = mean(white_pct),
      asian = mean(asian_pct),
      african_american = mean(african_american_pct),
      hispanic = mean(hispanic_pct)
    ) %>% 
    pivot_longer(
      white:hispanic,
      names_to = "race",
      values_to = "pct"
    )
  
  output$elem_static <- renderPlot({
    ES_plot <- ggplot(merged_yrs_ES, aes(x = year, y = pct, color = race)) +
    geom_point() + 
    labs(
      title = "CPS Elementary School Attendance Over Time",
      x = "School Year",
      y = "Proportion"
    ) +
    scale_color_discrete(
      name = "Race/Ethnicity", 
      labels = c("Black", "Asian", "Hispanic (non-White)", "White")
    )
    
    ES_plot
  })
  
  merged_yrs_HS <- merged_HS %>% 
    group_by(year) %>% 
    summarise(
      white = mean(white_pct),
      asian = mean(asian_pct),
      african_american = mean(african_american_pct),
      hispanic = mean(hispanic_pct)
    ) %>% 
    pivot_longer(
      white:hispanic,
      names_to = "race",
      values_to = "pct"
    )
  
  output$high_static <- renderPlot({
    HS_plot <- ggplot(merged_yrs_HS, aes(x = year, y = pct, color = race)) +
    geom_point() + 
    labs(
      title = "CPS High School Attendance Over Time",
      x = "School Year",
      y = "Proportion"
    ) +
    scale_color_discrete(
      name = "Race/Ethnicity", 
      labels = c("Black", "Asian", "Hispanic (non-White)", "White")
    )
    
    HS_plot
  })
}

shinyApp(ui, server)

setwd("~/GitHub/Data Class I/data-2-final-project/images")

merged_yrs_ES <- merged_ES %>% 
  group_by(year) %>% 
  summarise(
    white = mean(white_pct),
    asian = mean(asian_pct),
    african_american = mean(african_american_pct),
    hispanic = mean(hispanic_pct)
  ) %>% 
  pivot_longer(
    white:hispanic,
    names_to = "race",
    values_to = "pct"
  )

ES_plot <- ggplot(merged_yrs_ES, aes(x = year, y = pct, color = race)) +
  geom_point() + 
  labs(
    title = "CPS Elementary School Attendance Over Time",
    x = "School Year",
    y = "Proportion"
  ) +
  scale_color_discrete(
    name = "Race/Ethnicity", 
    labels = c("Black", "Asian", "Hispanic (non-White)", "White")
  )

ggsave("ES_plot.png", plot = ES_plot, device = "png")

merged_yrs_HS <- merged_HS %>% 
  group_by(year) %>% 
  summarise(
    white = mean(white_pct),
    asian = mean(asian_pct),
    african_american = mean(african_american_pct),
    hispanic = mean(hispanic_pct)
  ) %>% 
  pivot_longer(
    white:hispanic,
    names_to = "race",
    values_to = "pct"
  )

HS_plot <- ggplot(merged_yrs_HS, aes(x = year, y = pct, color = race)) +
  geom_point() + 
  labs(
    title = "CPS High School Attendance Over Time",
    x = "School Year",
    y = "Proportion"
  ) +
  scale_color_discrete(
    name = "Race/Ethnicity", 
    labels = c("Black", "Asian", "Hispanic (non-White)", "White")
  )

ggsave("HS_plot.png", plot = HS_plot, device = "png")