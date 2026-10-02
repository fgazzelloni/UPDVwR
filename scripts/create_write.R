## Create folders and .qmd files with code from another project
## write the yaml with the image linked from the raw page on github


## Create folders
library(tidyverse)
folders <- list.files("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2023")
files <- tibble(folders_dir =list.files(paste0("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2023/",
                  folders)))%>%
  filter(str_detect(folders_dir,".qmd"))%>%
  unlist()

# create folders and files
for (i in 1:length(folders)) {
  dir.create(file.path("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2023/posts2023/",
                       folders[i]),
             recursive = TRUE)
}

file.create(paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2023/posts2023/", 
                   folders,"/",folders,".qmd"))



## Write the YAML
tb <- tibble(folders=folders)%>%
  mutate(title=gsub("day[0-9]+_","",folders),
         title=gsub("-"," ",title),
         title=str_to_title(title),
         day=str_extract(folders,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)%>%
  mutate(date=paste0("2023-11-",day),
         image=paste0("https://raw.githubusercontent.com/Fgazzelloni/30DayMapChallenge/master/2023/",
                      folders,"/",folders,".png"))

text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'Welcome to #30DayMapChallenge 2023 day",tb$day,"'"),
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



file_path <- paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2023/posts2023/", 
                      tb$folders,"/",tb$folders,".qmd")


## Write the code
for (i in 1:length(folders)) {
  file_path_origin <- paste0("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2023/", 
                      tb$folders,"/",tb$folders,".qmd")
  image=paste0("image: ",
             paste0("'",tb$image,"'"))
  contents <- readLines(file_path_origin[i],-1L)
  newcontent <- c(contents[1:4],image[i],contents[6:length(contents)])
  writeLines(newcontent, file_path[i])
}




## Substitute images for with github raw address (2022)
folders22 <- list.files("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2022/posts2022")
files22 <- tibble(folders_dir =list.files(paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2022/posts2022/",
                                               folders22)))%>%
  filter(str_detect(folders_dir,".qmd"))%>%
  unlist()


tb22 <- tibble(folders=folders22)%>%
  mutate(title=gsub("day[0-9]+_","",folders),
         title=gsub("-|_"," ",title),
         title=str_to_title(title),
         day=str_extract(folders,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)%>%
  mutate(image=paste0("https://raw.githubusercontent.com/Fgazzelloni/30DayMapChallenge/master/2022/",
                      folders,"/",folders,".png"))


tb22


for (i in 1:length(folders22)) {
  file_path_origin <- paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2022/posts2022/", 
                             tb22$folders,"/",tb22$folders,".qmd")
  image=paste0("image: ",
               paste0("'",tb22$image,"'"))
  contents <- readLines(file_path_origin[i],-1L)
  newcontent <- c(contents[1:4],image[i],contents[6:length(contents)])
  writeLines(newcontent, file_path_origin[i])
}


## Delete all .png
file.remove(paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2022/posts2022/", 
       tb22$folders,"/",tb22$folders,".png"))



####################################
## Substitute images for with github raw address (2021)
folders21 <- list.files("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2021/posts2021")
files21 <- tibble(folders_dir =list.files(paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2021/posts2021/",
                                                 folders21)))%>%
  filter(str_detect(folders_dir,".qmd"))%>%
  unlist()


folders21_2 <- list.files("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2021")
files21_2 <- tibble(folders_dir =list.files(paste0("~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2021/",
                                                 folders21)))%>%
  filter(str_detect(folders_dir,".png|.jpeg|.jpg|.gif"))%>%
  unlist()



tb21_2 <- tibble(folders=folders21)%>%
  mutate(title=gsub("day[0-9]+_","",folders),
         title=gsub("-|_"," ",title),
         title=str_to_title(title),
         day=str_extract(folders,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)%>%
  mutate(image=paste0("https://raw.githubusercontent.com/Fgazzelloni/30DayMapChallenge/master/2021/",
                      folders,"/",files21_2))


tb21_2[2,4]


for (i in 1:length(folders21)) {
  file_path_origin <- paste0("~/Documents/R/R_general_resources/UPDVwR/mapchallenges/cases2021/posts2021/", 
                             tb21$folders,"/",tb21$folders,".qmd")
  image=paste0("image: ",
               paste0("'",tb21$image,"'"))
  contents <- readLines(file_path_origin[i],-1L)
  newcontent <- c(contents[1:4],image[i],contents[6:length(contents)])
  writeLines(newcontent, file_path_origin[i])
}


## Delete all .png
path_to_folders21 <- list.dirs("~/Documents/R/R_general_resources/EDA_and_maps/UPDVwR/mapchallenges/cases2021/posts2021")

files21<- list.files(path_to_folders21)
images21 <- tibble(files21=files21)%>%
  filter(str_detect(files21,".png|.JPG|.gif|.jpeg"))

file.remove(paste0(path_to_folders21[-1],"/",images21$files21))



## update code from original repo
dir <- "~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2023/"
path <- list.files(dir)
path  
files <- list.files(paste0(dir,path))
files
codes <- tibble(files=files)%>%
  filter(str_detect(files,".qmd")) %>%
  mutate(folders=paste0(dir,path),
         full_path=paste0(folders,"/",files),
         day=str_extract(files,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)
codes  %>%View
## read updv contents
updv_dir<- "~/Documents/R/R_general_resources/EDA_and_maps/UPDVwR/mapchallenges/cases2023/posts2023/"
updv_path <- list.files(updv_dir)
updv_files <- list.files(paste0(updv_dir,updv_path))
updv_codes <- tibble(files=updv_files)%>%
  mutate(folders=paste0(updv_dir,updv_path),
         full_path=paste0(folders,"/",files),
         day=str_extract(files,"[0-9]+"),
         day=as.integer(day))%>%
  arrange(day)

  
# original_contents <- readLines(codes$full_path[12],-1L)
# updv_contents <- readLines(updv_codes$full_path[12],-1L)
# newcontent <- c(updv_contents[1:11],original_contents[12:length(original_contents)])
# writeLines(newcontent, updv_codes$full_path[12])

# update code from original repo
for (i in 1:30) {
  original_contents <- readLines(codes$full_path[i],-1L)
  updv_contents <- readLines(updv_codes$full_path[i],-1L)
  newcontent <- c(updv_contents[1:11],original_contents[12:length(original_contents)])
  writeLines(newcontent, updv_codes$full_path[i])
}  



