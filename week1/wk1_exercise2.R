library(tidyverse)
header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv("~/qb25-answers/week1/hg19-kc-count.bed", col_names=header)
df_kc16 <- read_tsv("~/qb25-answers/week1/hg-16_kc-count.bed" , col_names=header )
combined_df <- bind_rows(hg19 = df_kc, hg16 = df_kc16, .id = "assembly")


ggplot(combined_df, aes(x = start, y = count, color = assembly)) +
  geom_line() +
  facet_wrap(vars(chr), scales = "free")
 



ggsave("wk1_exercise2.png")
