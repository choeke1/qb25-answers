#!/usr/bin/env python3



 
file = open("/Users/cmdb/qb25-answers/week3/DP.txt", "w")
for line in open("/Users/cmdb/qb25-answers/week3/biallelic.vcf"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    # grab what you need from `fields`
    info = fields[7].split(';')
    for line2 in info:
        if line2.startswith('AF'):
            print(line2[3:])
    #I copy pasted this print output into a file named AF.txt, hehe I did it the "right way" for ex2.3
    
    info2 = fields[9:]
    #info2 is my list of the biallelic file from column 2 onwart

    #opening my new file

    for entry in info2:
        quantbio = entry.split(':')
        #quantbio is list split by the colons
        file.write(f"{quantbio[2]}\n")












        