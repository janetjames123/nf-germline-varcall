#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.reads  = "$projectDir/assets/testdata/sample1_{1,2}.fastq.gz"
params.genome = "$projectDir/assets/testdata/ref.fa"
params.outdir = "results"

include { FASTQC }  from './modules/fastqc'
include { TRIM }    from './modules/trim'
include { ALIGN }   from './modules/align'
include { VARCALL } from './modules/varcall'
include { MULTIQC } from './modules/multiqc'

workflow {
    reads_ch = Channel.fromFilePairs(params.reads, checkIfExists: true)

    FASTQC(reads_ch)
    TRIM(reads_ch)
    ALIGN(TRIM.out.reads, params.genome)
    VARCALL(ALIGN.out.bam, params.genome)

    fastqc_files = FASTQC.out.zip.map { sample_id, files -> files }.collect()
    MULTIQC(fastqc_files)
}
