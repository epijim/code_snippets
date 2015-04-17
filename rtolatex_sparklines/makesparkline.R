###############################################################################
## Load some test data
  url <- 'https://gist.githubusercontent.com/epijim/8819934/raw/6c76df80eb095065a9ce0fa4b8f94410ad528fed/college_data.csv'
  library(RCurl)
  data <- getURL(url, ssl.verifypeer=FALSE)
  data <- read.csv(text = data)

###############################################################################
## My function

jb_CutIntoBins <- function(variable,bins=10,width=6){
  temp_ranges <- range(variable, na.rm=T) # Get range
  temp_breaks <- seq(temp_ranges[1],temp_ranges[2], # From first to last
                     length=(bins+1)) # Number of bins
  temp_cut <- as.data.frame(cut(variable,
                                breaks=temp_breaks,labels=F))
  # Set up dataset
  temp_data <- data.frame(bin=1:bins,
                          value=c(NA)
  )
  temp_cut <- as.data.frame(table(temp_cut),stringsAsFactors=F)
  temp_cut$temp_cut <- as.numeric(temp_cut$temp_cut)
  # Fill dataset
  for(i in 1:bins){
    tryCatch(
      if(i==temp_data[i,1]){
        temp_data[i,2] <- temp_cut[temp_cut$temp_cut==i,2]
      },error=function(e){})
  }
  # Make sparkline
  binlocations <- seq(0,1,length=10)
  opening <- paste0("\\newcommand{\\sparkage}{\\begin{sparkline}{",width,"}")
  close <- "\\end{sparkline}}"
  for(i in 1:nrow(temp_data)){
    ifelse(is.na(temp_data[i,2]),
           middle[i] <- paste0(" \\sparkspike ",binlocations[i]," ",0),
           middle[i] <- paste0(" \\sparkspike ",binlocations[i]," ",
                               temp_data[i,2]/max(temp_data$value,na.rm=T))
    )
  }
  output <- c(opening,middle,close)
  cat(output,sep="\n")
}

###############################################################################
## Test it

  hist(data$Wine_budget, breaks=10)

  jb_CutIntoBins(data$Wine_budget)

  