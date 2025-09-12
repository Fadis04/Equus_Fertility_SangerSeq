##🐴 Equus Fertility Sanger Sequencing Project

---


##📌 Project Overview

This repository contains sequencing data and analysis scripts for investigating fertility-associated genetic variants in Equus caballus (horses).

We focused on two candidate genes:

ACE (Angiotensin-Converting Enzyme)

SPATA (Spermatogenesis-Associated Gene)

Samples were collected from horses with contrasting fertility phenotypes (low vs. high fertility) to identify potential variants influencing reproductive traits.

Note: Once the related research article is published, a link and citation will be added here.
---
##📂 Repository Structure
```
Equus_Fertility_SangerSeq/
├── VCF_ACE/                       # Variants identified in ACE gene
├── VCF_SPATA/                      # Variants identified in SPATA gene
├── Variant_calling_script.sh       # Complete pipeline for variant calling
├── ab1_to_fastq.py                 # Converts Sanger .ab1 chromatograms to FASTQ
├── run_fastp_all.sh                # Performs quality trimming and filtering using Fastp
├── ace-spata/                      # Reference genome, alignments, and processed data
│   ├── EquCab3.0.fa                # Reference genome
│   ├── EquCab3.0.fa.fai
│   ├── horse_ACE_real.fa
│   ├── horse_ACE_real.fa.fai
│   ├── horse_ACE_real.mmi          # Minimap2 index
│   ├── sites.bed                   # Target regions for ACE and SPATA
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
---
##⚙️ Workflow
1️⃣ Raw Data Conversion

Sanger sequencing produces .ab1 chromatogram files containing raw fluorescent signal traces.

These are converted to FASTQ format using ab1_to_fastq.py, preserving base call quality scores.

2️⃣ Quality Control

Reads are trimmed and filtered using Fastp (run_fastp_all.sh) to remove low-quality bases and adapters.

3️⃣ Alignment

Cleaned reads are aligned to the reference genome using Minimap2.

4️⃣ Variant Calling

SNPs and indels are identified and stored separately for ACE (VCF_ACE/) and SPATA (VCF_SPATA/) genes.
---
##🔬 Goals

Compare variants between low- and high-fertility horse groups

Identify candidate SNPs and indels in ACE and SPATA associated with fertility

Provide a reproducible, open-access resource for horse genetics and reproductive genomics research
---
##💻 Usage
# 1. Clone the repository
```git clone https://github.com/YOUR_USERNAME/Equus_Fertility_SangerSeq.git
cd Equus_Fertility_SangerSeq```

# 2. Convert .ab1 chromatogram files to FASTQ
```python ab1_to_fastq.py -i raw_ab1_files/ -o fastq_output/```

# 3. Perform quality trimming
```bash run_fastp_all.sh```

# 4. Align reads and call variants
``` bash Variant_calling_script.sh ```
---
##📌 Author & Contact

Fadi Slimi

Industrial Biology Engineer (Bioinformatics)

LinkedIn: linkedin.com/in/fadi-slimi

Email: fadi.slimi@example.com

GitHub: github.com/Fadis04
