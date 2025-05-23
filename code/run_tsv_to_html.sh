#!/bin/bash

# Load the appropriate module
module load bioinfo-tools
module load python/3.9.9

# Run the script for SRR4342129
python /home/anniei/Genome_analysis/Project/code/tsv_to_html.py \
  /home/anniei/Genome_analysis/Project/analyses/DNA/05_quality_control_checkm/checkm_SRR4342129/storage/bin_stats_ext.tsv \
  /home/anniei/Genome_analysis/Project/analyses/DNA/05_quality_control_checkm/checkm_SRR4342129/checkm_table.html

# Run the script for SRR4342133
python /home/anniei/Genome_analysis/Project/code/tsv_to_html.py \
  /home/anniei/Genome_analysis/Project/analyses/DNA/05_quality_control_checkm/checkm_SRR4342133/storage/bin_stats_ext.tsv \
  /home/anniei/Genome_analysis/Project/analyses/DNA/05_quality_control_checkm/checkm_SRR4342133/checkm_table.html

