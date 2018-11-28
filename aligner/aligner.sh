#!/bin/bash

# Script to align single end demultiplexed clipped fastq files to W303 genome via BWA 
# Script assumes reference files are kept in a directory called reference_files - update paths if this is not the case. 


		
	
bwa index PATH/TO/reference_files/W303_ann_swb_11-29-17.fasta
samtools faidx PATH/TO/reference_files/W303_ann_swb_11-29-17.fasta
# start by indexing your reference genome file 
	
for N5 in 02 03 04 05 06 07 08 17
do
	for N7 in 01 02 03 04 05 06 07 08 09 10 11 12
	do	
	
	bwa aln -n 0.04 -o 1 -e -1 -d 16 -i 0 -O 5 -E 4 PATH/TO/reference_files/W303_ann_swb_11-29-17.fasta PATH/TO/N5$N5\N7$N7\-clipped.fastq > PATH/TO/N5$N5\N7$N7\.sai	

        bwa samse -n 3 PATH/TO/reference_files/W303_ann_swb_11-29-17.fasta PATH/TO/N5$N5\N7$N7\.sai PATH/TO/N5$N5\N7$N7\-clipped.fastq > PATH/TO/N5$N5\N7$N7\.sam
	
	samtools view -bS N5$N5\N7$N7\.sam > N5$N5\N7$N7\.bam
		
	samtools sort N5$N5\N7$N7\.bam N5$N5\N7$N7\-sorted.bam
		
	samtools index N5$N5\N7$N7\-sorted.bam
	done 
done 
