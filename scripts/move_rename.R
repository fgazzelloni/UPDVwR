## tidytuesday rename folders, copy and rename png/gif files
## Tidytuesday 2021
# Load necessary packages
library(tidyverse)
## read the orginal names from the github directory
rawdata_2021 <- paste0("https://github.com/rfordatascience/tidytuesday/tree/master/data/2021")
# scrap the table
table_21 <- xml2::read_html(rawdata_2021)%>%
  rvest::html_node("table") %>% 
  rvest::html_table(header = TRUE)%>%
  select(Week,Date,title=Data)%>%
  mutate(folder=gsub("[[:punct:]]","",title),
         folder=gsub(" ", "_",folder),
         folder=paste0("w",Week,"_",folder),
         w_n=ifelse(Week < 10,paste0(0,Week),Week))
table_21%>%View
table_21<- table_21%>%
  filter(Week>12,!Week==47)

# read the files from the repo to be renamed
dir <- paste0("tidytuesday/cases2021/posts2021")
dirs <- list.dirs(dir)
my_dirs<- dirs[-1]
my_qmdfiles<- list.files(my_dirs,full.names = T)%>%
  as_tibble()%>%
  filter(str_detect(value,".qmd")) %>%
  separate(value,
         into=c("type","cases","posts","folder","file"),
         sep = "/",
         remove = F)%>%
  select(-type,-cases,-posts) %>% 
  mutate(id=str_extract(file,"[0-9]+"),
         id=as.integer(id),
         title=gsub("^w[0-9]+_","",folder)
  ) %>%
  arrange(id)# %>%View
my_qmdfiles%>%View


# for (i in 1:39) {
#   dir.create(paste0("tidytuesday/cases2021/p2021/",
#                     table_22$folder[i]))
# }

# copy files from github
"https://github.com/Fgazzelloni/UPDVwR/tree/44923c5b0094880ab65d4fd07255b2fb29ff8953/tidytuesday/cases2021/posts2021"
# scrap my files on github
library(httr)

req <- GET("https://api.github.com/repos/Fgazzelloni/UPDVwR/git/trees/main?recursive=1")
stop_for_status(req)

#unlist(content(req)$tree)

filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)
filelist
qmdfiles <- grep("tidytuesday/cases2021/posts2021", filelist, value = TRUE, fixed = TRUE)%>%
  as_tibble()%>%
  filter(str_detect(value,".qmd"))%>%
  mutate(path=paste0("https://raw.githubusercontent.com/Fgazzelloni/UPDVwR/44923c5b0094880ab65d4fd07255b2fb29ff8953/",
                     value))

# path<-"https://raw.githubusercontent.com/Fgazzelloni/UPDVwR/44923c5b0094880ab65d4fd07255b2fb29ff8953/tidytuesday/cases2021/posts2021/w13_UN_votes/w13_UN_votes.qmd"

for (i in 1:39) {
  content = readLines(qmdfiles$path[i])
  writeLines(content, my_qmdfiles$value[i])
}

# write the yaml image section


# for (i in 1:39) {
# file.copy(from = qmdfiles$value[i],
#          to = paste0("tidytuesday/cases2022/p2022/",
#                      table_21$folder[i],"/",
#                      my_qmdfiles$file[i]))
# }

# rename folders
# for (i in 1:length(my_dirs)) {  
# file.rename(from = my_dirs[5],
#             to = paste0("tidytuesday/cases2022/posts2022/",
#                         table_22$folder[5])
#             )
# }

# rename .qmd files
for (i in 1:length(my_dirs)) {  
  file.rename(from = paste0(my_qmdfiles$value[i]),
              to = paste0("tidytuesday/cases2022/posts2022/",
                          table_22$folder[i],"/",table_22$folder[i],".qmd")
  )
}

# scrap my files on github
library(httr)

req <- GET("https://api.github.com/repos/Fgazzelloni/TidyTuesday/git/trees/main?recursive=1")
stop_for_status(req)

#unlist(content(req)$tree)

filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)
filelist


my_images_ghpath <- grep("data/2021", filelist, value = TRUE, fixed = TRUE)%>%
  as_tibble()%>%
  filter(str_detect(value,".png|.gif"),
         !str_detect(value,"gather"))%>%
  mutate(images=gsub('.*/(.*)','\\1',value))%>%
  separate(value,
           into=c("data","year","folder","file"),
           sep = "/",
           remove = F)%>%
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  filter(str_detect(file,"^w"))
  
my_images_ghpath%>%View
# drop_na()%>%View

url <- paste0("https://raw.githubusercontent.com/Fgazzelloni/TidyTuesday/ab924a20bbe270bab306f4b13df0daaa6e53ffeb/",
        my_images_ghpath$value[1])
browseURL(url)
# as_tibble(url)
url <- tibble()
for (i in 1:39) {
  url[i] <- paste0("https://raw.githubusercontent.com/Fgazzelloni/TidyTuesday/ab924a20bbe270bab306f4b13df0daaa6e53ffeb/",
                my_images_ghpath$value[i]) 
  url <- print(url)
}

