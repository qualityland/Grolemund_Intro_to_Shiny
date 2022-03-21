library(shiny)

fluidPage(sliderInput(
    "num",
    "Choose a number",
    min = 1,
    max = 100,
    value = 50
),

plotOutput("hist"))
