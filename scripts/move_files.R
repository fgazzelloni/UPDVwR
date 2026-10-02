## move files from folder to folder
library(tidyverse)
dirs <- list.dirs("chartchallenges/cases2022/image")
dirs_to <- list.dirs("chartchallenges/cases2022/scripts")
#Get the list of all images: (".jpg", ".png", etc) 
allFiles = list.files(dirs,
                      pattern = "png", 
                      full.names = T)
image_tb <- tibble(allFiles)%>%
  separate(allFiles,
           into=c("folder1","folder2","folder3","folder","image"),
           sep="/",
           remove = F)%>%
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id) #%>%View

script_tb <- tibble(to=dirs_to[-1]) %>%
  separate(to,
           into=c("folder1","folder2","folder3","folder"),
           sep="/",
           remove = F)%>%
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id) #%>%View


from <- image_tb$allFiles
to <- script_tb[-22,]$to

file.copy(
  from = from,
  to = paste0(to,"/",image_tb$image),
  overwrite = F
)





#######################


dirs <- list.dirs("chartchallenges/cases2022/posts2022")

scripts <- tibble(filespath=list.files(dirs,full.names = F))%>%
  filter(str_detect(filespath,"^day[0-9]+"))%>%
  mutate(id=str_extract(filespath,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  filter(!str_detect(filespath,"note|.png|.jpg|jpeg|.gif|example"),
         str_detect(filespath,".R|.rmd"))

my_path <- tibble(filespath=list.files(dirs,full.names = T))%>%
  mutate(id=str_extract(filespath,"day[0-9]+"),
         id=str_extract(id,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  filter(!str_detect(filespath,"note|.png|.jpg|jpeg|.gif|example|.csv"),
         str_detect(filespath,".R|.rmd"))# %>%View

path <- my_path %>%
  separate(filespath,
         into=c("folder1","folder2","folder3","folder4","file"),
         sep="/",
         remove = F)%>%
  mutate(id=str_extract(file,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id) 


# rename all files .qmd
for (i in 1:length(my_path$filespath)) {
  file.rename(from = my_path$filespath[i],
              to = paste0("chartchallenges/cases2022/posts2022/",
                          path$folder4[i],
                          "/",
                          path$folder4[i],
                          ".qmd"))
}


## remove other files
to_remove <- tibble(filespath=list.files(dirs,full.names = T))%>%
  mutate(id=str_extract(filespath,"day[0-9]+"),
         id=str_extract(id,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%
  filter(str_detect(filespath,"note|example|.csv|.R|.rmd"))

for (i in 1:length(to_remove$filespath)) {
  file.remove(to_remove$filespath[i])
}



dirs <- list.dirs("chartchallenges/cases2022/posts2022")
tibble(dirs=list.files(dirs))%>%
  filter(str_detect(dirs,".qmd"))%>%
  mutate(id=str_extract(dirs,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)%>%View


