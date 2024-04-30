library(tidyverse)
library(ggplot2)
library(dplyr)

#2.1

data=readRDS("../data/412000.rds")
histogram <- ggplot(data = data, aes(x = avgWage)) +
  geom_histogram(bins = 100, fill = "blue", color = "darkblue", size = 0.4) +
  labs(ylab = "Kiekis", xlab = "Atlyginimas", main = "Vidutinio atlyginimo histograma") +
  theme(panel.background = element_rect(fill = "lightgreen")) 

ggsave("../img/2.1_uzduotis.png", histogram, width=2000, height = 1500, units=("px"))


#2.2

top5 = data %>%
  group_by(name) %>%
  summarise(avg=max(avgWage)) %>%
  arrange(desc(avg)) %>%
  head(5)

graph <- data %>%
  filter(name %in% top5$name) %>%
  mutate(months = as.Date(month)) %>%
  ggplot(aes(x = months, y = avgWage, color = name)) +
  geom_line() + 
  theme_classic() +
  labs(title = "5 įmonės, kurių faktinis darbo užmokestis per metus buvo didžiausias", 
       x = "Months", 
       y = "avgWage", 
       color = "Įmonė") +
  scale_color_manual(values = c("red","blue","green","orange","purple")) +  # Pasirenkame norimas spalvas kiekvienai įmonei
  theme(panel.background = element_rect(fill = "lightyellow"))
 

ggsave("../img/2.2_uzduotis.png", graph, width=2000, height = 1500, units=("px"))


#2.3

Max = data %>%
  filter(name %in% top5$name) %>%
  group_by(name) %>%
  summarise(workers = max(numInsured)) %>%
  arrange(desc(workers))

Max$name = factor(Max$name, levels =Max$name [order(Max$name, decreasing=TRUE)])  

graphic <- ggplot(Max, aes(x = fct_reorder(name, -workers), y = workers, fill = name)) +
  geom_col() +
  theme_dark() +
  labs(title = "5 įmonės, kuriose yra daugiausiai apdraustų darbuotojų", 
       x = "Įmonė", 
       y = "Apdrausti darbuotojai", 
       fill = "Įmonės pavadinimas") +
  scale_fill_manual(values = c("red", "blue", "green", "orange", "purple")) +  # Nustatyti individualias spalvas
  theme(panel.background = element_rect(fill = "lightyellow"))

ggsave("../img/2.3_uzduotis.png", graphic, width=2000, height = 1500, units=("px"))
