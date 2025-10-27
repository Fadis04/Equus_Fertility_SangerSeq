🐴 EQUUS FERTILITY SANGER SEQUENCING PROJECT

Bioinformatics Project – Targeted Gene Analysis in Horses
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

```
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
```
Variant Annotation Files and Scripts – ACE & SPATA1

The repository contains a set of files and scripts related to the annotation of variants (SNPs) in the ACE and SPATA1 genes, categorized according to fertility levels: low/medium and high. These files are part of the folder structure below:
```
Equus_Fertility_SangerSeq/
├── ACE_high_fertility_variants_vep_ready.tsv
├── ACE_low_medium_fertility_variants_vep_ready.tsv
├── SPATA_high_fertility_variants_vep_ready.tsv
├── SPATA_low_medium_fertility_variants_vep_ready.tsv
├── Fertility_Hourse.tsv
├── Equss_Caballus_-_ACE_SPATA1_-_Feuille_1.pdf
├── create_tsv.sh
├── filter_and_group_variants_by_fertility.sh

```
Description of files:

ACE_high_fertility_variants_vep_ready.tsv and ACE_low_medium_fertility_variants_vep_ready.tsv

Contain SNPs identified in the ACE gene, separated into high fertility and low/medium fertility categories.

SPATA_high_fertility_variants_vep_ready.tsv and SPATA_low_medium_fertility_variants_vep_ready.tsv

Contain SNPs identified in the SPATA1 gene, also separated by fertility category.

Equss_Caballus_-_ACE_SPATA1_-_Feuille_1.pdf

PDF report summarizing the SNP annotations for both genes, showing how variants are distributed across fertility categories.

Fertility_Hourse.tsv

Table showing each sample and its corresponding fertility characteristic.

Scripts:

create_tsv.sh: Generates .tsv files combining sample information with fertility categories.

filter_and_group_variants_by_fertility.sh: Processes variant files to separate and group SNPs according to fertility levels.
</details> <details> <summary>💻 USAGE</summary>
# 1. Clone the repository
git clone https://github.com/Fadis04/Equus_Fertility_SangerSeq.git
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
📧 Email: fadi.slimi@insat.ucar.tn

🔗 LinkedIn: www.linkedin.com/in/fadi-slimi

💻 GitHub: github.com/Fadis04

</details>
