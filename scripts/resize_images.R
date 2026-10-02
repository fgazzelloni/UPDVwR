##################
# image resizing
setwd(rstudioapi::getActiveProject())
# documentation: https://www.imagemagick.org/Magick++/Geometry.html
library(tidyverse)
library(magick)
# img = image_read("chartchallenges/cases2021/posts2021/day1_part-to-whole/day1_part-to-whole.png")
# img_scale = image_scale(img, "100")
# img_resize <- image_resize(img,"1900x")
# image_write(img_resize, path = "chartchallenges/cases2021/posts2021/day1_part-to-whole/img_resize.png", format = "png")



dirs <- list.dirs("2024", 
                  full.names = T)
#Get the list of all images: (".jpg", ".png", etc) 
allFiles <- list.files(dirs,
                      pattern = "png|jpg", 
                      full.names = T)
images_files <- allFiles %>%
  as_tibble() %>%
  mutate(filename = basename(value),
         id=parse_number(filename),
         id=trimws(id,which = "both"),
         id=as.numeric(id)) %>%
  arrange(id)  # Sort by file name
#Get the dataframe with info
# allInfo = image_info(image_read(allFiles))
allresized <- image_resize(image_read(images_files$value),
                           "500x")
allscaled <- image_scale(image_read(allFiles),"500")
allresized_2 <- image_resize(image_read(allFiles),"<500")

 for (i in 1:length(allresized)) {
   image_write(allresized[i], 
               path = collage,
               format = "png")
 }

for (i in 1:length(allscaled)) {
  image_write(allscaled[i], 
              path = allFiles[i],
              format = "png")
}



# check whether all resized properly below 1MB
allInfo = image_info(image_read(allFiles))
allInfo%>%View
# file.size=161608 ~ 157.8 KB

######################
# Load the magick package
library(magick)

# Read the PNG image
input_png <- image_read("images/collage2022.png")

# Convert PNG to SVG (vector format)
output_svg <- image_convert(input_png, format = "svg")

# Resize the SVG vector image to 60x60
output_resized_svg <- image_scale(output_svg, "800x800")

# Convert the resized SVG vector image back to PNG
output_resized_png <- image_convert(output_resized_svg, format = "png")

# Save the final resized PNG image
image_write(output_resized_png, path = "images/collage2022r.png")

allresized <- image_scale(image_read("images/collage2023.png"),"400x")
image_write(allresized, 
            path = "images/collage2023r.png",
            format = "png")
