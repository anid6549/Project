import pandas as pd
import matplotlib.pyplot as plt
import os

# Path to the GTDB summary file
summary_file = "/home/anniei/Genome_analysis/Project/analyses/DNA/07_gtdbtk/SRR4342129/gtdbtk.bac120.summary.tsv"

# Load the data
df = pd.read_csv(summary_file, sep="\t")

# Extract phylum from classification
df['phylum'] = df['classification'].str.extract(r'p__([^;]+)')

# Count number of bins per phylum
phylum_counts = df['phylum'].value_counts().sort_values(ascending=False)

# Plot
plt.figure(figsize=(10, 6))
phylum_counts.plot(kind='bar')
plt.xlabel("Phylum")
plt.ylabel("Number of Bins")
plt.title("GTDB-Tk Taxonomic Classification - SRR4342129")
plt.tight_layout()

# Save plot
output_dir = "gtdbtk_taxonomy_plots"
os.makedirs(output_dir, exist_ok=True)
plt.savefig(f"{output_dir}/SRR4342129_phylum_distribution.png")

print("✅ Plot saved to:", f"{output_dir}/SRR4342129_phylum_distribution.png")
