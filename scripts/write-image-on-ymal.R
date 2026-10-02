# write lines to add the image to each post's to page
library(stringr)
library(purrr)
library(readr)

dirs <- list.dirs("~/Documents/R/AAA_websites/UPDVwR/content/chartchallenge/cases2022/posts2022")
files <- list.files(dirs,pattern = ".qmd$",
                    full.names = TRUE)
name_files <- list.files(dirs,pattern = ".qmd$",
                    full.names = FALSE) 

for (f in files) {
  # Read file
  x <- readLines(f)
  # Identify YAML boundaries (---)
  yaml_start <- which(x == "---")[1]
  yaml_end   <- which(x == "---")[2]
  
  yaml <- x[yaml_start:yaml_end]
  
  # Extract the image URL
  image_line <- yaml[str_detect(yaml, "^image:")]
  image_url <- str_extract(image_line, "https?://.*\\.png")
  
  x <- readLines(f)
  # Identify YAML boundaries (---)
  yaml_start <- which(x == "---")[1]
  yaml_end   <- which(x == "---")[2]
  
  yaml <- x[yaml_start:yaml_end]
  # Create markdown section to append
  md_block <- c(
    "",
    paste0("<center>![](", image_url, ")</center>"),
    "")
  # Reassemble file: YAML + appended block + original body 
  new_content <- c(yaml, 
                   md_block, 
                   x[(yaml_end + 1):length(x)])
  # Write back
  writeLines(new_content, f)
  message("Updated: ", f)
}

# build the url
for (f in files) {
  # Read file
  x <- readLines(f)
  # Identify YAML boundaries (---)
  yaml_start <- which(x == "---")[1]
  yaml_end   <- which(x == "---")[2]
  # Extract YAML section
  yaml <- x[yaml_start:yaml_end]

  image_line <- yaml[str_detect(yaml, "^image:")]
  # Extract the image URL
  image_url <- paste0("https://raw.githubusercontent.com/Fgazzelloni/30DayChartChallenge/refs/heads/main/data/Edition_2022/images/", name_files)
  
  x <- readLines(f)
  # Identify YAML boundaries (---)
  yaml_start <- which(x == "---")[1]
  yaml_end   <- which(x == "---")[2]
  
  yaml <- x[yaml_start:yaml_end]
  
  # Replace image line in YAML
  # ----------------------------------
  yaml_new <- yaml
  yaml_new[str_detect(yaml_new, "^image:")] <- paste0("image: '", image_url, "'")
  # Create markdown section to append
  md_block <- c(
    "",
    paste0("<center>![](", image_url, ")</center>"),
    "")
  # Reassemble file: YAML + appended block + original body 
  new_content <- c(yaml_new, 
                   x[(yaml_end + 1):length(x)],
                   md_block)
  # Write back
  writeLines(new_content, f)
  message("Updated: ", f)
}



