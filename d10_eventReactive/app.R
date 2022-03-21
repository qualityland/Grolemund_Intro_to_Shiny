library(shiny)

ui <- fluidPage(
  sliderInput("num", "Slide Me", 1, 100, 50),
  actionButton("go", "Update"),
  plotOutput("hist"),
  verbatimTextOutput("sum")
)

server <- function(input, output) {
  # data changes when action button is pressed
  data <- eventReactive(input$go, {rnorm(input$num)})
  output$hist <- renderPlot({
    hist(data())   
  })
  output$sum <- renderPrint({
    summary(data())
  })
}

shinyApp(ui = ui, server = server)