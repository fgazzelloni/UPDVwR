# In this folder you'll find the scripts for 
# creating folders and files

# Setting the working directory
setwd(rstudioapi::getActiveProject())

## Create folders
library(tidyverse)
folders <- list.files("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2024")
files <- tibble(folders_dir =list.files(paste0("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2024/",
                                               folders)))%>%
  filter(str_detect(folders_dir,".qmd"))%>%
  unlist()

# create folders and files
# you don't need to create folders as it is done already
for (i in 1:length(folders)) {
  dir.create(file.path("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2024/posts2024/",
                       folders[i]),
             recursive = TRUE)
}

file.create(paste0("mapchallenges/cases2024/posts2024/", 
                   folders,"/",folders,".qmd"))



## Write the YAML
tb <- tibble(folders=folders)%>%
  mutate(title=gsub("day[0-9]+_","",folders),
         title=gsub("-"," ",title),
         title=str_to_title(title),
         day=str_extract(folders,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)%>%
  mutate(date=paste0("2024-11-",day),
         image=paste0("https://raw.githubusercontent.com/Fgazzelloni/30DayMapChallenge/master/2024/",
                      folders,"/",folders,".png"))

text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'Welcome to #30DayMapChallenge 2024 day",tb$day,"'"),
                    "\n",
                    "date: ",
                    paste0("'",tb$date,"'"),
                    "\n",
                    "image: ",
                    paste0("'",tb$image,"'"),
                    "\n",
                    "image-alt: ",
                    "''",
                    "\n",
                    "description: ",
                    "'Networks'",
                    "\n",
                    "output: ",
                    "html_document",
                    "\n",
                    "execute: ",
                    "\n ",
                    "  eval: ",
                    "false",
                    "\n",
                    "---")



file_path <- paste0("mapchallenges/cases2024/posts2024/", 
                    tb$folders,"/",tb$folders,".qmd")


## Write the code
for (i in 1:length(folders)) {
  file_path_origin <- paste0("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2024/", 
                             tb$folders,"/",tb$folders,".qmd")
  image=paste0("image: ",
               paste0("'",tb$image,"'"))
  contents <- readLines(file_path_origin[i],-1L)
  newcontent <- c(contents[1:4],image[i],contents[6:length(contents)])
  writeLines(newcontent, file_path[i])
}