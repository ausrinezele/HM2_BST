
# compare number of predicted genes and genes overlap.
BiocManager::install("rtracklayer")
library(dplyr)
library(rtracklayer)
library(magrittr)

#*********************************************************************************
ERR204044_rast <- rtracklayer::import('ERR204044_rast.gtf')
ERR204044_rast = as.data.frame(ERR204044_rast) 
nrow(ERR204044_rast) 
# 2748-1 genai po rast(pirma eilute headeris)

ERR204044_GeneMarkS <- read.table("ERR204044_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(ERR204044_GeneMarkS$V9[grep("gene_id", ERR204044_GeneMarkS$V9)]))
print(num_genes)
#2306 po GeneMarkS.out

ERR204044_tblastn <- readLines("ERR204044_tblastn.txt")
num_genes <- 0
for (line in ERR204044_tblastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# 2100 po blast kai lyginam protein

ERR204044_blastn <- readLines("ERR204044_blastn.txt")
num_genes <- 0
for (line in ERR204044_blastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# ir tiek pat nukleotidų

#*********************************************************************************
SRR15131330_rast <- rtracklayer::import('../reports/rast/SRR15131330_rast.gtf')
SRR15131330_rast = as.data.frame(SRR15131330_rast)
nrow(SRR15131330_rast) 
# 3262-1 genai po rast(pirma eilute headeris)

SRR15131330_GeneMarkS <- read.table("/home/bioinformatikai/HW2_BST/outputs/GeneMarkS-2 /ERR204044_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(SRR15131330_GeneMarkS$V9[grep("gene_id", SRR15131330_GeneMarkS$V9)]))
print(num_genes)
#2306 po GeneMarkS.out

SRR15131330_tblastn <- readLines("SRR15131330_tblastn.txt")
num_genes <- 0
for (line in SRR15131330_tblastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# 2100 po blast kai lyginam protein

SRR15131330_blastn <- readLines("SRR15131330_blastn.txt")
num_genes <- 0
for (line in SRR15131330_blastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# ir tiek pat nukleotidų

#*********************************************************************************
SRR18214264_rast <- rtracklayer::import('SRR18214264_rast.gtf')
SRR18214264_rast = as.data.frame(SRR18214264_rast)
nrow(SRR18214264_rast) 
# 3262-1 genai po rast(pirma eilute headeris)

SRR18214264_GeneMarkS <- read.table("SRR18214264_GeneMarkS.out", sep="\t", stringsAsFactors = FALSE)
num_genes <- length(unique(SRR18214264_GeneMarkS$V9[grep("gene_id", SRR18214264_GeneMarkS$V9)]))
print(num_genes)
#2332 po GeneMarkS.out

SRR18214264_tblastn <- readLines("SRR18214264_tblastn.txt")
num_genes <- 0
for (line in SRR18214264_tblastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# 2100 po blast kai lyginam protein

SRR18214264_blastn <- readLines("SRR18214264_blastn.txt")
num_genes <- 0
for (line in SRR18214264_blastn) {
  if (startsWith(line, "Query=")) {
    num_genes <- num_genes + 1
  }
}
print(num_genes)
# ir tiek pat nukleotidų