#!/bin/bash
#SBATCH -p medium
#SBATCH -c 20
#SBATCH -t 04:00:00
#SBATCH -C scratch
#SBATCH -o outfile_parallel-%J.out
#SBATCH -e errorfile-%J.err

module purge
module load star

DirToGenome=~/NicoLab/Drosophila_genome_reference
GenomeFastaFile="${DirToGenome}/dvir-all-chromosome-r1.07.fasta"
AnnotationFile="${DirToGenome}/dvir-all-r1.07.gtf"

STAR --runMode genomeGenerate --runThreadN 20 --genomeDir "${DirToGenome}" \
--sjdbGTFfile "${AnnotationFile}" --genomeSAindexNbases 14 \
--genomeFastaFiles "${GenomeFastaFile}"
