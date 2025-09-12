🐴 EQUUS FERTILITY SANGER SEQUENCING PROJECT

Independent Bioinformatics Project – Targeted Gene Analysis in Horses
Project Title: Identification of Fertility-Associated Variants in ACE and SPATA Genes

<details> <summary>📌 PROJECT OVERVIEW</summary>

This repository contains sequencing data and analysis pipelines for studying fertility-associated genetic variants in Equus caballus (horses).

We targeted two candidate genes:

ACE (Angiotensin-Converting Enzyme)

SPATA (Spermatogenesis-Associated Gene)

Samples include horses with low fertility and high fertility to identify SNPs and indels potentially linked to reproductive performance.

Note: Once the related research article is published, a link and citation will be added here.

</details> <details> <summary>🧬 KEY OBJECTIVES</summary>

Identify candidate SNPs and indels in ACE and SPATA genes

Compare variants between low- and high-fertility horses

Provide a reproducible bioinformatics pipeline for Sanger sequencing analysis

Build an open-access resource for horse genetics and reproductive genomics

</details> <details> <summary>⚙️ WORKFLOW</summary>
Raw Data Conversion

Data Type: Sanger .ab1 chromatogram files

Purpose: .ab1 files contain raw fluorescent traces representing nucleotide sequences.

Converted to FASTQ format using ab1_to_fastq.py, preserving base call quality scores.

Quality Control

Reads are trimmed and filtered using Fastp (run_fastp_all.sh) to remove low-quality bases and adapters.

Alignment

Cleaned reads aligned to reference genome using Minimap2.

Variant Calling

SNPs and indels identified and stored in VCF_ACE/ and VCF_SPATA/ directories.

</details> <details> <summary>📂 REPOSITORY STRUCTURE</summary>
Equus_Fertility_SangerSeq/
├── VCF_ACE/                       # Variants identified in ACE gene
├── VCF_SPATA/                      # Variants identified in SPATA gene
├── Variant_calling_script.sh       # Complete pipeline for variant calling
├── ab1_to_fastq.py                 # Convert Sanger .ab1 chromatograms to FASTQ
├── run_fastp_all.sh                # Quality trimming and filtering
├── ace-spata/                      # Reference genome, alignments, and processed data
│   ├── EquCab3.0.fa                # Reference genome
│   ├── EquCab3.0.fa.fai
│   ├── horse_ACE_real.fa
│   ├── horse_ACE_real.fa.fai
│   ├── horse_ACE_real.mmi          # Minimap2 index
│   ├── sites.bed                   # Target regions
│   ├── fastq_ace_f
│   ├── fastq_ace_r
│   ├── fastq_spata_f
│   ├── fastq_spata_r
│   ├── fastp_clean/
│   ├── trimmed.files/
│   ├── fasta.files/
│   └── alignment_ace_spata/
│       ├── ACE/
│       │   ├── BAM/
│       │   ├── BAM_per_sample/
│       │   ├── VCF_ACE/
│       │   ├── VCF_per_sample/
│       │   ├── indels_all.csv
│       │   └── indels_confirmed.csv
│       └── SPATA/
│           ├── BAM/
│           ├── BAM_per_sample/
│           ├── VCF_SPATA/
│           ├── VCF_per_sample/
│           ├── indels_all.csv
│           └── indels_confirmed.csv

</details> <details> <summary>💻 USAGE</summary>
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/Equus_Fertility_SangerSeq.git
cd Equus_Fertility_SangerSeq

# 2. Convert .ab1 chromatogram files to FASTQ
python ab1_to_fastq.py -i raw_ab1_files/ -o fastq_output/

# 3. Perform quality trimming
bash run_fastp_all.sh

# 4. Align reads and call variants
bash Variant_calling_script.sh

</details> <details> <summary>🔬 EXPECTED OUTCOMES</summary>

Identification of SNPs and indels potentially associated with horse fertility

Comparative variant analysis between low- and high-fertility groups

High-quality, reproducible Sanger sequencing pipeline

Open-access resource for equine reproductive genomics research

</details> <details> <summary>👨‍💻 AUTHOR</summary>

Fadi Slimi – Bioinformatics Specialist
📧 Email: fadi.slimi@example.com

🔗 LinkedIn: www.linkedin.com/in/fadi-slimi

💻 GitHub: github.com/Fadis04

</details>
