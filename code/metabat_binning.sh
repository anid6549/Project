#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J metabat_binning
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load necessary modules
module load system_env
module load bioinfo-tools
module load MetaBat/2.12.1

# Define paths
final_contigs_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342129/final.contigs.fa
output_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/04_binning/metabat_SRR4342129/bin

final_contigs_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342133/final.contigs.fa
output_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/04_binning/metabat_SRR4342133/bin

metabat2 -i $final_contigs_SRR4342129 -o $output_SRR4342129
metabat2 -i $final_contigs_SRR4342133 -o $output_SRR4342133


