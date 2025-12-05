#!/usr/bin/env python

import sys

import scipy


import numpy as np


genome_size = 1000000
readlength = 100
coverage = 30



num_reads = int((genome_size * coverage) / readlength)

## use an array to keep track of the coverage at each position in the genome
genome_coverage = np.zeros(genome_size)

for i in range(num_reads):

  startpos = int(np.random.uniform(0,genome_size-readlength+1))
  endpos = int(startpos + readlength)
  genome_coverage[startpos:endpos] += 1

## get the range of coverages observed
maxcoverage = int(max(genome_coverage))
xs = list(range(0, maxcoverage+1))

## Get the poisson pmf at each of these
poisson_estimates = scipy.stats.poisson.pmf(xs, mu = coverage) * genome_size
with open("poisson_estimate_30.txt", "w") as f:
    f.write(",".join(str(v) for v in poisson_estimates)) #CHATGPT HELPED ME MAKE THIS A CSV FOR EASY R reading

## Get normal pdf at each of these (i.e. the density between each adjacent pair of points)
normal_estimates = scipy.stats.norm.pdf(xs, loc = coverage, scale = np.sqrt(coverage)) * genome_size
with open("normal_estimate_30.txt", "w") as f:
    f.write(",".join(str(v) for v in normal_estimates)) #CHATGPT HELPED ME MAKE THIS A CSV FOR EASY R reading

## now plot the histogram and probability distributions
with open("genome_coverage_30.txt", "w") as f:
    for value in genome_coverage:
        f.write(f"{int(value)}\n")






