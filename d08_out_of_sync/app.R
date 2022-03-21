library(shiny)

ui <- fluidPage(
  sliderInput("num", "Choose a number", 1, 100, 50),
  plotOutput("hist"),
  verbatimTextOutput("smy")
)
server <- function(input, output) {
  output$hist <- renderPlot({
    # 1st call
    hist(rnorm(input$num))
  })
  output$smy <- renderPrint({
    # 2nd call - histogram and summary are out of sync!!!
    summary(rnorm(input$num))
  })
}
shinyApp(ui = ui, server = server)