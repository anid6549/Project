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

# Load CheckM module
module load system_env
module load bioinfo-tools
module load CheckM/1.1.3

# Define paths
bins_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/04_binning/metabat_SRR4342129
output_SRR4342129=/home/anniei/Genome_analysis/analyses/DNA/05_quality/checkm_SRR4342129

bins_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/04_binning/metabat_SRR4342133
output_SRR4342133=/home/anniei/Genome_analysis/analyses/DNA/05_quality/checkm_SRR4342133

# Run CheckM lineage workflow
checkm lineage_wf -x fa --threads 8 $bins_SRR4342129 $output_SRR4342129
checkm lineage_wf -x fa --threads 8 $bins_SRR4342133 $output_SRR4342133
