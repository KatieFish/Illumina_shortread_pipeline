#!/bin/bash

# Script to align single end demultiplexed clipped fastq files to W303 genome via BWA 
# Script assumes reference files are kept in a directory called reference_files - update paths if this is not the case. 


		
gunzip /home/GLBRCORG/kjfisher5/Langlab/LOHreads/N5$N5\N7$N7\_read1_paired_trimmed.fastq.gz
gunzip /home/GLBRCORG/kjfisher5/Langlab/LOHreads/N5$N5\N7$N7\_read4_paired_trimmed.fastq.gz
bwa index /home/GLBRCORG/kjfisher5/Langlab/LOHreads/Illumina_shortread_pipeline/reference_files/W303_ann_swb_11-29-17.fasta
samtools faidx /home/GLBRCORG/kjfisher5/Langlab/LOHreads/Illumina_shortread_pipeline/reference_files/W303_ann_swb_11-29-17.fasta
# start by indexing your reference genome file 
	
for N5 in 02 03 04 05 06 07 08 17
do
	for N7 in 01 02 03 04 05 06 07 08 09 10 11 12
	do	
	
	/opt/bifxapps/bwa/bwa mem -k 20 -w 100 -O 5 -E 4 /home/GLBRCORG/kjfisher5/Langlab/LOHreads/Illumina_shortread_pipeline/reference_files/W303_ann_swb_11-29-17.fasta /home/GLBRCORG/kjfisher5/Langlab/LOHreads/N5$N5\N7$N7\_read1_paired_trimmed.fastq.gz /home/GLBRCORG/kjfisher5/Langlab/LOHreads/N5$N5\N7$N7\read4_paired_trimmed.fastq.gz > /home/GLBRCORG/kjfisher5/Langlab/LOHreads/N5$N5\N7$N7\.sam
	
	#bwa aln -n 0.04 -o 1 -e -1 -d 16 -i 0 -O 5 -E 4 PATH/TO/reference_files/W303_ann_swb_11-29-17.fasta PATH/TO/N5$N5\N7$N7\-clipped.fastq > PATH/TO/N5$N5\N7$N7\.sai	

        #bwa samse -n 3 /home/GLBRCORG/kjfisher5/Langlab/LOHreads/Illumina_shortread_pipeline/reference_files/W303_ann_swb_11-29-17.fasta /home/GLBRCORG/kjfisher5/Langlab/LOHread/N5$N5\N7$N7\.sai PATH/TO/N5$N5\N7$N7\-clipped.fastq > PATH/TO/N5$N5\N7$N7\.sam
	
	/opt/bifxapps/samtools/samtools view -bS N5$N5\N7$N7\.sam > N5$N5\N7$N7\.bam
	
	rm N5$N5\N7$N7\.sam 
	
	/opt/bifxapps/samtools/samtools sort N5$N5\N7$N7\.bam -o N5$N5\N7$N7\-sorted.bam
		
	/opt/bifxapps/samtools/samtools index N5$N5\N7$N7\-sorted.bam
	
	
	done 
done 

#hash out to retain sam and sai files 

