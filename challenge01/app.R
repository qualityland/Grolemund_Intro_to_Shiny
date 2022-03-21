## app.R ##
library(shiny)
library(shinyWidgets)
library(bs4Dash)
library(shinycssloaders)
library(processmapR)
library(processanimateR)
library(eventdataR)



ui <- dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    width = 0
  ),
  dashboardBody(
    tags$head(
      tags$script(
        "$(function() {
              $('[data-card-widget=\"maximize\"]').on('click', function() {
                setTimeout(function() {
                  var isMaximized = $('html').hasClass('maximized-card');
                  if (isMaximized) {
                    $('#process').css('height', '100%');
                  } else {
                    $('#process').css('height', '100%');
                  }
                }, 300);
                $('#process').trigger('resize');
              });
            });
            "
      )
    ),
    
    fluidRow(
      tabBox(
        id = "Box one",
        height = "79.0vh",
        maximizable = T,
        title = p("", div(style = "position: absolute; right: 35px; top: 3px;",
                          dropdownButton(icon = icon("cog"), 
                                         size = "default",
                                         circle = F,
                                         tooltip = F,
                                         label= "", 
                                         right = T,
                                         width ="250px",
                                         radioButtons("duration",
                                                      "Animation Speed",
                                                      c("Slow" = 600,
                                                        "Medium" = 300,
                                                        "Fast" = 90),
                                                      selected = 300)
                                         )
                          )
                  ),
        tabPanel(
          title = "Tab one",
          align  = "center",
          withSpinner(
            processanimaterOutput("process", height = "76.5vh"), type=6)
        ),
        tabPanel(
          title = "Tab two",
        )
      ),
      tabBox(
        id = "Box two",
        height = "79.0vh",
        maximizable = T,
        tabPanel(
          title = "Tab three",
        )
      )
    )
  )
)

server <- function(input, output) { 
  observe({
    myMap <- process_map(patients, render = F)
    myGraph = animate_process(patients,
                              myMap,
                              duration = as.numeric(input$duration),
                              initial_state = "paused")
    output$process <- renderProcessanimater(myGraph)
  })
}

shinyApp(ui, server)