#!/bin/bash
#SBATCH -p medium
#!/bin/bash
#SBATCH -p medium
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 30
##SBATCH -a 1-24
#SBATCH -t 01:00:00
#SBATCH -C scratch
##SBATCH -o outfile_array-%A-%a.out
#SBATCH -o outfile_%J.out
##SBATCH -e errorfile_array-%A-%a.err
#SBATCH -e errorfile_%J.err

#module purge
#module load star

# Run featurecounts on RNA-seq dataset

SCRATCH_HOME=/scratch/users/ldang1
PathToGenomeAnnotation=~/NicoLab/Drosophila_genome_reference/dvir-all-r1.07.gtf
PathToFeatureCounts=~/Softwares/subread-2.0.2-source/bin/featureCounts
Dir2RNAseqBAMfile="${SCRATCH_HOME}/OutDir/RNAseq/dataset2/STAR_Map_OutDir_ByName"
Dir2OutFile="${SCRATCH_HOME}/OutDir/RNAseq/dataset2/featureCounts_OutDir"
Path2FileName=~/NicoLab/Scripts/UniqueID/uniq_SF_H16678_H16701_03_Dan_RNAseq_dataset2_mini.txt

${PathToFeatureCounts} -T 30 -s 0 -J \
-p --countReadPairs -B -C \
-a ${PathToGenomeAnnotation} \
-o "${Dir2OutFile}/CountMatrix_sortedByName_s0.txt" \
$Dir2RNAseqBAMfile/*.out.bam