my_images_ghpath_url <- url%>%as_tibble()

text_full <- paste0("image: ",
                    paste0("'",my_images_ghpath_url$value,"'"))

dirs<- list.dirs("tidytuesday/cases2021/posts2021")
dirs<-dirs[-1]
path<-list.files(dirs,full.names = T)%>%
  as_tibble()%>%
  filter(str_detect(value,".qmd"))
# write THE YAMAL on top of each file 
for (i in 1:39) {
  file_path <- path$value
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  top_doc = contents[c(1:5)]
  end_doc <- contents[-c(1:6)]
  newcontents <- c(top_doc,text,end_doc)
  writeLines(newcontents, file_path[i])
}

#######################################################
file_path <- tibble()
for (i in 1:39) {  
  # to make it work you need to 
  # run the for first without the [i] - file_path[i]
  # then rerun it with it - file_path[i]
  file_path[i] <- paste0("tidytuesday/cases2021/posts2021/",
         table_21$folder[i],"/",
         table_21$folder[i],".qmd")
  file_path <- print(file_path)
}
file_path<- as_tibble(file_path)

tb<- file_path%>%
  filter(str_detect(value,"qmd"))%>%
  separate(value,
           into=c("type","cases","posts","folder","file"),
           sep = "/",
           remove = F)%>%
  select(-type,-cases,-posts) %>% 
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id),
         title=gsub("^w[0-9]+_","",folder),
         title=gsub("_"," ",title),
         subtitle=paste0("Welcome to #TidyTuesday 2021 day ",id)
  ) %>%
  arrange(id)%>%
  cbind(image=my_images_ghpath_url$value)

# date = seq.Date(as.Date("2022-03-23"),as.Date("2022-12-22"),"week")
length(date)
date<- date[-35]

my_tb <- tb%>%cbind(date)
my_tb%>%View
# write the yaml

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
                    paste0("'",my_tb$image,"'"),
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


#############################################################
# write THE YAMAL on top of each file 
for (i in 1:39) {
  file_path <- my_tb$value
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  end_doc <- contents[-c(1:12)]
  newcontents <- c(text,end_doc)
  writeLines(newcontents, file_path[i])
}

# delete all .png files
dirs <- paste0("tidytuesday/cases2022/posts2022")
dirs <- list.dirs(dirs)
dirs <- dirs[-1]

png22 <- list.files(dirs,full.names = T)%>%
  as_tibble()%>%
  filter(str_detect(value,".png|.gif"))%>%# View
  separate(value,
           into=c("type","cases","posts","folder","file"),
           sep = "/",
           remove = F)%>%
  select(-type,-cases,-posts) %>% 
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)
 
for (i in 1:length(png22$value)) {
  file.remove(png22$value[i])
}

#########################################################

## read the orginal names from the github directory
readme_2022 <- paste0("https://raw.githubusercontent.com/Fgazzelloni/TidyTuesday/ab924a20bbe270bab306f4b13df0daaa6e53ffeb/data/2022/README.md")

readme_tb <- read.delim(readme_2022,
           header = F,
           skip = 5,
           sep="|",
           check.names = T)%>%
  select(-V1,-V6)
  
readme_tb%>%dim


ghimages_22 <- readme_tb[4:29,]%>%
  filter(str_detect(V2,".png|.gif"))%>%
  pivot_longer(everything())%>%
  mutate(images=gsub('.*/(.*)','\\1',value))%>%#View
  #select(contains("images"))%>%
  #pivot_longer(everything())%>%
  mutate(images=gsub(")","",images))%>%
  #select(images)%>%
  mutate(images=trimws(images),
         path= gsub("[\\(\\)]", "", regmatches(value, gregexpr("\\(.*?\\)", value))),
         path =gsub(",.*$", "", path),
         path =gsub("^c\"|\"$", "", path))

ghimages_22%>%View


# scrap my files on github
library(httr)

req <- GET("https://api.github.com/repos/Fgazzelloni/TidyTuesday/git/trees/main?recursive=1")
stop_for_status(req)

#unlist(content(req)$tree)

filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)
filelist


my_images_ghpath <- grep("data/2022", filelist, value = TRUE, fixed = TRUE)%>%
  as_tibble()%>%
  filter(str_detect(value,".png|.gif"),
         !str_detect(value,"gather"))%>%
  mutate(images=gsub('.*/(.*)','\\1',value))%>%
  #filter(images%in%images22)%>%
  mutate(value=as.character(value),
         id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id),
         images=trimws(images))%>%
  arrange(id)


length(ghimages_22$path)
  
  url <- tibble()
  for (i in 1:52) {
    url[i] <- paste0("https://raw.githubusercontent.com/Fgazzelloni/TidyTuesday/main/data/2022/",
                     ghimages_22$path[i]) 
    url <- print(url)
  }

my_images_ghpath_url <- url%>%as_tibble()
my_images_ghpath_url%>%dim

