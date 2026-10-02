########################################
## RENAME AND WRITE
########################################
dir <- paste0("tidytuesday/cases2021/posts2021")
dirs <- list.dirs(dir)
files <- list.files(dirs,full.names = T)

library(tidyverse)
tb <-  tibble(full_path=files)%>%
  filter(str_detect(full_path,"png|gif|R$|qmd|rmd|JPG|Rmd"))%>%
  separate(full_path,
           into=c("type","cases","posts","folder","file"),
           sep = "/",
           remove = F)%>%
  select(-type,-cases,-posts) %>% 
  mutate(id=str_extract(folder,"[0-9]+"),
         id=as.integer(id),
         file_type=str_extract(file,".png|.gif|.R$|.qmd|.rmd|.JPG|.Rmd"),
         file_type_new=case_when(file_type%in%c(".png",".JPG") ~ ".png",
                                 file_type%in%c(".R",".Rmd",".rmd") ~ ".qmd",
         TRUE~file_type),
         title=gsub("^day[0-9]+_","",folder),
         title=str_to_title(title),
         subtitle=paste0("Welcome to #30DayMapChallenge 2022 day ",id),
         date = paste0("2022-11-",id)
         ) %>%
  arrange(id)


  tb%>%View

  
# to_be_removed <- tb %>%
#   filter(is.na(file_type))
# View(to_be_removed)
# # remove files that are not needed
# file.remove(to_be_removed$full_path)


  tb%>%count(id,folder)%>%View
  
  
  ## rename files and folders
  for (i in 1:length(tb$folder)) {
    file.rename(
      from = tb$full_path[i],
      to = paste0("mapchallenges/cases2022/posts2022/",
                  tb$folder[i],"/",
                  tb$folder[i],
                  tb$file_type_new[i])
    )
  }
  
  ## set the YAML
  my_tb <- tb%>%
    filter(file_type_new==".qmd")
  my_tb2 <- tb%>%
    filter(file_type_new %in% c(".png",".gif"))
  
  
  tb_new <- merge(my_tb,my_tb2,by = c("date","folder","id","title","subtitle"))%>%
    select(-full_path.x,-full_path.y,
           -file_type.x,-file_type.y,
           -file_type_new.x,-file_type_new.y)
  

  text_full <- paste0("---",
                      "\n",
                      "title: ",
                      paste0("'",tb_new$title,"'"),
                      "\n",
                      "subtitle: ",
                      paste0("'",tb_new$subtitle,"'"),
                      "\n",
                      "date: ",
                      paste0("'",tb_new$date,"'"),
                      "\n",
                      "image: ",
                      paste0("'",tb_new$file.y,"'"),
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
  for (i in 1:length(tb_new$date)) {
    file_path <- paste0("mapchallenges/cases2022/posts2022/", 
                        tb_new$folder,"/",
                        tb_new$file.x)
    text <- text_full[i]
    lines <- readLines(file_path[i],-1L)
    newcontents <- c(text,lines)
    writeLines(newcontents, file_path[i])
  }
  
  
  
  
  
  tb%>%head
  
  
 # create .qmd files where missing 
  ids <- tb_new %>%
  count(id)%>%
    select(-n)
    
  missing <- tb%>%
      filter(!id%in%unlist(ids)) # %>%View
  
file.create(paste0("mapchallenges/cases2022/posts2022/",
                   missing$folder,"/",missing$folder,".qmd"))
# write the YAML
text_full <- paste0("---",
                    "\n",
                    "title: ",
                    paste0("'",missing$title,"'"),
                    "\n",
                    "subtitle: ",
                    paste0("'",missing$subtitle,"'"),
                    "\n",
                    "date: ",
                    paste0("'",missing$date,"'"),
                    "\n",
                    "image: ",
                    paste0("'",missing$file,"'"),
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
for (i in 1:length(missing$date)) {
  file_path <- paste0("mapchallenges/cases2022/posts2022/", 
                      missing$folder,"/",
                      missing$folder,".qmd")
  text <- text_full[i]
  lines <- readLines(file_path[i],-1L)
  newcontents <- c(text,lines)
  writeLines(newcontents, file_path[i])
}




