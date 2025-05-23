#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J FastQC_trimmed_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load the FastQC module
module load bioinfo-tools
module load FastQC

# Set directories
INPUT_DIR=/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA
OUTPUT_DIR=/home/anniei/Genome_analysis/Project/analyses/RNA/03_trimmed_quality_control

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Run FastQC on all trimmed fastq.gz files
fastqc -t 4 -o "$OUTPUT_DIR" "$INPUT_DIR"/*.fastq.gz

echo "FastQC on trimmed RNA completed."

