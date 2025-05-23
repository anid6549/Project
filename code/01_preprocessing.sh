#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:40:00
#SBATCH -J fastqz_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load FastQC

# Your commands
fastqc -t 2 -o  /home/anniei/Genome_analysis/analyses/DNA/01_preprocessing/fastqc_trim /home/anniei/Genome_analysis/data/raw_data/DNA/*.fastq.gz
fastqc -t 2 -o /home/anniei/Genome_analysis/analyses/RNA/01_preprocessing/fastqc_untrimmed /home/anniei/Genome_analysis/data/raw_data/RNA/*.fastq.gz

