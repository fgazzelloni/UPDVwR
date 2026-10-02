# create a folder and put all images from a directory in r
dir.create("content/chartchallenge/cases2023/posts2023/images_folder")

path <- "~/Documents/R/AAA_websites/UPDVwR/content/chartchallenge/cases2022/posts2022"
dirs <- list.dirs(path, recursive = FALSE)
image_files <- list.files(dirs, pattern = "\\.(jpg|png|jpeg|gif)$", ,
                    full.names = TRUE)

file.copy(image_files, "~/Documents/R/AAA_websites/UPDVwR/content/chartchallenge/cases2022/posts2022/images_folder")
