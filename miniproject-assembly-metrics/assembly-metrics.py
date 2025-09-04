#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1]) # creates a variable that opens whatever the 2nd argument (in this case a file) is called in the command line
contigs = fasta.FASTAReader(my_file) # contigs is creating a variable for the fasta function that will read and process my file
counter = 0 # this is the counter variable used to read each index position (a.k.a the contigs)
sequence_len = 0 #this is the counter variable that will be used to find the cumulative sequence length
my_list = [] #this creates a list that will be used to store the value of the sequence length for each index in the file
for ident, sequence in contigs: #this is looking at index and sequence in the contigs
    counter += 1 #this is adding a value so that the counter increases for every position read in the file
    sequence_len += len(sequence) #this is adding the length of each sequence to a total sequence length
    my_list.append(len(sequence)) # this is appending the value of the sequence length (since the sequence is a string you need to find the length using the len command)
total_len = sequence_len # this variable stores the sequence length after the for loop is running
avg_len = sequence_len // counter  

my_list.sort(reverse=True) #this is sorting the list that has each sequence length 

print(f'There are {counter} contigs in the file. The total length is {sequence_len}. The average length is {avg_len}.')
line2 = 0 #counter variable two, that will count the sequences in the list.
for line in my_list:
    line2 += line #adding the value of the index position to the line2 counter variable
    if line2 >= (total_len/2): #conditional statement that will print the value of the index position the for loop is in after it meets the condition and break the for loop.
        print(f'The N50 is {line}.')
        break

