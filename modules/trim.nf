process TRIM {
    tag "$sample_id"
    publishDir "${params.outdir}/trimmed", mode: 'copy'

    container "janet111/trim:0.39"

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_{1,2}_trimmed.fastq.gz"), emit: reads

    script:
    """
    trimmomatic PE ${reads[0]} ${reads[1]} \
        ${sample_id}_1_trimmed.fastq.gz ${sample_id}_1_unpaired.fastq.gz \
        ${sample_id}_2_trimmed.fastq.gz ${sample_id}_2_unpaired.fastq.gz \
        LEADING:3 TRAILING:3 MINLEN:36
    """
}
