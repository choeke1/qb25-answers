# WEEK8 Answers
## Exercise 1.3:
Based on the PCA test, 55% of the variance in the data can be explained by the first two PCAs. PCA1 comprising 48% of variance and PCA2 only 7%. After completing the PCA analysis with different interest groups, it is clear the the variance in the data is largely attributable to the cause of death. This shows that large transcriptional differences can be attributed to the different states of patients' health. Looking at age as the interest group can also loosely fit to the first PCA differences. However, across the three interest groups there is clear separation across PC2.


## Exercise 2.1:
Based on the regression, there does seem to be upregulation in males for the WASH7P gene because the correlation estimate is positive (.118) However, this is not a significant difference as the p-value for this regression is p = ~.28

Based on the linear regression for the SLC25A47 gene, there is a higher level of expression in males than females denoted by the estimate value of .518. There is a significant upregulation in this sex as confirmed by the p-value of .0259.

## Excercise 2.3
There are 262 genes that are differentially expressed between males and females at 10% FDR.

18 of the top 20 differentially expressed genes are found on the Y chromosome, the other two are found on the X chromosome. This makes sense that the genes with the highest variation between sexes would be found on the sex specific chromosomes. There are many more Y-linked genes

After performing DESeq on the WASH7 gene, the results are consistent with the previous linear regression model. There is a .0896 positive log2FoldChange, consistent with the slight increase in expression in males. The p-value is .46, consistent with the non-significant resutls. For the SLC gene, there is a more significant increase (log2FoldChange of 3.06) as well as a v value of 1e-9, consistent with the previous findings.


There is a balance between false positives and false negatives depedning on the FDR threshold used. A stringent threshold like 1% reduces false positives but increases the chance of missing true DE genes (false negatives). A more lenient cutoff increases sensitivity but allows more false positives. Power to detect true differences depends on both effect size and sample size: genes with strong expression differences or data from more subjects are easier to detect,while small effect sizes or limited sample numbers reduce power and increase the risk of false negatives.

## Exercise 2.4:

There are 16,069 differentially expressed with an FD of 10% according to the DESeq

## Exercise 2.5:
In the real (non-permuted) analysis, 16,069 genes were significant at FDR < 0.1. After permuting the grouping variable, 1,624 genes met the same threshold. Because all hits in the permuted analysis are false positives, this suggests an empirical false discovery proportion of ~10% — consistent with the nominal FDR. Thus, DESeq2’s multiple-testing correction appears to appropriately control false discoveries in this dataset.
