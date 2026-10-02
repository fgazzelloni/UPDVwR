# scrap tidytuesday table info

# Load necessary packages
library(tidyverse)
# library(httr)
rawdata_2021 <- paste0("https://github.com/rfordatascience/tidytuesday/tree/master/data/2021")
# mydata_2021 <- paste0("https://github.com/Fgazzelloni/TidyTuesday/tree/main/data/2021")

table <- xml2::read_html(rawdata_2021)%>%
  rvest::html_node("table") %>% 
  rvest::html_table(header = TRUE)%>%
  select(Week,Date,Data)%>%
  mutate(name=abbreviate(Data, strict = TRUE, named = FALSE),
         w_n=ifelse(Week < 10,paste0(0,Week),Week))

tb <- table%>%
  mutate(subtitle=paste0("Welcome to TidyTuesday 2021 week ",Week),
         image=paste0("w",w_n,"_",gsub(" ","_",Data),".png"),
         folder_name=paste0("w",Week,"_",gsub(" ","_",Data)))%>%
  rename(title=Data)%>%
  select(Date,folder_name,title,subtitle,image)#%>%View


folder_name <- tb %>%
  select(folder_name)%>%
  unlist()

############################
# create just the folders that are needed
folder_name <- folder_name[13:52][!is.na(folder_name[13:52])]

tb <- tb[40:52,]
text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",tb$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",tb$Date,"'"),
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


# create folders and files
for (i in 1:length(folder_name)) {
  dir.create(file.path("tidytuesday/cases2021/posts2021a",
                       folder_name[i]),
             recursive = TRUE)
}
file.create(paste0("tidytuesday/cases2021/posts2021a/", 
                   folder_name,"/",folder_name,".qmd"))

# list.files("tidytuesday/cases2021/posts2021a")
file_names<- paste0(folder_name,".qmd")

# write THE YAMAL in each file (ONLY FOR NEW FILES)
# for (i in 1:length(file_names)) {
#   file_path <- paste0("tidytuesday/cases2021/posts2021a/", 
#                       folder_name,"/",
#                       file_names)
#   text <- text_full[i]
#   #print(text)
#   write(text, file = file_path[i], append = TRUE)
# }


######## add lines on top of existing file #############
path_to_my_files <- list.files(path="tidytuesday/cases2021/posts2021",full.names = T)
my_files <- list.files(path_to_my_files)
my_files_code_only <- my_files[str_detect(my_files,".R|.qmd|.rmd")]
my_files_code_only <- my_files_code_only[!str_detect(my_files_code_only,".png")]
my_file_code_2021 <- my_files_code_only[31:42]
folder_name <- list.files("tidytuesday/cases2021/posts2021")
folder_name2 <- folder_name[28:39]
length(my_file_code_2021)
length(folder_name2)
#############################################################
# write THE YAMAL on top of each file 
for (i in 1:length(file_names)) {
  file_path <- paste0("tidytuesday/cases2021/posts2021/", 
                      folder_name2,"/",
                      my_file_code_2021)
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  newcontents <- c(text,contents)
  writeLines(newcontents, file_path[i])
}

#### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### 

#### my contributions to 2022
# Load necessary packages
library(tidyverse)
# library(httr)
rawdata_2022 <-
paste0("https://github.com/rfordatascience/tidytuesday/tree/master/data/2022")

table <- xml2::read_html(rawdata_2022)%>%
  rvest::html_node("table") %>% 
  rvest::html_table(header = TRUE)%>%
  select(Week,Date,Data)%>%
  mutate(name=abbreviate(Data, strict = TRUE, named = FALSE),
         w_n=ifelse(Week < 10,paste0(0,Week),Week))

tb <- table%>%
  mutate(subtitle=paste0("Welcome to TidyTuesday 2022 week ",Week),
         image=paste0("w",w_n,"_",gsub(" ","_",Data),".png"),
         folder_name=paste0("w",Week,"_",gsub(" ","_",Data)))%>%
  rename(title=Data)%>%
  select(Date,folder_name,title,subtitle,image)#%>%View


path_to_my_files <- list.files(path="tidytuesday/cases2022/posts2022/",full.names = T)
my_files <- list.files(path_to_my_files)
my_files1 <- my_files[str_detect(my_files,".png")]
images_2022 <- my_files1[str_detect(my_files1,"w[0-9]")]


text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",tb$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",tb$Date,"'"),
                    "\n",
                    "image: ",
                    #images_2022,
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


######## add lines on top of existing file #############
path_to_my_files <- list.files(path="tidytuesday/cases2022/posts2022",
                               full.names = T)
my_files <- list.files(path_to_my_files)
my_files2 <- my_files[str_detect(my_files,".qmd")]
folder_name <- list.files("tidytuesday/cases2022/posts2022")
folder_name2 <- folder_name[!str_detect(folder_name,".yml")]
#############################################################
# write THE YAMAL on top of each file 
for (i in 1:length(my_files2)) {
  file_path <- paste0("tidytuesday/cases2022/posts2022/", 
                      folder_name2,"/",
                      my_files2)
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  newcontents <- c(text,contents)
  writeLines(newcontents, file_path[i])
}


file_path <- "tidytuesday/cases2022/posts2022/w9_stations/w9_stations.qmd"
text <- text_full[9]
contents <- readLines(file_path[i],-1L)
newcontents <- c(text,contents)
writeLines(newcontents, file_path[i])

######## my contribution 2023
# add text on top of the old YAML

