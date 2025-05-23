#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J Trimming_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user annie.idofsson.6549@student.uu.se
#SBATCH --output=%x.%j.out

# Loading Trimmomatic module
module load bioinfo-tools
module load trimmomatic

# Set directories
cd /home/anniei/Genome_analysis/Project/data/raw_data/RNA
mkdir -p /home/anniei/Genome_analysis/Project/data/trimmed_data/RNA


# Run Trimmomatic on paired-end files
for file1 in *1.fastq.gz; do
    file2="${file1/1.fastq.gz/2.fastq.gz}"
    if [ -f "$file2" ]; then
        trimmomatic PE -phred33 "$file1" "$file2" \
            "/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/$(basename $file1 .fastq.gz)_trimmed_1.fastq.gz" \
            "/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/$(basename $file1 .fastq.gz)_unpaired_1.fastq.gz" \
            "/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/$(basename $file2 .fastq.gz)_trimmed_2.fastq.gz" \
            "/home/anniei/Genome_analysis/Project/data/trimmed_data/RNA/$(basename $file2 .fastq.gz)_unpaired_2.fastq.gz" \
            ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    fi
done

echo "Trimming complete."
