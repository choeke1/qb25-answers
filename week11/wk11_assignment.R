library(tidyverse)



setwd( "~/qb25-answers/week11/")

#3x Coverage
wk11 <- read.delim("genome_coverage.txt")
pois <- read.csv("poisson_estimate.txt", header = FALSE)
pois <- t(pois)
pois <- as.data.frame(pois)
pois <- pois %>%
  mutate(X0 = seq(0, n() - 1)) #chatgpt wrote this line for me
norm <- read.csv("normal_estimate.txt", header = FALSE)
norm <- t(norm)
norm <- as.data.frame(norm)
norm <- norm %>%
  mutate(X0 = seq(0, n() - 1))

ggplot(wk11, aes(x = X0)) +
  geom_histogram(binwidth = 1) +
  geom_line(data = pois, aes(x= X0, y = V1, color = "Poisson")) +
  geom_line(data = norm, aes(x = X0, y = V1, color = "Normal")) +
  scale_color_manual(values = c("Poisson" = "red", "Normal" = "blue")) + 
  theme_minimal() +
  labs(
    title = "Distribution of reads at 3x coverage",
    y = "# of Reads",
    x = "Coverage",
    color = "Model"
  )



#30x Coverage
wk11 <- read.delim("genome_coverage_30.txt")
pois <- read.csv("poisson_estimate_30.txt", header = FALSE)
pois <- t(pois)
pois <- as.data.frame(pois)
pois <- pois %>%
  mutate(X0 = seq(0, n() - 1)) #chatgpt wrote this line for me
norm <- read.csv("normal_estimate_30.txt", header = FALSE)
norm <- t(norm)
norm <- as.data.frame(norm)
norm <- norm %>%
  mutate(X0 = seq(0, n() - 1))

ggplot(wk11, aes(x = X0)) +
  geom_histogram(binwidth = 1) +
  geom_line(data = pois, aes(x= X0, y = V1, color = "Poisson")) +
  geom_line(data = norm, aes(x = X0, y = V1, color = "Normal")) +
  scale_color_manual(values = c("Poisson" = "red", "Normal" = "blue")) + 
  theme_minimal() +
  labs(
    title = "Distribution of reads at 10x coverage",
    y = "# of Reads",
    x = "Coverage",
    color = "Model"
  )
