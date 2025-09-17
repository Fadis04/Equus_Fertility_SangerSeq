# vep_prep_script_nopandas.py

input_file = "variants_relative.txt"
output_vcf = "vep_input_ready.vcf"

with open(input_file) as f, open(output_vcf, "w") as out:
    # Write VCF header
    out.write("##fileformat=VCFv4.2\n")
    out.write("##source=CustomConversion\n")
    out.write("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\n")

    # Skip header line in TSV
    next(f)

    for line in f:
        cols = line.strip().split("\t")
        if len(cols) < 6:
            continue
        
        rel, chrom, pos, ref, alt, samples = cols
        info = f"SAMPLES={samples}" if samples != "" else "."
        out.write(f"{chrom}\t{pos}\t.\t{ref}\t{alt}\t.\t.\t{info}\n")

print(f"VCF written to {output_vcf}")
