library(shiny)
library(RJSONIO)
library(plyr)

jsonToList <- function(json) {
  jsonAsList <- fromJSON(json, simplify = StrictCharacter, nullValue = "")
	return(jsonAsList)
}
jsonToDataFrame <- function(json) {
	jsonAsList <- jsonToList(json)
	jsonAsDataFrame <- ldply(jsonAsList,function(x) as.data.frame(t(unlist(x))))
	#f <- function(jsonList) function(nm) unlist(lapply(jsonList, "[[", nm), use.names=FALSE) 
	#jsonAsDataFrame <- as.data.frame(Map(f(jsonAsList), names(jsonAsList[[1]]))) 
	return(jsonAsDataFrame)
}


#   ["2010", 5, 2905, 2867, 412, 5284]
print.line <- function(line) {
  return(paste('["',paste(line,collapse='","'),'"]',sep=''))
}

#   ["", "Maserati", "Mazda", "Mercedes", "Mini", "Mitsubishi"],
#   ["2009", 0, 2941, 4303, 354, 5814],
#   ["2012", 2, 2422, 5399, 776, 4151]
print.data <- function(data) {
  str = print.line(names(data))
  for (i in 1:nrow(data))
    str = paste(str,print.line(data[i,]),sep=",\n")
  return(str)
}


#   <script>
#     var data = [
#       ["", "Maserati", "Mazda", "Mercedes", "Mini", "Mitsubishi"],
#       ["2009", 0, 2941, 4303, 354, 5814],
#       ["2012", 2, 2422, 5399, 776, 4151]
#       ];
#   
#   $('#example').handsontable({
#     data: data,
#     minRows: 5,
#     minCols: 6,
#     minSpareRows: 1,
#     autoWrapRow: true,
#     colHeaders: true,
#     contextMenu: true
#   });
#   
#   $('.ver').html($('#example').data('handsontable').version);
#   </script>
script.data <- function(data,name) {
  return(gsub("__name__",name,paste(sep="\n",
                                    "<div id='__name__' class='dataTable handsontable shiny-bound-input'><script>var __name__ = [",
                                    print.data(data),
                                    "    ];",
                                    "$('#__name__').handsontable({",
                                    "  data: __name__,",
                                    "  minRows: 5,",
                                    "  minCols: 2,",
                                    "  minSpareRows: 1,",
                                    "  autoWrapRow: true,",
                                    #  "  colHeaders: true,",
                                    "  contextMenu: true,",
                                    "  onChange: function() { $('#__name__').trigger('change');}", 
                                    "});",
                                    
                                    "$('.ver').html($('#__name__').data('handsontable').version);</script></div>")))
}

# Minimal Custom
shinyServer(function(input, output) {
  
  output$result <- renderTable({
    jsonToDataFrame(input$example_div)
  })
  
  output$example <- renderUI({
    return(HTML(script.data(cars,"example_div")))
  })
  
})
  

