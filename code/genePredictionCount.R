
# compare number of predicted genes and genes overlap.
BiocManager::install("rtracklayer")
library(dplyr)
library(rtracklayer)
library(magrittr)

#*********************************************************************************
# ERR204044_rast -> 2564
# SRR15131330_rast -> 2774
# SRR18214264_rast -> 2518

ERR204044_GeneMarkS <- read.table("/home/bioinformatikai/HW2_BST/outputs/GeneMarkS-2/ERR204044_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(ERR204044_GeneMarkS$V9[grep("gene_id", ERR204044_GeneMarkS$V9)]))
print(num_genes)
#2306 

SRR15131330_GeneMarkS <- read.table("/home/bioinformatikai/HW2_BST/outputs/GeneMarkS-2/ERR204044_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(SRR15131330_GeneMarkS$V9[grep("gene_id", SRR15131330_GeneMarkS$V9)]))
print(num_genes)
#2306 

SRR18214264_GeneMarkS <- read.table("/home/bioinformatikai/HW2_BST/outputs/GeneMarkS-2/SRR18214264_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(SRR18214264_GeneMarkS$V9[grep("gene_id", SRR18214264_GeneMarkS$V9)]))
print(num_genes)
#2332

awk -F'\t' '{print $1}' ../outputs/blast/ERR204044_2_tblastn.txt | sort -u | wc -l
# 2091
awk -F'\t' '{print $1}' ../outputs/blast/SRR15131330_2_tblastn.txt | sort -u | wc -l
# 2094
awk -F'\t' '{print $1}' ../outputs/blast/SRR18214264_2_tblastn.txt | sort -u | wc -l
# 2089