#!/bin/sh

# Using Gepard tool create dotplots to show similarities/dissimilarities between your samples. Describe, your results
# Visuose palyginimuose susiformavo įstrižainė (kairio viršaus į dešinę apačią), tai parodo didelį panašumą tarp sekų. 
# Visuose palyginimuose tose pačiose vietose matomi trūkio taškai, todėl tose vietose sekos nesutampa.
# Taip pat dešiniame kampe matosi stačiakampiai (Vienose ryškesnis, kitose mažiau ryškus), jis parodo, kad sekų galuose yra dublikatų. 

# Using BUSCO analysis tool, evaluate assemblies.
# Gavau gerus completeness rezultatus 96% sukompiliuoti BUSCOs. Labai nedidelė dalis sukompiliuoto buvo dublikatai ~1%
# Fragmetuotos sudarok ~1,5% ir gauname, kad trūksta tik ~2,5%
# Gauti 668 scaffolds ir kontigai, kurių bendras ilgi truputi virš 2mln. Jų išėjo palyginus nedidelis N50 rodiklis.
# Bendrai galima amtyti, kad yra neblogas užbaigtumas, bet būtų galima tobulinti surinkimo vientisumą. 

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
    tblastn -db ../outputs/genomes/${base}_configs.fasta -query ../ref/CP015498_pro.txt -out ../outputs/blast/${base}_2_tblastn.txt -outfmt "6"
done

for i in ../outputs/genomes/*_configs.fasta
do
makeblastdb -in $i -dbtype nucl -parse_seqids
done

for i in ./genomes/*_configs.fasta
do
    base=$(basename $i _configs.fasta)
    blastn -db ../outputs/genomes/${base}_configs.fasta -query ../ref/CP015498_nuc.txt -out ../outputs/blast/${base}_2_blastn.txt -outfmt "6"
done

# compare number of predicted genes and genes overlap.
# code for calculating predicted genes are in file genePredictionCount.R

# ring diagrams are in reports/ring_diagrams
# tree from 16S sequences was made with seaview and located in reports/trees

# From your/BUSCO predictions, select five proteins and create a multi-gene tree
# duomenis atsisiunčiau iš rast ir ncbi, gauti medžiai reports/trees direktorijoje
# 1) DNA primase
# 2) DNA recombination and repair protein RecFD
# 3) signal peptidase I 
# 4) DNA polymerase III subunit gamma/tau
# 5) DNA topoisomerase IV subunit B 

# Compare your phylogenetic trees.
# Medžiai išsaugojo labai panašias savybes, ERR204044 ir SRR18214264 yra labai panašūs,
# SRR15131330 mėginys skiriasi nuo anksčiau minėtų. 
# Referentinis šiek tiek skiriasi nuo mėginių, bet visada išlieka pakankamai arti (Su skirtingais baltymai situacija būna truputi skirtinga)
# Outgroup baltymai laikosi netoli tų pačių baltymų kituose mėginiuose, bet visada yra atokiausi.
# Tik DNA primase baltymas outgroup mėginyje priklauso kitai šakai nei DNA primase kitose mėginiuose

# Using all data you got, can you identify if any of you genomes are more similar to each other than to the third one (or reference genome)?
# ERR204044 ir SRR18214264 šie mėginiai yra panašesni eni trečiasis. Tai galima matyti tiek iš trees, tiek iš ring diagramos,
# tiek ir dotplots. Referentinis genomas taip pat yra pakankamai panašus su visai, bet panašiausias į SRR15131330