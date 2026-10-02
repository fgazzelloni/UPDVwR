# Remove Html-files
dirs <- list.dirs("duboischallenge",full.names = T)
#Get the list of all images: (".jpg", ".png", etc) 
allFiles <- list.files(dirs,
                       pattern = "html", 
                       full.names = T)
file.remove(allFiles)

allFiles_folders <- list.dirs(dirs,
                       #pattern = "_files", 
                       full.names = T)
folders <- allFiles_folders[stringr::str_detect(allFiles_folders,"_files")]
unlink(folders, recursive = TRUE)

