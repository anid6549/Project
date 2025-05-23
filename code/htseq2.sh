#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 04:00:00
#SBATCH -J HTSeq_activity
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load htseq/2.0.2
module load samtools/1.17

# Define paths
# Sample 1
bam_dir_SRR4342137="/home/anniei/Genome_analysis/Project/analyses/RNA/04_mapping/mapping_SRR4342137"
gff_dir_SRR4342129="/home/anniei/Genome_analysis/Project/analyses/DNA/06_annotation/prokka_SRR4342129"
output_dir_SRR4342137="/home/anniei/Genome_analysis/Project/analyses/RNA/05_htseq/SRR4342137"
mkdir -p "$output_dir_SRR4342137"

# Sample 2
bam_dir_SRR4342139="/home/anniei/Genome_analysis/Project/analyses/RNA/04_mapping/mapping_SRR4342139"
gff_dir_SRR4342133="/home/anniei/Genome_analysis/Project/analyses/DNA/06_annotation/prokka_SRR4342133"
output_dir_SRR4342139="/home/anniei/Genome_analysis/Project/analyses/RNA/05_htseq/SRR4342139"
mkdir -p "$output_dir_SRR4342139"

echo "Starting HTSeq-count for SRR4342137..."
for bam in "$bam_dir_SRR4342137"/*_SRR4342137_sorted.bam; do
    bin_name=$(basename "$bam" _SRR4342137_sorted.bam)
    gff_file_SRR4342137="$gff_dir_SRR4342129/${bin_name}/${bin_name}.cleaned.fixed.gff"
    
    if [[ -f "$gff_file_SRR4342137" ]]; then
        htseq-count -f bam -r pos -s no -t CDS -i ID "$bam" "$gff_file_SRR4342137" > "$output_dir_SRR4342137/${bin_name}_SRR4342137.counts.txt"
    else
        echo "Warning: GFF file not found for $bin_name"
    fi
done

echo "Starting HTSeq-count for SRR4342139..."
for bam in "$bam_dir_SRR4342139"/*_SRR4342139_sorted.bam; do
    bin_name=$(basename "$bam" _SRR4342139_sorted.bam)
    gff_file_SRR4342139="$gff_dir_SRR4342133/${bin_name}/${bin_name}.cleaned.fixed.gff"
    
    if [[ -f "$gff_file_SRR4342139" ]]; then
        htseq-count -f bam -r pos -s no -t CDS -i ID "$bam" "$gff_file_SRR4342139" > "$output_dir_SRR4342139/${bin_name}_SRR4342139.counts.txt"
    else
        echo "Warning: GFF file not found for $bin_name"
    fi
done

echo "HTSeq activity analysis completed!"
