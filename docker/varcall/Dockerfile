FROM continuumio/miniconda3:24.1.2-0
RUN conda install -y -c bioconda -c conda-forge \
    gatk4=4.4.0.0 \
    samtools=1.21 && \
    conda clean -afy
