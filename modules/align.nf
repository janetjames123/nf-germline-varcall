process ALIGN {
    tag "$sample_id"
    publishDir "${params.outdir}/bam", mode: 'copy'

    container "janet111/align:2.2.1"

    input:
    tuple val(sample_id), path(reads)
    path genome

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam"), path("${sample_id}.sorted.bam.bai"), emit: bam

    script:
    """
    bwa-mem2 index ${genome}
    bwa-mem2 mem -t 4 -R "@RG\\tID:${sample_id}\\tSM:${sample_id}\\tPL:ILLUMINA" \
        ${genome} ${reads[0]} ${reads[1]} | \
        samtools sort -o ${sample_id}.sorted.bam
    samtools index ${sample_id}.sorted.bam
    """
}
