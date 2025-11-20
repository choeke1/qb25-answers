#!/usr/bin/env python3

import sys

import numpy as np

from fasta import readFASTA


#====================#
# Read in parameters #
#====================#

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code


# Read the scoring matrix into a dictionary
fs = open(sys.argv[2])
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

gap_penalty = float(sys.argv[3])

# Read in the actual sequences using readFASTA
input_sequences = readFASTA(open(sys.argv[1]))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]


#=====================#
# Initialize F matrix #
#=====================#

F_matrix1 = np.zeros((len(sequence1)+1, len(sequence2)+1), dtype=int)


#=============================#
# Initialize Traceback Matrix #
#=============================#
traceback_matrix = np.empty((len(sequence1) +1, len(sequence2) +1), dtype = str)




#populate the matrix with the gap penalty initially
for j in range(1, len(sequence2) + 1):
	F_matrix1[0, j] = F_matrix1[0, j-1] + gap_penalty
	traceback_matrix[0, j] = "h"
	
for i in range(1, len(sequence1) + 1):
	F_matrix1[i,0] = F_matrix1[i-1,0] + gap_penalty
	traceback_matrix[i,0] = "v"


#===================#
# Populate Matrices #
#===================#
for i in range(1, len(sequence1)+ 1):
	for j in range (1, len(sequence2) +1 ):
		v_score = gap_penalty + F_matrix1[i-1, j] #adding from the row above
		h_score = gap_penalty + F_matrix1[i, j-1] #adding from the box to the left
		d_score = sigma[(sequence1[i-1], sequence2[j-1])] + F_matrix1[i-1, j-1] 
		F_matrix1[i,j] = max(v_score, h_score, d_score)
		if F_matrix1[i,j] == d_score:
			traceback_matrix[i,j] = "d"   # aligning wins ties
		elif F_matrix1[i,j] == h_score:
			traceback_matrix[i,j] = "h"   # gap in seq1 next
		else:
			traceback_matrix[i,j] = "v"


#========================================#
# Follow traceback to generate alignment #
#========================================#
sequence1_alignment = ""
sequence2_alignment = ""

i = len(sequence1)
j = len(sequence2)

while i > 0 or j >0:
	if traceback_matrix[i,j] == "d":
		sequence1_alignment += sequence1[i-1]
		sequence2_alignment += sequence2[j-1]
		i -= 1
		j -= 1
	elif traceback_matrix[i,j] == "h":
		sequence1_alignment += "-"
		sequence2_alignment += sequence2[j-1]
		j -= 1
	else:
		sequence1_alignment += sequence1[j-1]
		sequence2_alignment += "-"
		i -= 1 
		




#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.
out_file = sys.argv[4]
output = open(out_file, 'w')

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


gaps_seq1 = sequence1_alignment.count('-')
gaps_seq2 = sequence2_alignment.count('-')

print(gaps_seq1)
print(gaps_seq2)

#=============================#
# Calculate sequence identity #
#=============================#

matches = identity_alignment.count('|')
total_length_seq1 = len(sequence1)
percent_identity_seq1 = matches / total_length_seq1 * 100
print(percent_identity_seq1)

total_length_seq2 = len(sequence2)
percent_identity_seq2 = matches / total_length_seq2 * 100
print(percent_identity_seq2)


i = len(sequence1)
j = len(sequence2)
alignment_score = F_matrix1[i,j]

print(alignment_score)
#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score
