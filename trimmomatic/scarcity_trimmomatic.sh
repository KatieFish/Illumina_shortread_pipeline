#!/bin/bash

# Trimmomatic script for paired end reads 
# KJF
# Trimmomatic is a tool that should remove Illumina adapter sequence from our Fastq reads. 

# the script will generate empty files for the other indices. That's ok, we'll just delete them. 

for N5 in 02 03 04 05 06 07 08 17
do

echo N5$N5

        for N7 in 21 22 23 24 26 27 
        do

echo N7$N7

        
java -jar /opt/bifxapps/Trimmomatic-0.30/trimmomatic-0.30.jar PE -phred33 Read_1_N5$N5\N7$N7\-read-1.fastq.gz Read_4_N5$N5\N7$N7\-read-1.fastq.gz N5$N5\N7$N7\_read1_paired_trimmed.fastq.gz N5$N5\N7$N7\_read1_unpaired_trimmed.fastq.gz N5$N5\N7$N7\_read4_paired_trimmed.fastq.gz N5$N5\N7$N7\_read4_unpaired_trimmed.fastq.gz ILLUMINACLIP:/opt/bifxapps/Trimmomatic-0.30/adapters/TruSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3  MINLEN:36

rm N5$N5\N7$N7\_read4_unpaired_trimmed.fastq.gz
rm N5$N5\N7$N7\_read1_unpaired_trimmed.fastq.gz

echo through the jar
 
	done    
done
