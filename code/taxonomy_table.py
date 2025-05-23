import pandas as pd
import os

# Base directory containing GTDB output for each sample
base_dir = "/home/anniei/Genome_analysis/Project/analyses/DNA/07_gtdbtk"
samples = ["SRR4342129", "SRR4342133"]
output_dir = os.path.join(base_dir, "all_taxonomy_tables")
os.makedirs(output_dir, exist_ok=True)

for sample in samples:
    input_file = os.path.join(base_dir, sample, "gtdbtk.bac120.summary.tsv")
    df = pd.read_csv(input_file, sep="\t")
    df[['Domain', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species']] = df['classification'].str.split(';', expand=True)

    # Keep only desired columns
    df_out = df[["user_genome", "Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species"]]
    df_out.rename(columns={"user_genome": "Bin"}, inplace=True)

    # Save as Markdown and TSV
    sample_out_dir = os.path.join(output_dir, sample)
    os.makedirs(sample_out_dir, exist_ok=True)

    md_path = os.path.join(sample_out_dir, f"{sample}_taxonomy_summary.md")
    tsv_path = os.path.join(sample_out_dir, f"{sample}_taxonomy_summary.tsv")

    with open(md_path, "w") as f:
        f.write(f"# Taxonomic Summary Table for {sample}\n\n")
        f.write(df_out.to_markdown(index=False))

    df_out.to_csv(tsv_path, sep="\t", index=False)

print("✅ Combined taxonomy tables saved per sample.")
