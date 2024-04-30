install.packages("shiny")
library(shiny)
library(ggplot2)
library(tidyverse)
library(jsonlite)

data <- readRDS("../data/412000.rds")

ui = fluidPage(
  titlePanel("Veiklos kodas 412000"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("company", "Pasirinkite įmonę", choices = unique(data$name))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session){
  output$plot <- renderPlot({
    req(input$company)  # Užtikriname, kad yra pasirinkta įmonė
    filtered_data <- data %>%
      filter(name == input$company)
    
    ggplot(filtered_data, aes(x = ym(month), y = avgWage, color = name)) +
      geom_point(shape = 3, size = 4) +  # Pasirenkame zvaigždutės formą ir dydį
      geom_line(size = 2) +
      theme_classic() +
      scale_color_manual(values = c("blue")) +
      labs(x = "Month", y = "Vidutinis atlyginimas", color = "Įmonė") +
      theme(panel.background = element_rect(fill = "lightyellow"),  # Pakeičia fono spalvą
            legend.position = "none")  # Paslepia legendą
  })
}

shinyApp(ui=ui, server=server)
