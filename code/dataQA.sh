#!/bin/sh

threads=6

# Perform fastqc to evaluate data quality
for i in ../input/*_1.fastq.gz; 
do 
    R1=${i}
    R2="../input/"$(basename ${i} _1.fastq.gz)"_2.fastq.gz"
    fastqc -t ${threads} ${R1} ${R2} -o ../outputs/beforeTrim

done

# Data trimming 
for i in ../input/*_1.fastq.gz; 
do 
    R1=${i}
    R2="../input/"$(basename ${i} _1.fastq.gz)"_2.fastq.gz"
    trim_galore -j ${threads} --length 20 -o ../outputs/trimmedData --paired  ${R1} ${R2}
done