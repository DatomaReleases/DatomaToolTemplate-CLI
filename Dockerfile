# Please, try to use images located in public.ecr.aws/docker/library
FROM public.ecr.aws/u7h0g2s9/continuumio/miniconda3:23.5.2-0 AS builder

# Install build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential pkg-config libhdf5-103-1 libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

# Create Conda environment
RUN conda install -n base conda-libmamba-solver -y
RUN conda config --set solver libmamba
RUN conda config --set channel_priority strict

# Install main package and dependencies (files can also be copied if you have a binary file or similar)
# RUN conda install -n base -c conda-forge your-package=6.1.0 -y
# RUN conda install -n base -c conda-forge openjdk=21 -y

# Copy the script that will run your CLI command
COPY script.py /app/

# Necessary files for running your tool on the Datoma infrastructure
COPY install_jobrunner.py /app/install_jobrunner.py
RUN chmod +x /app/install_jobrunner.py
COPY install_jobrunner_and_run.sh /app/install_jobrunner_and_run.sh
RUN chmod +x /app/install_jobrunner_and_run.sh
COPY datomaconfig.yml /app/

# Necessary lines to run the tool
WORKDIR /app
ENTRYPOINT ["/bin/bash" ,"/app/install_jobrunner_and_run.sh" ]
