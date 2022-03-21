library(shiny)

ui <- fluidPage(
  sliderInput("num", "Slide Me", 1, 100, 50),
  actionButton("norm", "Normal Data"),
  actionButton("unif", "Uniform Data"),
  plotOutput("hist"),
  verbatimTextOutput("sum")
)

server <- function(input, output) {
  # defaults for reactive values
  rv <- reactiveValues(data = rnorm(50))

    # normal distributed data
  observeEvent(input$norm, {rv$data <- rnorm(input$num)})

    # uniform distributed data
  observeEvent(input$unif, {rv$data <- runif(input$num)})

    # update histogram and summary
  output$hist <- renderPlot({hist(rv$data)})
  output$sum <- renderPrint({summary(rv$data)})
}

shinyApp(ui = ui, server = server)