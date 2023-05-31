#!/bin/sh

#Genomes assembly using spades program
for i in ../outputs/trimmedData/*_1_val_1.fq.gz 
do 
    R1=${i}
    R2="../outputs/trimmedData2/"$(basename ${i} _1_val_1.fq.gz)"_2_val_2.fq.gz"
    spades.py -o "../outputs/"$(basename ${i} _1_val_1.fq.gz)"_spades2" --pe1-1 ${R1} --pe1-2 ${R2}

done

# Second genomes assembly is made with abyss
abyss-pe k=64 name=ERR204044 -C ../outputs/abyss/ERR204044_abyss in='../../../outputs/trimmedData/ERR204044_1_val_1.fq.gz ../../../outputs/trimmedData/ERR204044_2_val_2.fq.gz'
abyss-pe k=64 name=SRR15131330 -C ../outputs/abyss/SRR15131330_abyss in='../../../outputs/trimmedData/SRR15131330_1_val_1.fq.gz ../../../outputs/trimmedData/SRR15131330_2_val_2.fq.gz'
abyss-pe k=64 name=SRR18214264 -C ../outputs/abyss/SRR18214264_abyss in='../../../outputs/trimmedData/SRR18214264_1_val_1.fq.gz ../../../outputs/trimmedData/SRR18214264_2_val_2.fq.gz'

# Evaluated assemblies using Quast, reference genome CP015498. Made it using usegalaxy.eu. Reports are in folder "reports"

# Visų genomų yra pakankamai panašūs rezultatai, bet kiekvienas turi savo trūkumų. Visi susirinko apie 75%-80% genomo dalies, tai jau yra reikšminga genomo dalis. 
# Jų dubliavimosi santykis buvo virš 1, todėl galima numanyti, kad genome yra besikartojančių sekų, duklikacijų. Bet rezultatai yra pakankamai arti .
# 1-1,3mln bazių porų buvo paveiktos netikslių surinkimų, tai gana stipriai paveikia surinkimo kokybę. 
# Bendras kontigų ilgis yra apie 1,8mln-2mln bazių porų. Bendrai paėmus rezultatai yra neblogi, dirbant su spades daugumoje resultatai išėjo geresni.

# SRR18214264. Darant su abyss gauname mažesnę padengtą genomo dalį, mažesnę NGA50 vertę, didesnį neatitikimo rodiklį ir šiek tiek didesnį dubliavimo koeficientą.
# Tačiau jis taip pat turi didesnę LGA50 vertę, o tai gali rodyti geresnes suderintų fragmentų derinimo charakteristikas. Todėl rinksiuos dirbti su spades padarytų surinkimu. 
# ERR204044. Darant su abiem programomis gauname labai panašius duomenis. Dirbant su spades gauname šiek tiek didesnę padengto genomo dalį. Todėl toliau dirbsiu su spades. 
# SRR15131330. Darant su spades gauname didesnę genomo dalį, didesnę NGA50 vertę, 
# bet ir didesnį nesuderinamumą ir netinkamai surinktų kontigų ilgį bei didesnį neatitikimo dažnį ir dubliavimosi santykį. Tęsim darbą su abyss.

ragtag.py scaffold -o ../outputs/scaffolds_ragtag ../ref/CP015498.fasta ../outputs/genomes/SRR15131330_configs.fasta
ragtag.py scaffold -o ../outputs/scaffolds_ragtag ../ref/CP015498.fasta ../outputs/genomes/SRR18214264_configs.fasta
ragtag.py scaffold -o ../outputs/scaffolds_ragtag ../ref/CP015498.fasta ../outputs/genomes/ERR204044_configs.fasta

# coping selected genomes with which I will continue to work
cp ../outputs/SRR18214264_spades/contigs.fasta ../outputs/genomes/SRR18214264_configs.fasta
cp ../outputs/ERR204044_spades/contigs.fasta ../outputs/genomes/ERR204044_configs.fasta
cp ../outputs/abyss/SRR15131330_abyss/SRR15131330-contigs.fa ../outputs/genomes/SRR15131330_configs.fasta

# Using appropriate mapper, map original reads to you assemblies
for i in ../outputs/trimmedData/*_1_val_1.fq.gz
do
    R1=${i}
    R2="../outputs/trimmedData2/"$(basename ${i} _1_val_1.fq.gz)"_2_val_2.fq.gz"
    bwa index ../outputs/genomes/"$(basename ${i} _1_val_1.fq.gz)"_configs.fasta
    bwa mem -t 6 ../outputs/genomes/"$(basename ${i} _1_val_1.fq.gz)"_configs.fasta ${R1} ${R2} 2> ../outputs/mapping/"$(basename ${i} _1_val_1.fq.gz)"_bwa.txt |\
    samtools view -bS -@ 6 | samtools sort -@ 6 -o ../outputs/mapping/"$(basename ${i} _1_val_1.fq.gz)".bam
    samtools stats -in ../outputs/mapping/"$(basename ${i} _1_val_1.fq.gz)".bam > ../outputs/mapping/"$(basename ${i} _1_val_1.fq.gz)"_map_stats.txt
done

# ERR204044. Sumappinti ir suporuoti readai 6051168, iš jų teisingai suporuoti 5642658. Viso suporuotų readų procentas 92,9% 
# Klaidų dažnis 1.564794e-03 (pakankamai mažas). Vidutinis kokybės balas 36,1. Visi duomenys rodo pakankamai gerą rezultatą.
# SRR15131330. Sumappinti ir suporuoti readai 28345382, iš jų teisingai suporuoti 24384580. Viso suporuotų readų procentas 85,5% (mažiausias iš visų).
# Klaidų dažnis 2.054390e-03 (šiek tiek didesnis nei ankstesnio surinkimo). Vidutinis kokybės balas 36,2. 
# Šis surinkimas turi didesnį dataset, bet kiti rodikliai rodo surinkimas prastesnės kokybės.
# SRR18214264. Sumappinti ir suporuoti readai 4273832, iš jų teisingai suporuoti 4185612. Viso suporuotų readų procentas 97.5% (didžiausias iš visų).
# Klaidų dažnis 9.022661e-03 (žymiai didesnis už kitus). Vidutinis kokybės balas 32. Palyginus rezultatus su ankstesniais pavyzdžiais, 
# šiame datasete yra mažesnis visų sekų skaičius ir susietų skaitymų skaičius, tačiau tinkamai suporuotų readų procentas yra didesnis.