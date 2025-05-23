#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 08:00:00
#SBATCH -J prokka_annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load prokka

# Define samples
samples=("SRR4342129" "SRR4342133")

# Loop over samples
for sample in "${samples[@]}"; do
    echo "Processing sample: $sample"

    # Define bin directory and output directory
    bin_dir="/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning/metabat_${sample}"
    output_dir="/home/anniei/Genome_analysis/Project/analyses/DNA/06_annotation/prokka_${sample}"

    # Loop over each bin (fasta file)
    for bin in "$bin_dir"/*.fa; do
        bin_name=$(basename "$bin" .fa)
        echo "Annotating bin: $bin_name"

        # Run Prokka
        prokka --outdir "${output_dir}/${bin_name}" --prefix "${bin_name}" --cpus 8 "$bin"
    done
done
