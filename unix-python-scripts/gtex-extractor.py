#! /usr/bin/env python3

gtex_data = open('GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct') #remember to put your file name in quotes. might need the whole path

_ = gtex_data.readline()
_ = gtex_data.readline()
header = gtex_data.readline().rstrip('\n').split('\t')
data = gtex_data.readline().rstrip('\n').split('\t')
my_dict = {}

for line in range(len(data)):
    my_dict[header[line]] = data[line]
gtex_data.close()



second_file = open('GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt')

for line2 in second_file:
    line2 = line2.strip('\n').split('\t')
    SAMPID = line2[0]
    if SAMPID in my_dict:
        print(f'The SAMPID is {SAMPID}, the expression for that SAMPID is {my_dict.get(SAMPID)}, and the STMD is {line2[6]}')

#after running this code in UNIX (./gtex-extractor.py | less -S): the first the tissues 
# with an expression >0 are the: Brain-Cortex, Adrenal Gland, and Thyroid
