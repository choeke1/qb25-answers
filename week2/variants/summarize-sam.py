#!/usr/bin/env python3



import sys



sam_file = open(sys.argv[1])

my_dict = {}
nm_dict = {}

for line in sam_file:
    
    if line.startswith ("@"):
        continue
    line = line.strip('\n')
    line = line.split('\t') 

  
    if line[2] in my_dict:
        my_dict[line[2]] += 1
    else:
        my_dict[line[2]] = 1


    for tag in line[11:]:
        if tag.startswith("NM:i:"):
            nm = int(tag[5:])
            if nm in nm_dict:
                nm_dict[nm] += 1
            else: 
                nm_dict[nm] = 1
            break


# print chromosome counts in the default dict .keys() order
print("Chromosome counts:")
for key in my_dict.keys():
    print(key, my_dict[key])

print()

# print NM counts in numeric order
print("NM tag counts:")
for s in sorted(nm_dict.keys()):
    print(s, nm_dict[s])


