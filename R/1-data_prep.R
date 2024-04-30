install.packages("tidyverse")
install.packages("rjson")
install.packages("jsonlite")

library(tidyverse)
library(rjson)
library(jsonlite)
library(dplyr)

cat("Darbinė direktorija:", getwd())
download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")

readLines("../data/monthly-2023.json", 20)
data = fromJSON("../data/monthly-2023.json")
data %>%
  filter(ecoActCode == 412000) %>%
  saveRDS("../data/412000.rds")

file.remove("../data/temp")
file.remove("../data/monthly-2023.json")
file.remove("../img/pavyzdys1.png")
file.remove("../img/pavyzdys2.png")
file.remove("../img/pavyzdys3.png")
file.remove("../img/shiny_example.png")
