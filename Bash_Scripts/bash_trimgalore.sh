#!/bin/bash
#SBATCH -p medium
#SBATCH -c 24
#SBATCH -t 04:00:00
#SBATCH -C scratch
#SBATCH -o outfile_parallel-%J.out
#SBATCH -e errorfile-%J.err

module purge
module load trimgalore

DataSetName=SF_H16678_H16701_03_Dan_RNAseq_dataset2
DirToOutFile="/scratch/users/ldang1/OutDir/$DataSetName"
DirToFastqFile="/scratch/users/ldang1/ATACseq_RNAseq_Reads/$DataSetName"

parallel -j 24  trim_galore --paired --illumina --stringency 3 --length 30 \
--retain_unpaired --fastqc -o "$DirToOutFile"  \
"$DirToFastqFile/{}_R1_001.fastq.gz" \
"$DirToFastqFile/{}_R2_001.fastq.gz" < "uniq_${DataSetName}.txt"
