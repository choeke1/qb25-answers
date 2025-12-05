#!/usr/bin/env python3

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
k = 3
graph = set()

# I had no idea how to do this, and the pseudocode was starting to confuse me. I had to consult CHATGPT
for read in reads:
    for i in range(len(read) - k + 1):
        kmer = read[i:i+k]         # 3-letter k-mer
        prefix = kmer[:k-1]        # first 2 letters
        suffix = kmer[1:]          # last 2 letters
        graph.add((prefix, suffix))

# Write DOT file
with open("wk11_ex2.dot", "w") as f:
    f.write("digraph {\n")
    for (a, b) in graph:
        f.write(f'    "{a}" -> "{b}";\n')
    f.write("}\n")

print("Wrote wk11_ex2.dot")