tb<- my_images_ghpath_url%>%
  rename(image=value)%>%
  cbind(my_qmdfiles)%>%
  relocate(id)%>%
  mutate(title=gsub("_"," ",title),
         subtitle=paste0("Welcome to #TidyTuesday 2022 day ",id),
         date=seq.Date(as.Date("2022-01-04"),as.Date("2022-12-27"),"week")) 

# write the yaml

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


#############################################################
# write THE YAMAL on top of each file 
for (i in 1:52) {
  file_path <- tb$value
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  end_doc <- contents[-c(1:12)]
  newcontents <- c(text,end_doc)
  writeLines(newcontents, file_path[i])
}
#############################################################
# correct the yaml in 2021
subtitles <-tibble(id=seq(13,52,1),
       subtitle=paste0("Welcome to #TidyTuesday 2021 day ",id))%>%
  filter(!id==47)
text_full <- paste0("subtitle: ",
                    paste0("'",subtitles$subtitle,"'"))

dirs<- list.dirs("tidytuesday/cases2021/posts2021")
path <- list.files(dirs,full.names = T)%>%
  as_tibble()%>%
  filter(str_detect(value,".qmd"))

for (i in 1:39) {
  file_path <- path$value
  text <- text_full[i]
  top_doc <- readLines(file_path[i],2)
  end_doc <- contents[-c(1:3)]
  newcontents <- c(top_doc,text,end_doc)
  writeLines(newcontents, file_path[i])
}


####### TidyTuesday 2023
dirs <- list.dirs("tidytuesday/cases2023/posts2023")
path <- list.files(dirs,full.names = T)

my_path <- path%>%as_tibble()%>%
  filter(!str_detect(value,".qmd|.png|.gif"))%>%
  mutate(id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id))%>%
  arrange(id)#%>%View
my_path_toqmd <- path%>%as_tibble()%>%
  filter(str_detect(value,".qmd"))%>%
  mutate(id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id))%>%
  arrange(id)#%>%View
  

## copy the folder and file names from github r4ds source
raw_url <- paste0("https://github.com/rfordatascience/tidytuesday")

table <- xml2::read_html(raw_url)%>%
  rvest::html_node("table") %>% 
  rvest::html_table(header = TRUE)%>%
  select(Week,Date,Data)%>%
  mutate(folder=gsub("[[:punct:]]","",Data),
         folder=gsub(" ","_",folder),
         folder=paste0("w",Week,"_",folder),
         file=paste0(folder,".qmd"),
         w_n=ifelse(Week < 10,paste0(0,Week),Week))
table%>%View
tb <- table[1:28,]
tb %>%View



## rename all folders and files
for (i in 1:28) {
  file.rename(from = my_path$value[i],
              to = paste0("tidytuesday/cases2023/posts2023",
                          "/",
                          tb$folder[i]))
}
for (i in 1:28) {
  file.rename(from = my_path_toqmd$value[i],
              to = paste0("tidytuesday/cases2023/posts2023",
                          "/",
                          tb$folder[i],"/",
                          tb$folder[i],".qmd"))
}


## scrap the url for the images and add it to the yaml
library(httr)

req <- GET("https://api.github.com/repos/Fgazzelloni/tidytuesday/git/trees/main?recursive=1")
stop_for_status(req)

#unlist(content(req)$tree)

filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)
filelist
qmdfiles <- grep("data/2023", filelist, value = TRUE, fixed = TRUE)%>%
  as_tibble()%>%
  filter(str_detect(value,".png|.gif"),
         !str_detect(value,"images")) %>%
  mutate(id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id))%>%
  arrange(id)%>%
  mutate(path=paste0("https://raw.githubusercontent.com/Fgazzelloni/TidyTuesday/main/",
                     value))
qmdfiles%>%dim

# write the yaml
allpaths <- my_path_toqmd%>%
  full_join(qmdfiles,by="id")
allpaths%>%dim

text_full <- paste0("image: ",
                    paste0("'",allpaths$path,"'"))

dirs<- list.dirs("tidytuesday/cases2023/posts2023")
dirs<-dirs[-1]
path<-list.files(dirs,full.names = T)%>%
  as_tibble()%>%
  filter(str_detect(value,".qmd"))%>%
  mutate(id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id))%>%
  arrange(id)
path%>%View

# write THE YAMAL on top of each file 
for (i in 1:28) {
  file_path <- path$value
  text <- text_full[i]
  contents <- readLines(file_path[i],-1L)
  top_doc = contents[c(1:4)]
  end_doc <- contents[-c(1:6)]
  newcontents <- c(top_doc,text,end_doc)
  writeLines(newcontents, file_path[i])
}

## delete all the png in the folder
dirs <- list.dirs("tidytuesday/cases2023/posts2023")
path <- list.files(dirs,full.names = T)

my_path <- path%>%
  as_tibble()%>%
  filter(str_detect(value,".png|.gif"))%>%
  mutate(id=str_extract(value,"w[0-9]+"),
         id=gsub("^w","",id),
         id=as.integer(id))%>%
  arrange(id)

my_path%>%View

for (i in 1:20) {
  file.remove(my_path$value[i])
}







