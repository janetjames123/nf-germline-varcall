process MULTIQC {
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    container "janet111/multiqc:1.19"

    input:
    path qc_files

    output:
    path "multiqc_report.html", emit: report

    script:
    """
    multiqc .
    """
}
