#!/usr/bin/env python3

import sys
file = open(sys.argv[1])
for line in file:
    line = line.strip('\n')
    line = line.split('\t')
    original_score = int(line[4]) #REMEMBER TO CONVERT TO AN INTEGER
    feature_size = (int(line[2]) - int(line[1])) #remember to define the datatype as an integer or else the code won't know the string
    new_score = original_score * feature_size
    if line[5] == '+':
        score = new_score 
    else:
        score = new_score * -1 

    print(f'{line[0]}\t{line[1]}\t{line[2]}\t{line[3]}\t{score}\t{line[5]}')