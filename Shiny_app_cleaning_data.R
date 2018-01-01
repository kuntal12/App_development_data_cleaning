library(shiny)
ui <- fluidPage(
  #input
  fileInput(inputId = "file", label = "Choose you dataset"),
  
  #output
  downloadButton("downloadData", "Download")
)


server <- function(input, output) {

  doit <- reactive({
    df <- read.csv(input$file$datapath)
    good <- complete.cases(df)
    df <- df[good, ]
    return(df)
  })

  output$downloadData <-  downloadHandler(
    
    filename <- function() {
      paste(gsub("\\.csv$","",input$file$name), "_clean.csv")
    },
    
    content <- function(file){
      write.csv(doit(), file)
    }
  )

}

shinyApp(ui = ui, server = server)