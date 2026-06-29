process VEP {
    tag "$sample_id"
    publishDir "${params.outdir}/vep", mode: 'copy'
    container "ensemblorg/ensembl-vep:release_110.1"

    input:
    tuple val(sample_id), path(vcf)

    output:
    tuple val(sample_id), path("${sample_id}.vep.vcf"), emit: vcf
    tuple val(sample_id), path("${sample_id}.vep.html"), emit: report

    script:
    """
    vep \
        --input_file ${vcf} \
        --output_file ${sample_id}.vep.vcf \
        --format vcf \
        --vcf \
        --symbol \
        --terms SO \
        --tsl \
        --hgvs \
        --fasta ${params.genome} \
        --offline \
        --cache \
        --dir_cache \$VEP_CACHE \
        --stats_file ${sample_id}.vep.html
    """
}
