#!/bin/bash
set -e # Exit immediately if any command fails

python install_jobrunner.py # Install the jobrunner

# Set up necessary environment variables (optional)
# export CONDA_EXE=/opt/conda/bin/conda

python -m datoma_jobrunner # Run the jobrunner module