#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 08:00:00
#SBATCH -J BWA_mapping_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load bwa/0.7.17
module load samtools/1.17


# Sample 1: SRR4342129

# Read paths (SRR4342137 maps to bins from SRR4342129)
reads_forward_SRR4342137=/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/SRR4342137.1_trimmed_1.fastq.gz
reads_reverse_SRR4342137=/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/SRR4342137.2_trimmed_2.fastq.gz

# Bin dir and output dir
bin_dir_SRR4342129=/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning/metabat_SRR4342129
output_dir_SRR4342137=/home/anniei/Genome_analysis/Project/analyses/RNA/04_mapping/mapping_SRR4342137
mkdir -p $output_dir_SRR4342137

echo "Processing mapping of SRR4342137 to bins from SRR4342129..."
for bin in "$bin_dir_SRR4342129"/*.fa; do
    bin_name=$(basename "$bin" .fa)

    echo "Indexing $bin..."
    bwa index "$bin"

    echo "Mapping SRR4342137 reads to $bin..."
    bwa mem -t 8 "$bin" "$reads_forward_SRR4342137" "$reads_reverse_SRR4342137" \
        | samtools view -b - > "$output_dir_SRR4342137/${bin_name}_SRR4342137.bam"

    echo "Sorting and indexing..."
    samtools sort -@ 8 -o "$output_dir_SRR4342137/${bin_name}_SRR4342137_sorted.bam" "$output_dir_SRR4342137/${bin_name}_SRR4342137.bam"
    samtools index "$output_dir_SRR4342137/${bin_name}_SRR4342137_sorted.bam"

    rm "$output_dir_SRR4342137/${bin_name}_SRR4342137.bam"
done


# Sample 2: SRR4342133

# Read paths (SRR4342139 maps to bins from SRR4342133)
reads_forward_SRR4342139=/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/SRR4342139.1_trimmed_1.fastq.gz   
reads_reverse_SRR4342139=/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/SRR4342139.2_trimmed_2.fastq.gz

# Bin dir and output dir
bin_dir_SRR4342133=/home/anniei/Genome_analysis/Project/analyses/DNA/04_binning/metabat_SRR4342133
output_dir_SRR4342139=/home/anniei/Genome_analysis/Project/analyses/RNA/04_mapping/mapping_SRR4342139
mkdir -p $output_dir_SRR4342139

# Loop over both bin directories
echo "Processing mapping of SRR4342139 to bins from SRR4342133"
for bin in "$bin_dir_SRR4342133"/*.fa; do
    bin_name=$(basename "$bin" .fa)

    echo "Indexing $bin..."
    bwa index "$bin"

    echo "Mapping SRR4342139 reads to $bin..."
    bwa mem -t 8 "$bin" "$reads_forward_SRR4342139" "$reads_reverse_SRR4342139" \
        | samtools view -b - > "$output_dir_SRR4342139/${bin_name}_SRR4342139.bam"

    echo "Sorting and indexing..."
    samtools sort -@ 8 -o "$output_dir_SRR4342139/${bin_name}_SRR4342139_sorted.bam" "$output_dir_SRR4342139/${bin_name}_SRR4342139.bam"
    samtools index "$output_dir_SRR4342139/${bin_name}_SRR4342139_sorted.bam"

    rm "$output_dir_SRR4342139/${bin_name}_SRR4342139.bam"
done

echo "All RNA mapping jobs completed successfully!"

