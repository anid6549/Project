import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import sys

# Get sample directory from command-line argument
sample_dir = sys.argv[1]
sample_name = os.path.basename(sample_dir.rstrip('/'))

# Prepare an output directory
output_dir = "{}_top10_plots".format(sample_name)
os.makedirs(output_dir, exist_ok=True)

# Prepare full summary dataframe
summary_df = pd.DataFrame()

# Read each count file in the directory
for file in os.listdir(sample_dir):
    if not file.endswith(".counts.txt"):
        continue

    file_path = os.path.join(sample_dir, file)
    bin_name = file.split("_")[0]  # Extract 'bin.X' from filename

    # Read count data
    df = pd.read_csv(file_path, sep="\t", header=None, names=["gene", "count"])

    # Remove HTSeq summary rows
    df = df[~df["gene"].str.startswith("__")]

    # Convert counts to integers
    df["count"] = pd.to_numeric(df["count"], errors='coerce').fillna(0).astype(int)

    # Get top 10 genes
    top_genes = df.nlargest(10, "count")
    top_genes["bin"] = bin_name

    summary_df = pd.concat([summary_df, top_genes], ignore_index=True)

# Plotting
sns.set(style="whitegrid")
g = sns.catplot(
    data=summary_df,
    x="gene",
    y="count",
    hue="bin",
    col="bin",
    kind="bar",
    col_wrap=3,
    sharex=False,
    sharey=False,
    height=4,
    aspect=1.5
)

g.set_titles("{col_name}")
g.set_xticklabels(rotation=90)
g.set_axis_labels("Gene", "Read count")
plt.tight_layout()

# Save plot
plot_path = os.path.join(output_dir, f"{sample_name}_top10_genes_by_bin.png")
plt.savefig(plot_path, dpi=300)
print(f"✅ Plot saved to: {plot_path}")
