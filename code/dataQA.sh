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
    trim_galore -j ${threads} --length 20 --quality 20 -o ../outputs/trimmedData2 --paired  ${R1} ${R2}
done


#Fastqc on trimmed data
for i in ../outputs/trimmedData/*_1_val_1.fq.gz 
do 
    R1=${i}
    R2="../outputs/trimmedData/"$(basename ${i} _1_val_1.fq.gz)"_2_val_2.fq.gz"
    fastqc -t ${threads} ${R1} ${R2} -o ../outputs/afterTrim

done

# Create MultiQC plots for raw and processed data
multiqc ../outputs -o ../outputs/multiq_processed
