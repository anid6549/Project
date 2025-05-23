#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00
#SBATCH -J megahit_assembly_results
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load software
module load bioinfo-tools
module load megahit

# Run MEGAHIT

dna_forward_SRR4342129=/home/anniei/Genome_analysis/data/raw_data/DNA/SRR4342129_1.paired.trimmed.fastq.gz
dna_reverse_SRR4342129=/home/anniei/Genome_analysis/data/raw_data/DNA/SRR4342129_2.paired.trimmed.fastq.gz
dna_forward_SRR4342133=/home/anniei/Genome_analysis/data/raw_data/DNA/SRR4342133_1.paired.trimmed.fastq.gz
dna_reverse_SRR4342133=/home/anniei/Genome_analysis/data/raw_data/DNA/SRR4342133_2.paired.trimmed.fastq.gz

megahit -1 $dna_forward_SRR4342129 -2 $dna_reverse_SRR4342129 -t 4 -o /home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342129 --k-min 21 --k-max 81 --k-step 20
megahit -1 $dna_forward_SRR4342133 -2 $dna_reverse_SRR4342133 -t 4 -o /home/anniei/Genome_analysis/analyses/DNA/02_genome_assembly/megahit_results/SRR4342133 --k-min 21 --k-max 81 --k-step 20


