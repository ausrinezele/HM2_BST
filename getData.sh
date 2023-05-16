#!/bin/sh

# Download raw FASTQ files
prefetch ERR204044
prefetch SRR15131330 SRR18214264
fastq-dump --gzip --split-files ERR204044 SRR15131330 SRR18214264
mv code/* input/ && mv input/*.sh code/