#!/bin/bash
#command to see the number of lines
wc -l ce11_genes.bed
# the answer is 53935
cut -f 1 ce11_gene.bed | uniq -c # -f in the cut command, represents the features (aka columns) then count the number of lines for each unique variable in this column # the -c is the count feature
#5460 chrI
#12 chrM
#9057 chrV
#6840 chrX
#6299 chrII
#21418 chrIV
#4849 chrIII
cut -f ce11_gene.bed | sort| uniq -c
# 26626 -
# 27309 +


#for question 3
cut -f 7 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort| uniq -c | sort -r | head -n 3 
# 3288 Whole Blood
# 1132 Muscle - Skeletal
# 867 Lung
cut -f 12 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt |sort|grep RNA| wc -l
#20016

#executed the following commands seperately and subtracted the outputs from this:
cut -f 12 GTex_Analysis_v8_Annotations_SampleAttributesDS.txt |wc
#and this: 
cut -f 12 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt |sort|grep RNA| wc -l
# 2935