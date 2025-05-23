import os
import sys
import pandas as pd

def parse_prokka_txt(txt_file):
    info = {
        "Contigs": 0,
        "Bases": 0,
        "CDS": 0,
        "rRNA": 0,
        "tRNA": 0,
        "tmRNA": 0,
    }

    with open(txt_file) as f:
        for line in f:
            if ":" in line:
                key, value = line.strip().split(":", 1)
                key = key.strip()
                value = value.strip()
                try:
                    value_int = int(value)
                except ValueError:
                    # Skip lines with non-numeric values (like organism name)
                    continue

                if key.lower() == "contigs":
                    info["Contigs"] = value_int
                elif key.lower() == "bases":
                    info["Bases"] = value_int
                elif key.upper() == "CDS":
                    info["CDS"] = value_int
                elif key.lower() == "rrna":
                    info["rRNA"] = value_int
                elif key.lower() == "trna":
                    info["tRNA"] = value_int
                elif key.lower() == "tmrna":
                    info["tmRNA"] = value_int

    return info

def main(prokka_dir):
    bins = sorted([d for d in os.listdir(prokka_dir) if os.path.isdir(os.path.join(prokka_dir, d))])
    summary_list = []

    for bin_folder in bins:
        bin_path = os.path.join(prokka_dir, bin_folder)
        txt_files = [f for f in os.listdir(bin_path) if f.endswith(".txt")]
        
        if not txt_files:
            print(f"Warning: No .txt file found in {bin_path}, skipping.")
            continue
        
        # Assuming only one .txt per bin folder
        txt_file = os.path.join(bin_path, txt_files[0])
        prokka_info = parse_prokka_txt(txt_file)
        prokka_info["Bin"] = bin_folder
        summary_list.append(prokka_info)

    df = pd.DataFrame(summary_list)
    df = df[["Bin", "Contigs", "Bases", "CDS", "rRNA", "tRNA", "tmRNA"]]

    # Save TSV and Markdown summary tables
    out_prefix = os.path.basename(prokka_dir.rstrip("/"))
    tsv_out = f"{out_prefix}_annotation_summary.tsv"
    md_out = f"{out_prefix}_annotation_summary.md"

    df.to_csv(tsv_out, sep="\t", index=False)

    with open(md_out, "w") as f:
        f.write(df.to_markdown(index=False))

    print(f"Summary saved as:\n - {tsv_out}\n - {md_out}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 plots_prokka.py /path/to/prokka_sample_dir")
        sys.exit(1)
    prokka_dir = sys.argv[1]
    main(prokka_dir)

