#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 24:00:00
#SBATCH -J GTDB_Tk_classification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load GTDB-Tk/2.4.0

# Base directories
base_bin_dir=/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning
base_out_dir=/home/anniei/Genome_analysis/Project/analyses/DNA/07_gtdbtk

# List of samples to process
samples=("SRR4342129" "SRR4342133")

# Loop over each sample
for sample in "${samples[@]}"; do
  echo "Processing sample: $sample"

  # Define input and output dirs for this sample
  input_dir="$base_bin_dir/metabat_${sample}"
  output_dir="$base_out_dir/${sample}"
  
  # Create output directory if it doesn't exist
  mkdir -p "$output_dir"

  # Run GTDB-Tk classify workflow on this sample's bins
  gtdbtk classify_wf \
    --genome_dir "$input_dir" \
    --out_dir "$output_dir" \
    --skip_ani_screen \
    --cpus 16 \
    --extension fa

  echo "Finished processing $sample"
done

echo "All samples processed!"

