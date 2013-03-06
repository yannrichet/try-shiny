library(shiny)
library(shinyIncubator)

shinyUI(pageWithSidebar(  
  headerPanel("Title"),
  sidebarPanel(
    tags$head(
      tags$script(src="http://ajax.cdnjs.com/ajax/libs/json2/20110223/json2.js"),
      tags$script(type='text/javascript', src='http://code.jquery.com/jquery-1.8.3.js'),
      
      tags$script(type='text/javascript',src="http://handsontable.com/jquery.handsontable.js"),
      tags$script(type='text/javascript' ,src="http://handsontable.com/lib/bootstrap-typeahead.js"),
      tags$script(type='text/javascript', src="http://handsontable.com/lib/jQuery-contextMenu/jquery.contextMenu.js"),
      tags$script(type='text/javascript' ,src="http://handsontable.com/lib/jQuery-contextMenu/jquery.ui.position.js"),
      
      tags$script(src = "shiny-handsontable.js"),
      
      tags$link(rel="stylesheet" ,type="text/css" ,href="http://handsontable.com/lib/jQuery-contextMenu/jquery.contextMenu.css"),
      tags$link(rel="stylesheet" ,type="text/css", href="http://handsontable.com/jquery.handsontable.css")
    ),
    uiOutput("example")
    ),
  
  mainPanel(
    tableOutput(outputId="result")
  )
))