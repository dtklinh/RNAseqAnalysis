#!/bin/bash
#SBATCH -p medium
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 30
#SBATCH -a 1-24
#SBATCH -t 02:00:00
#SBATCH -C scratch
#SBATCH -o outfile_array-%A-%a.out
#SBATCH -e errorfile_array-%A-%a.err

module purge
module load star

# mapping paired-end reads to genome for RNA-seq data analysis

SCRATCH_HOME=/scratch/users/ldang1
DirToGenomeRef="${SCRATCH_HOME}/Drosophila_Virilis_genome_reference"
DirToReadFiles="${SCRATCH_HOME}/OutDir/SF_H16678_H16701_03_Dan_RNAseq_dataset2"
Dir2RNAseqResults="${SCRATCH_HOME}/OutDir/RNAseq/dataset2/STAR_Map_OutDir"
FileName=uniq_SF_H16678_H16701_03_Dan_RNAseq_dataset2.txt

STAR --runThreadN 30 \
--genomeDir "${DirToGenomeRef}" \
--readFilesIn "${DirToReadFiles}/$(head -n ${SLURM_ARRAY_TASK_ID} $FileName| tail -n1)_R1_001_val_1.fq.gz" \
"${DirToReadFiles}/$(head -n ${SLURM_ARRAY_TASK_ID} $FileName| tail -n1)_R2_001_val_2.fq.gz" \
--outFileNamePrefix "${Dir2RNAseqResults}/$(head -n ${SLURM_ARRAY_TASK_ID} $FileName| tail -n1)_" \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--readFilesCommand zcat
