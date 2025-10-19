library(tidyverse)

gt <- read_table("gt_long.txt", col_names = FALSE)
colnames(gt) <- c("ID", "Chromosome", "Position", "Genotype")



#Below is the code for ex3.3
gt %>%
  filter(ID == "A01_62", Chromosome == "chrII") %>%
  mutate(Genotype = as.character(Genotype)) %>%
  mutate(Position = as.numeric(Position))%>%
  ggplot(aes(x=Position,y=1,color = Genotype)) +
  geom_point()+
  theme_classic()

## Below is the code for ex3.4:
## Below is the code for ex3.4:
gt %>%
  mutate(
    Genotype = as.character(Genotype),
    Position = as.numeric(Position)
  ) %>%
  ggplot(aes(x = Position, y = ID, color = Genotype)) +
  geom_point(size = 0.5, alpha = 0.8) +
  facet_grid(~ Chromosome, scales = "free_x", space = "free_x") +
  theme_classic() +
  theme(
    axis.text.y = element_text(size = 6),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 7),
    strip.text = element_text(size = 8),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.spacing = unit(0.2, "lines")
  ) +
  labs(
    title = "Genotypes Across All Samples by Chromosome",
    x = "Position (bp)",
    y = "Sample ID"
  )
  
