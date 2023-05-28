#!/bin/sh

# Using Gepard tool create dotplots to show similarities/dissimilarities between your samples. Describe, your results
# Visuose palyginimuose susiformavo įstrižainė (kairio viršaus į dešinę apačią), tai parodo didelį panašumą tarp sekų. 
# Visuose palyginimuose tose pačiose vietose matomi trūkio taškai, todėl tose vietose sekos nesutampa.
# Tatip pat dešiniame kampe matosi stačiakampiai (Vienose ryškesnis, kitose mažiau ryškus), jis parodo, kad sekų galuose yra dublikatų. 

# Using BUSCO analysis tool, evaluate assemblies.
#???????

# Made genes prediction with GeneMarkS-2. Outputs are in outputs/GeneMarkS-2 directory.
# Predicted and annotated genes with RAST. Outputs are in reports/rast directory

# Using CP015498 genes and proteins models as well as local blast, predict genes in assemblies

for i in ../outputs/genomes/*_configs.fasta
do
makeblastdb -in $i -dbtype prot -parse_seqids
done

for i in ../outputs/genomes/*_configs.fasta
do
    base=$(basename $i _configs.fasta)
    tblastn -db ../outputs/genomes/${base}_configs.fasta -query ../ref/CP015498_pro.txt > ../outputs/blast/${base}_tblastn.txt
done

for i in ../outputs/genomes/*_configs.fasta
do
makeblastdb -in $i -dbtype nucl -parse_seqids
done

for i in ./genomes/*_configs.fasta
do
    base=$(basename $i _configs.fasta)
    blastn -db ../outputs/genomes/${base}_configs.fasta -query ../ref/CP015498_nuc.txt > ../outputs/blast/${base}_blastn.txt
done
