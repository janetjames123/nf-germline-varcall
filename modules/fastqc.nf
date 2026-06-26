process FASTQC {
    tag "$sample_id"
    publishDir "${params.outdir}/fastqc", mode: 'copy'

    container "janet111/fastqc:0.12.1"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("*.html"), emit: html
    tuple val(sample_id), path("*.zip"),  emit: zip

    script:
    """
    fastqc --threads 2 ${reads[0]} ${reads[1]}
    """
}
