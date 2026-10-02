# Copy files from #30DayMapChallenge GitHub Repository
# https://github.com/Fgazzelloni/30DayMapChallenge

# Load packages
library(fs)
library(purrr)

# Define source and destination paths
source_dir <- "~/Documents/R/R_general_resources/EDA_and_maps/30DayMapChallenge/2025"
dest_dir   <- "~/Documents/R/AAA_websites/UPDVwR/content/mapchallenge/cases2025/posts2025"

# Create destination folder if it doesn't exist
dir_create(dest_dir)

# Get the list of folders (e.g., "day1_points", "day2_lines", etc.)
subdirs <- dir_ls(source_dir, type = "directory")

# Copy each folder (with all contents) to the destination
walk(subdirs, ~ {
  folder_name <- path_file(.x)  # e.g., "day1_points"
  dir_copy(.x, path(dest_dir, folder_name), overwrite = TRUE)
})
