library(tidyverse)

gt <- read_table("gt_long.txt", col_names = FALSE)
colnames(gt) <- c("ID", "Chromosome", "Position", "Genotype")



##Below is the code for ex3.3
#gt %>%
  #filter(ID == "A01_62", Chromosome == "chrII") %>%
  #mutate(Genotype = as.character(Genotype)) %>%
  #mutate(Position = as.numeric(Position))%>%
  #ggplot(aes(x=Position,y=Genotype,color = Genotype)) +
  #geom_point()+
  #theme_classic()

##Below is the code for ex3.4:
gt %>%
filter(ID == "A01_62") %>%
mutate(Genotype = as.character(Genotype)) %>%
mutate(Position = as.numeric(Position))%>%
ggplot(aes(x=Position,color = Genotype)) +
facet_wrap(~ Chromosome, scales = "free_x", ncol = 3) +
#facet_grid(~ Chromosome, scales = "free_x", space = "free_x") +
geom_point(aes(y=1))+
theme_classic()+
theme(
  axis.text.y = element_blank()
)


## I know we are supposed to use facet_grid, but it looked really messy so I wrapped it instead for my PNG image.
##the facet_grid is commented out
  
