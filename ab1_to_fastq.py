#!/usr/bin/env python3
"""
ab1_to_fastq.py
Convert all .ab1 files in a directory (and optionally subdirectories) to FASTQ using Biopython.
Creates files like 10.ACE3R_B05_23-10-28.fastq
"""

import os
from Bio import SeqIO

root = "."  # change to folder path if needed
exts = (".ab1", ".ABI")  # possible extensions

count = 0
for dirpath, dirnames, filenames in os.walk(root):
    for fn in filenames:
        if fn.lower().endswith(".ab1"):
            ab1path = os.path.join(dirpath, fn)
            outname = os.path.splitext(fn)[0] + ".fastq"
            outpath = os.path.join(dirpath, outname)
            try:
                rec = SeqIO.read(ab1path, "abi")
                # Some ab1 files may not have quality; handle gracefully
                if "phred_quality" not in rec.letter_annotations:
                    print(f"Warning: no phred_quality in {ab1path}, skipping")
                    continue
                SeqIO.write(rec, outpath, "fastq")
                count += 1
                print(f"Wrote: {outpath}")
            except Exception as e:
                print(f"Failed {ab1path}: {e}")

print(f"Done. Converted {count} files.")
