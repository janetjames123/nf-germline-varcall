process VARCALL {
    tag "$sample_id"
    publishDir "${params.outdir}/vcf", mode: 'copy'

    conda 'bioconda::gatk4=4.4.0.0 bioconda::samtools'

    input:
    tuple val(sample_id), path(bam), path(bai)
    path genome

    output:
    tuple val(sample_id), path("${sample_id}.vcf.gz"), emit: vcf

    script:
    """
    samtools faidx ${genome}
    gatk CreateSequenceDictionary -R ${genome}
    gatk HaplotypeCaller \
        -R ${genome} \
        -I ${bam} \
        -O ${sample_id}.vcf.gz \
        -ERC GVCF
    """
}
