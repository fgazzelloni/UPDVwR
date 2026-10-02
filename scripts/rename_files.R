###### select files
library(tidyverse)
dirs <- list.dirs("chartchallenges/cases2021/p2021", full.names = T)
dirs1 <- dirs[-1]

fullnames <- list.files(dirs1,full.names = T)

tb <- tibble(fullnames) %>%
  separate(fullnames,
           into=c("type","year","year2","folder","file"),
           sep = "/",remove = F) %>%
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id))%>%
  arrange(id)
  
tb%>%dim
my_tb <- tb%>%
  filter(str_detect(file,".R|.rmd"))

setdiff(tb$id,my_tb$id)
missing <- tb %>%
  filter(id %in% setdiff(tb$id,my_tb$id))

## add the missing files by copying them from their location
#done
# rerun the above

# rename all files .R and .rmd 
tb_scripts <- tb%>%
  filter(str_detect(file,".R|.rmd"))

for (i in 1:length(tb_scripts$fullnames)) {
  
  file.rename(tb_scripts$fullnames[1],
              paste0("chartchallenges/cases2021/p2021/",
                     tb_scripts$folder[1],"/",
                     tb_scripts$folder[1],".qmd"))
}

file.copy(from = "/Users/macintoshhd/.Trash/day27_educational.qmd",
          to = paste0("chartchallenges/cases2021/p2021/",
                      tb_scripts$folder[27]))

# accidentally trashed and put them back
for (i in 1:length(tb_scripts$fullnames)) {
file.copy(from = paste0("/Users/macintoshhd/.Trash/",
                        tb_scripts$folder[i],".qmd"),
          to = paste0("chartchallenges/cases2021/p2021/",
                      tb_scripts$folder[i]))
}

# check for the images, it might be possible that there
# are more then one in one single folder
tb%>%
  filter(str_detect(file,".png|.gif"))%>%count(id,sort=T)
# cleaned manually, rerun the top

# rename the images
tb_images_png <- tb%>%
  filter(str_detect(file,".png"))
tb_images_gif <- tb%>%
  filter(str_detect(file,".gif"))

for (i in 1:length(tb_images_png$fullnames)) {
  
  file.rename(tb_images_png$fullnames[i],
              paste0("chartchallenges/cases2021/p2021/",
                     tb_images_png$folder[i],"/",
                     tb_images_png$folder[i],".png"))
}


for (i in 1:length(tb_images_gif$fullnames)) {
  file.rename(tb_images_gif$fullnames[i],
              paste0("chartchallenges/cases2021/p2021/",
                     tb_images_gif$folder[i],"/",
                     tb_images_gif$folder[i],".gif"))
}


# rerun the tb 
newtb <- tb %>%
  filter(str_detect(file,".qmd"))

images <- tb %>%
  filter(str_detect(file,".png|.gif"))%>%
  select(image=file)

my_tb <- bind_cols(newtb,images)

my_tb1 <- my_tb %>%
  mutate(title=gsub("^*.*_","",folder),
         title=str_to_title(title),
         subtitle= paste0("Welcome to #30DayChartChallenge 2021 day ",id),
         date = seq.Date(as.Date("2021-04-01"),as.Date("2021-04-30"),"days"))  #%>%View

# setup the global yaml
yml <- paste0("---",
              "\n",
              "title: ",
              paste0("'",my_tb1$title,"'"),
              "\n",
              "subtitle: ",
              paste0("'",my_tb1$subtitle,"'"),
              "\n",
              "date: ",
              paste0("'",my_tb1$date,"'"),
              "\n",
              "image: ",
              paste0("'",my_tb1$image,"'"),
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
for (i in 1:30) {
  file_path <- paste0("chartchallenges/cases2021/p2021/", 
                      my_tb1$folder,
                      "/",
                      my_tb1$file)
  text <- yml[i]
  lines <- readLines(file_path[i],-1L)
  newcontents <- c(text,lines)
  writeLines(newcontents, file_path[i])
}

####################### ####################### ####################### #######################
## test with one file #######################
tb1 <- my_tb[1,]

### ? where is gone???
file.rename(tb1$fullnames,paste0(tb1$folder,".R"))
## copy the file backin again
file.copy("~/Documents/R/R_general_resources/EDA_and_maps/30DayChartChallenge_scripts/data/2021/day2_pictogram/covid19_icu.R",
          "chartchallenges/cases2021/p2021/day2_pictogram")
# file.remove("~/Documents/R/R_general_resources/UPDVwR/R/covid19_icu.R")
# file.copy("~/Documents/R/R_general_resources/UPDVwR/day2_pictogram.R","~/Documents/R/R_general_resources/UPDVwR/chartchallenges/cases2021/p2021/day2_pictogram")
# file.remove("~/Documents/R/R_general_resources/UPDVwR/day2_pictogram.R")
file.rename(paste0("chartchallenges/cases2021/p2021/day2_pictogram/",
                   tb1$file),
            paste0("chartchallenges/cases2021/p2021/day2_pictogram/",
                   tb1$folder,".qmd"))
file_path <- paste0("chartchallenges/cases2021/p2021/day2_pictogram/day2_pictogram.qmd")
# text <- paste0(" ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n"," ","\n")
lines <- readLines("chartchallenges/cases2021/p2021/day2_pictogram/day2_pictogram.qmd",-1L)
#newcontents <- c(text,lines)
#writeLines(newcontents, file_path)
yml <- paste0("---",
               "\n",
               "title: ",
               paste0("'",tb$folder[2],"'"),
               "\n",
               "subtitle: ",
               paste0("'",tb$folder[2],"'"),
               "\n",
               "date: ",
               paste0("'",tb$folder[2],"'"),
               "\n",
               "image: ",
               paste0("'",tb$folder[2],"'"),
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
newcontents <- c(yml,lines)
writeLines(newcontents, file_path)
