#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 04:00:00
#SBATCH -J checkm_quality
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Exit immediately if a command exits with a non-zero status
set -e

# Load CheckM module
module load bioinfo-tools
module load CheckM/1.1.3

# Set CheckM data directory (do this before running checkm)
checkm data setRoot /home/anniei/checkm_data

# Define paths
bins_SRR4342129=/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning/metabat_SRR4342129
bins_SRR4342133=/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning/metabat_SRR4342133

# Run CheckM lineage workflow
checkm lineage_wf -t 8 --reduced_tree -x fa "$bins_SRR4342129" /home/anniei/Genome_analysis/Project/analyses/DNA/06_evaluation/checkm_SRR4342129
checkm lineage_wf -t 8 --reduced_tree -x fa "$bins_SRR4342133" /home/anniei/Genome_analysis/Project/analyses/DNA/06_evaluation/checkm_SRR4342133

echo "CheckM analysis completed successfully!"

