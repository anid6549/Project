#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J Quality_control_with_QUAST
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load quast

# Define paths
final_contigs_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342129/final.contigs.fa
final_contigs_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342133/final.contigs.fa

# Define output
output_quast_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/03_quality_control/quast_SRR4342129
output_quast_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/03_quality_control/quast_SRR4342133

# Run QUAST
quast.py -t 4 -o $output_quast_SRR4342129 $final_contigs_SRR4342129
quast.py -t 4 -o $output_quast_SRR4342133 $final_contigs_SRR4342133
