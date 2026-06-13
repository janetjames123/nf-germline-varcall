process MULTIQC {
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    conda 'bioconda::multiqc=1.19'

    input:
    path qc_files

    output:
    path "multiqc_report.html", emit: report

    script:
    """
    multiqc .
    """
}
