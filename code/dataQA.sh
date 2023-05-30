#!/bin/sh

threads=6

# Perform fastqc to evaluate data quality
for i in ../input/*_1.fastq.gz; 
do 
    R1=${i}
    R2="../input/"$(basename ${i} _1.fastq.gz)"_2.fastq.gz"
    fastqc -t ${threads} ${R1} ${R2} -o ../outputs/beforeTrim

done

# visose sekose matosi nemažai dublikacijų,
# taip pat galima matyti, kad prasti duomenys per base sequence content, sekų pradžiose ir pabaigose nemaži svyravimai
# prasčiausiai atrodo SRR18214264 duomenys, šiame mėginyje sekos pabaigoje (per base sequence quality) matoma, kad kokybė pasiekia ir raudoną zoną
# bet daugiau duomenys atrodo pakankamai neblogai, jokių adapterių nesimato, bet vis dėlto atlieku triminima, kad gauti dar geresnės kokybės duomenis

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

# bendrai žiūrint, pirmas vaizdas, kad po triminimo duomenys sutprastėjo.
# visose analizėse matome, kad per base sequence content turi didelius šiuolius sekų pabaigose
# vis dar išlieka nemažai dublikacijų. Po triminimo visų suprastėjo sequence length distribution rodiklis.
# bet susitvarkė SRR18214264 mėginio kokybė. 
# iš esmės dauguma duomenų liko nepatikę, yra keletas pokyčių tiek į gerą, tiek į blogą pusę, bet užsitikrinom, kad tikrai neliko adapterių

# Create MultiQC plots for raw and processed data
multiqc ../outputs -o ../outputs/multiq_processed
