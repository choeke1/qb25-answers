library(tidyverse)
header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv("~/qb25-answers/week1/hg19-kc-count.bed", col_names=header)

ggplot(df_kc, aes(x = start, y = count)) +
  geom_line() +
  facet_wrap(vars(chr), scales = "free") 

ggsave("wk1_exercise1.png")
  



