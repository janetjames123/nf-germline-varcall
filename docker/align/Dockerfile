FROM continuumio/miniconda3:24.1.2-0
RUN conda install -y -c bioconda -c conda-forge \
    bwa-mem2=2.2.1 \
    samtools=1.21 && \
    conda clean -afy
