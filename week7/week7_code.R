library(tidyverse)
library(matrixStats)
data <- read.table("~/qb25-answers/week7/rawdata/read_matrix.tsv", header = TRUE, row.names =1)
data <- as.matrix(data)

#added this to correct the plot, used chatGPT to help me with the framework of how to switch two columns
tmp <- data[ , "LFC.Fe_Rep3" ]
data[ , "LFC.Fe_Rep3" ] <- data[ , "Fe_Rep1" ]
data[ , "Fe_Rep1" ]     <- tmp

sds_data <- rowSds(data)
sds_data_sort <- sort(sds_data, decreasing = TRUE)

data_500 <- data[names(sds_data_sort)[1:500], ]
transposed_data <- t(data_500)
pr_data <- prcomp(transposed_data)

pcr_tibble <- pr_data$x[,1:2] %>%
  as_tibble(rownames = "sample") %>%
  separate(sample, into = c("Tissue", "Replicate"), "_")





ggplot(pcr_tibble, aes(x = PC1, y = PC2, color = Tissue, shape = Replicate)) +
  geom_point() +
  theme_classic() +
  labs(
    title = "PCA of top 500 variable genes"
  )+
  theme(
    plot.title = element_text(color = "red")
  )

pca_summary <- tibble(PC=seq(1,length(pr_data$sdev),1),
  sd  = pr_data$sdev
) %>%
  mutate(norm_var=sd^2/sum(sd^2), cum_var=cumsum(norm_var))


pca_summary %>% 
  ggplot(aes(x = PC, y = norm_var)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Variance explained by PCA",
    y = "Percent explained",
    x = "Principal Component"
  ) +
  theme_classic()
    
#Exercise 2:
combined = data[,seq(1, 21, 3)]
combined = combined + data[,seq(2, 21, 3)]
combined = combined + data[,seq(3, 21, 3)]
combined = combined / 3

sds_combined <- rowSds(combined)
combined_filtered <- combined[sds_combined>1, ]
set.seed(42)
km <- kmeans(combined_filtered,centers = 12, nstart = 100)
clusters <- km$cluster

heatmap(combined_filtered, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[clusters], ylab="Gene")


#Excercise 3:
genes_c1 <- names(clusters[clusters == 1])
genes_c11 <- names(clusters[clusters == 11])

cat(genes_c1, sep = "\n")
cat(genes_c11, sep = "\n")
