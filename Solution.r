if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("Rsubread")
BiocManager::install("Rsamtools")
library(Rsubread)
library(Rsamtools)

# assume that a reference file and illumina reads files are in the same folder which is 'MyPath'

runMapping = function(MyPath, reference_file_name, reads_file_name, result_file_name){
  ref = file.path(MyPath, reference_file_name)
  buildindex(basename=file.path(MyPath,"reference_index"),reference=ref)
  reads <- file.path(MyPath,reads_file_name)
  align(index=file.path(MyPath,"reference_index"),readfile1=reads,output_file=file.path(MyPath, result_file_name), nthreads = 10)
}

readResultFile = function(Path_To_Result_File){
  bam <- scanBam(Path_To_Result_File)
  return (table(bam[[1]]$rname))
}

MyPath = file.path(getwd(), "RNAseq_DiffEx_Data")
reference_file_name = "transcripts.fasta"
reads_file_name = "OreR72hA_transcripts.fastq"
result_file_name = "OreR72hA_result.bam"

runMapping(MyPath, reference_file_name, reads_file_name, result_file_name)

res = readResultFile(file.path(MyPath, result_file_name))