raw_url <- paste0("https://github.com/rfordatascience/tidytuesday")
library(tidyverse)
table <- xml2::read_html(raw_url)%>%
  rvest::html_node("table") %>% 
  rvest::html_table(header = TRUE)%>%
  #select(Week,Data)%>%
  mutate(name=abbreviate(Data, strict = TRUE, named = FALSE),
         folder_name=paste0("w",Week,"_",name),
         w_n=ifelse(Week < 10,paste0(0,Week),Week)) %>%
  mutate(subtitle=paste0("Welcome to TidyTuesday 2023 week ",Week))%>%
  rename(title=Data)%>%
  select(Date,folder_name,title,subtitle)

tb <- table[1:28,]
#tb%>%View

text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",tb$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",tb$Date,"'"),
                    "\n",
                    "image: ",
                    paste0("'",tb$folder_name,".png","'"),
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
# write THE YAMAL on top of each file 
for (i in 1:28) {
  file_path <- paste0("tidytuesday/cases2023/posts2023/", 
                      tb$folder_name,"/",
                      paste0(tb$folder_name,".qmd"))
  text <- text_full[i]
  lines <- readLines(file_path[i],-1L)
  end_doc <- lines[-c(1:11)]
  newcontents <- c(text,end_doc)
  writeLines(newcontents, file_path[i])
}


#### #### #### #### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### #### #### #### 
#chartchallenges

path <- list.dirs("chartchallenges/cases2023/posts2023")
all_files <- list.files(path)
files <- all_files[str_detect(all_files,".qmd")]
images <- all_files[str_detect(all_files,".png|.gif")]
folders <- gsub(".qmd","",files)
date <- seq.Date(as.Date("2023-04-01"),as.Date("2023-04-30"),
                 "days")

tb <- tibble(folders,files,images)%>%
  mutate(id=str_extract(folders,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  cbind(date)%>%
  mutate(title=folders,
         subtitle=paste0("Welcome to #30DayChartChallenge 2022 day ",id))

text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",tb$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",tb$date,"'"),
                    "\n",
                    "image: ",
                    paste0("'",tb$images,"'"),
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



# write THE YAMAL on top of each file 
for (i in 1:length(tb$folders)) {
  file_path <- paste0("chartchallenges/cases2022/posts2022/", 
                      tb$folders,"/",
                      tb$files)
  text <- text_full[i]
  lines <- readLines(file_path[i],-1L)
  newcontents <- c(text,lines)
  writeLines(newcontents, file_path[i])
}

#################################
#################################

#chartchallenges 2023
# themes
path <- list.dirs("chartchallenges/cases2023/posts2023")
all_files <- list.files(path,full.names = T)
# tibble(files=all_files)%>%filter(str_detect(files,".qmd"))%>%View

tb <- tibble(path=all_files)%>%
  separate(path,
           into=c("type","cases","posts","folder","files"),
           sep = "/",remove = F)%>%
  drop_na()%>%
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)#%>%View


folders <- unique(tb$folder)
files <- tb$files[str_detect(tb$files,".qmd")]
images <- tb$files[str_detect(tb$files,".png|.gif")]
images_png <- tb$files[str_detect(tb$files,".png")]
images_gif <- tb$files[str_detect(tb$files,".gif")]
date <- seq.Date(as.Date("2023-04-01"),as.Date("2023-04-30"),
                 "days")

my_tb <- bind_cols(date=date,
                   folders=folders,
                   files=files,
                   images=images)%>%
  mutate(id=str_extract(folders,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  mutate(title=gsub(".qmd","",files),
         title=gsub("^day[0-9]+_","",title),
         title=str_to_title(title),
         title=gsub("_"," ",title),
         subtitle=paste0("Welcome to #30DayChartChallenge 2023 day ",id),
         folder_new=gsub(".qmd","",files))#%>%View

my_tb%>%View

png <- my_tb%>%filter(!str_detect(images,".gif"))
gif <- my_tb%>%filter(str_detect(images,".gif"))


pathtoimage_from_png <- paste0("chartchallenges/cases2023/posts2023/",
                           png$folders,"/",png$images)
pathtoimage_to <- paste0("chartchallenges/cases2023/posts2023/",
                         png$folders,"/",png$folder_new,".png")
pathtoimage_from_gif <- paste0("chartchallenges/cases2023/posts2023/",
                               gif$folders,"/",gif$images)
pathtoimage_to <- paste0("chartchallenges/cases2023/posts2023/",
                         gif$folders,"/",gif$folder_new,".gif")
pathtofolder_from <- paste0("chartchallenges/cases2023/posts2023/",
                            my_tb$folders)
pathtofolder_to <- paste0("chartchallenges/cases2023/posts2023/",
                          my_tb$folder_new)
# rename files 
for (i in 1:length(pathtofolder_from)) {
  file.rename(from = pathtofolder_from[i],to = pathtofolder_to[i])
}



text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",my_tb$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",my_tb$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",my_tb$date,"'"),
                    "\n",
                    "image: ",
                    paste0("'",my_tb$images,"'"),
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



# write THE YAMAL on top of each file 
for (i in 1:length(my_tb$folders)) {
  file_path <- paste0("chartchallenges/cases2023/posts2023/", 
                      my_tb$folders,"/",
                      my_tb$files)
  text <- text_full[i]
  lines <- readLines(file_path[i],-1L)
  newcontents <- c(text,lines)
  writeLines(newcontents, file_path[i])
}



