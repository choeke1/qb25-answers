#!/usr/bin/env python3
 
file = open("/Users/cmdb/qb25-answers/week3/biallelic.vcf")

output_file = open("/Users/cmdb/qb25-answers/week3/gt_long.txt","w")

# sample IDs (in order, corresponding to the VCF sample columns)
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

# open the VCF file
for line in file:
    if line.startswith('#'):
        continue

    fields = line.rstrip('\n').split('\t') # to strip and split the file by new lines and tabs
    chrom = fields[0]
    pos   = fields[1]
    index = 9 # this sets the position needed for analyzing the sample data in the vcf file
    for samp_id in sample_ids:
        sample_column = fields[index]
        index +=1
        column_info = sample_column.split(":")
        genotype_info = column_info[0]
        if genotype_info == "0":
            genotype = "0"
        elif genotype_info == "1":
            genotype = "1"
        else:
            continue
        output_file.write(f"{samp_id}\t{chrom}\t{pos}\t{genotype}\n")


file.close()
output_file.close()


    
    # for each sample in sample_ids:
        # get the sample's data from fields[9], fields[10], ...
        # genotypes are represented by the first value before ":" in that sample's data
        # if genotype is "0" then print "0"
        # if genotype is "1" then print "1"
        # otherwise skip