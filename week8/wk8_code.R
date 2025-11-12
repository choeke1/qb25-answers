library(tidyverse)
library(DESeq2)
library(broom)
#step 1.1
setwd("~/qb25-answers/week8")
counts_data <- read_csv("gtex_whole_blood_counts_downsample.txt")
meta_data <- read_csv("gtex_metadata_downsample.txt")

counts_data[1:5,]
counts_data <- column_to_rownames(counts_data, var = "GENE_NAME") 
meta_data <- column_to_rownames(meta_data, var = "SUBJECT_ID")


counts_data[1:5, ]
meta_data[1:5, ]

table(colnames(counts_data) == rownames(meta_data))

#step 1.2, creatubg DESeq2 Object
dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = meta_data,
                              design = ~ SEX + DTHHRDY + AGE)
#Step 1.3 Normalization and PCA
#storing the variance stabilizing transformation into a variable called 
#variance stabilizing data
vsd <- vst(dds)

png("~/qb25-answers/week8/plots/PCA_SEX.png", 
    width = 800, height = 600)
plotPCA(vsd, intgroup = "SEX")
dev.off()

png("~/qb25-answers/week8/plots/PCA_DTHHRDY.png",
    width = 800, height = 600)
plotPCA(vsd, intgroup = "DTHHRDY")
dev.off()

png("~/qb25-answers/week8/plots/PCA_AGE.png",
    width = 800, height = 600)
plotPCA(vsd, intgroup = "AGE")
dev.off()



#Exercise 2: homemade test for differential analysis
#extract VST expression and bind it to the metadata dataframe
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(meta_data, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()

#Perform differential expression analysis using DESe1
dds <- DESeq(dds)
resultsNames(dds)
#Extract and Interpret the results:
res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")
sig_genes <- res %>% 
  filter(!is.na(padj) & padj < 0.1)
nrow(sig_genes)

wash <- res %>% filter(GENE_NAME == "WASH7P")
slc <- res %>% filter(GENE_NAME == "SLC25A47")

gene_loc <- read_delim("gene_locations.txt")
colnames(gene_loc)

gene_merged <- left_join(res, gene_loc, by = "GENE_NAME") %>%
  arrange(padj)


head(gene_merged, n=50)
print(gene_merged, n = 50)

head(wash)



#repeat for cause of death

res <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")
sig_genes <- res %>% 
  filter(!is.na(padj) & padj < 0.1)
nrow(sig_genes)

wash <- res %>% filter(GENE_NAME == "WASH7P")
slc <- res %>% filter(GENE_NAME == "SLC25A47")

gene_loc <- read_delim("gene_locations.txt")
colnames(gene_loc)

gene_merged <- left_join(res, gene_loc, by = "GENE_NAME") %>%
  arrange(padj)


head(gene_merged, n=50)
print(gene_merged, n = 50)

head(wash)


#Exercise 2.5: estimating false positive rates
meta_perm <- meta_data
meta_perm$SEX <- sample(meta_perm$SEX)
dds_perm <- DESeqDataSetFromMatrix(
  countData = counts_data,
  colData   = meta_perm,
  design    = ~ SEX + DTHHRDY + AGE
)


dds_perm <- DESeq(dds_perm)


res_perm <- results(dds_perm, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_NAME")

sig_perm <- res_perm %>%
  filter(!is.na(padj) & padj < 0.1)

nrow(sig_perm)



#Exercise 3: make a ggplot

ggplot(data = sig_genes , aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point()

ggsave("~/qb25-answers/week8/plots/volcano.png")


