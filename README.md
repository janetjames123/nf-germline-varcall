# nf-germline-varcall

A Nextflow DSL2 pipeline for germline variant calling following **GATK Best Practices**. Designed for reproducible, scalable analysis of whole-genome and whole-exome sequencing data.

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.0.0-23aa62.svg)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)

---

## Pipeline overview

\`\`\`
FASTQ reads
    │
    ▼
┌─────────┐     ┌─────────────┐     ┌──────────┐     ┌────────────────┐     ┌──────────┐
│  FASTQC │ ──▶ │ Trimmomatic │ ──▶ │ BWA-MEM2 │ ──▶ │ HaplotypeCaller│ ──▶ │  MultiQC │
│  (QC)   │     │  (trimming) │     │ (align)  │     │  (variants)    │     │ (report) │
└─────────┘     └─────────────┘     └──────────┘     └────────────────┘     └──────────┘
\`\`\`

## Features

- **Modular DSL2 architecture** — each tool is an independent, reusable module
- **Conda environment management** — fully reproducible without manual tool installation
- **GATK Best Practices** — follows gold-standard germline variant calling workflow
- **HPC-ready** — includes Slurm executor profile for cluster deployment
- **Test profile** — ships with simulated test data for immediate validation
- **MultiQC reporting** — aggregated QC report across all samples

## Tools used

| Step | Tool | Version |
|------|------|---------|
| Quality control | FastQC | 0.12.1 |
| Adapter trimming | Trimmomatic | 0.39 |
| Alignment | BWA-MEM2 | 2.2.1 |
| BAM processing | Samtools | 1.18 |
| Variant calling | GATK HaplotypeCaller | 4.4.0.0 |
| QC aggregation | MultiQC | 1.19 |

## Quick start

### Requirements

- [Nextflow](https://www.nextflow.io/) >= 23.0.0
- [Conda](https://docs.conda.io/) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
- Java 17+

### Installation

\`\`\`bash
git clone https://github.com/YOUR_USERNAME/nf-germline-varcall.git
cd nf-germline-varcall
\`\`\`

### Run with test data

\`\`\`bash
nextflow run main.nf -profile conda,test
\`\`\`

### Run with your own data

\`\`\`bash
nextflow run main.nf \
    -profile conda \
    --reads '/path/to/data/*_{1,2}.fastq.gz' \
    --genome /path/to/reference.fa \
    --outdir results
\`\`\`

### Run on HPC cluster (Slurm)

\`\`\`bash
nextflow run main.nf \
    -profile conda,slurm \
    --reads '/path/to/data/*_{1,2}.fastq.gz' \
    --genome /path/to/reference.fa \
    --outdir results
\`\`\`

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| \`--reads\` | Path to paired-end FASTQ files (glob pattern) | test data |
| \`--genome\` | Path to reference genome FASTA | test data |
| \`--outdir\` | Output directory | \`results\` |

## Output

\`\`\`
results/
├── fastqc/          # Per-sample FastQC HTML reports
├── trimmed/         # Adapter-trimmed FASTQ files
├── bam/             # Sorted, indexed BAM files
├── vcf/             # Germline variant calls (GVCF format)
└── multiqc/         # Aggregated MultiQC HTML report
\`\`\`

## Repository structure

\`\`\`
nf-germline-varcall/
├── main.nf                  # Main pipeline workflow
├── nextflow.config          # Configuration profiles
├── modules/
│   ├── fastqc.nf
│   ├── trim.nf
│   ├── align.nf
│   ├── varcall.nf
│   └── multiqc.nf
├── assets/
│   └── testdata/            # Simulated test data
└── docs/
\`\`\`

## Background

This pipeline implements the [GATK Best Practices](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932) for germline short variant discovery. Designed for use in research and clinical genomics workflows with a focus on reproducibility across local machines and HPC clusters used in Australian genomics research institutions.

## Author

Janet James

## License

MIT
