#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J prokka_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load system_env
module load bioinfo-tools
module load prokka

# Define paths
bin1=/home/anniei/Genome_analysis/analyses/DNA/04_binning/metabat_SRR4342129/bin.1.fa
outdir1=/home/anniei/Genome_analysis/analyses/DNA/06_annotation/prokka_bin1_SRR4342129

# Create output directory
mkdir -p $outdir1

# Run Prokka
prokka --outdir $outdir1 --prefix bin1_annotation --cpus 4 $bin1
