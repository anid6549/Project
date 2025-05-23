import pandas as pd
import sys
import ast 

# Input: TSV file and output Markdown file
tsv_file = sys.argv[1]
md_file = sys.argv[2]

# Read the file (no header)
df = pd.read_csv(tsv_file, sep='\t', header=None, names=["Bin", "Stats"])

# Extract data from the dictionary strings
def parse_stats(stats_str):
    try:
        stats_dict = ast.literal_eval(stats_str)
        return pd.Series({
	    "Marker Lineage": stats_dict.get("marker lineage", "N/A"),
	    "# Genomes": int(stats_dict.get("# genomes", 0)),
	    "# Markers": stats_dict.get("# markers", ""),            
	    "# Marker Sets": stats_dict.get("# marker sets", ""),
	    "0": stats_dict.get("0", 0),
	    "1": stats_dict.get("1", 0),
	    "2": stats_dict.get("2", 0),
	    "3": stats_dict.get("3", 0),
	    "4": stats_dict.get("4", 0),
	    "5+": stats_dict.get("5+", 0),	   
	    "Completeness (%)": round(stats_dict.get("Completeness", 0), 2),
            "Contamination (%)": round(stats_dict.get("Contamination", 0), 2),
            "Genome Size (bp)": int(stats_dict.get("Genome size", 0)),
            "# Contigs": int(stats_dict.get("# contigs", 0)),
            "N50 (contigs)": int(stats_dict.get("N50 (contigs)", 0)),
            "GC Content (%)": round(stats_dict.get("GC", 0) * 100, 2),
        })
    except Exception as e:
        print("Error parsing row: {}".format(e))
        return pd.Series()

# Apply parsing
parsed_df = df["Stats"].apply(parse_stats)
parsed_df.insert(0, "Bin", df["Bin"])

# Write to markdown
with open(md_file, "w") as f:
    f.write(parsed_df.to_markdown(index=False))

