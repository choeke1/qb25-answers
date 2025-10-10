library(tidyverse)

# Read in AF file (from your Python output)
af <- read_table("AF.txt", col_names = FALSE)
colnames(af) <- "AF"

# Plot allele frequency spectrum with 11 bins
af %>%
  ggplot(aes(x = AF)) +
  geom_histogram(bins = 11, color = "black") +
  labs(
    title = "Allele Frequency Spectrum",
    x = "Allele frequency (AF)",
    y = "Number of variants"
  ) 
#The distribution of allele frequency represents that most alleles in a gene have roughly a 50% gene frequency. This is expected as most genes 
#are heterozygous and alleles are deposited maternally and paternally, Some genes have a 100% frequency as they may be more important for cell survival.




# Read in DP file (from your Python output)
dp <- read_table("DP.txt", col_names = FALSE)
colnames(dp) <- "DP"

# Plot read depth distribution with 21 bins, xlim 0–20
dp %>%
  ggplot(aes(x = DP)) +
  geom_histogram(bins = 21, color = "black") +
  scale_x_continuous(limits = c(0, 20)) +
  labs(
    title = "Read Depth Distribution",
    x = "Read depth per sample per variant",
    y = "Count"
  )
#This shows that there are roughly 60, with a read depth greater than 20

