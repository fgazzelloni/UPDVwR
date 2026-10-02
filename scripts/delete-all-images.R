# delete all images in foldes inside a directory

dirs <- list.dirs("~/Documents/R/AAA_websites/UPDVwR/content/chartchallenge/cases2021/posts2021")

files <- list.files(dirs,
                    pattern = ".png$|.jpg$|.jpeg$|.gif$", 
                    full.names = T)
  file.remove(files)
