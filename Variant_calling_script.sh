#!/bin/bash

# -------------------------------
# CONFIGURATION
# -------------------------------
BAM_DIR="/home/wassef/Equus_caballus_JBayrem/ace-spata/alignment_ace_spata/SPATA/BAM"
MERGED_DIR="/home/wassef/Equus_caballus_JBayrem/ace-spata/alignment_ace_spata/SPATA/BAM_per_sample"

# Create output directory
mkdir -p $MERGED_DIR

cd $BAM_DIR

# -------------------------------
# STEP 1: Merge F and R BAMs per sample
# -------------------------------

# Extract unique sample names (everything before F/R and the date)
SAMPLES=$(ls *_sorted.bam | sed -E 's/^([0-9A-Za-z.]+)[F|R]_.*_sorted.bam$/\1/' | sort -u)

for sample in $SAMPLES; do
    echo "Merging sample $sample ..."

    # Find all BAMs that match this sample (F and R)
    BAMS=$(ls ${sample}*sorted.bam 2>/dev/null)

    if [ -n "$BAMS" ]; then
        # Merge BAMs
        samtools merge -f $MERGED_DIR/${sample}.merged.bam $BAMS
        # Index merged BAM
        samtools index $MERGED_DIR/${sample}.merged.bam
        echo "✅ Done: ${sample}.merged.bam"
    else
        echo "⚠ No BAMs found for $sample"
    fi
done

echo "🎉 All F/R BAMs merged per sample into $MERGED_DIR"
------------------------------

#!/bin/bash

# -------------------------------
# CONFIGURATION
# -------------------------------

# Reference genome (absolute path)
REF="/home/wassef/Equus_caballus_JBayrem/ace-spata/spata/ref_gene_spata.fasta"

# Directories
BAM_DIR="/home/wassef/Equus_caballus_JBayrem/ace-spata/alignment_ace_spata/SPATA/BAM_per_sample"
VCF_DIR="/home/wassef/Equus_caballus_JBayrem/ace-spata/alignment_ace_spata/SPATA/VCF_per_sample"

# Create output directory if it doesn't exist
mkdir -p $VCF_DIR

# -------------------------------
# STEP 0: Ensure reference is indexed
# -------------------------------

if [ ! -f "${REF}.fai" ]; then
    echo "Indexing reference fasta..."
    samtools faidx $REF
fi

# -------------------------------
# STEP 1: Variant Calling per BAM
# -------------------------------

for BAM in $BAM_DIR/*.merged.bam; do
    SAMPLE=$(basename $BAM .merged.bam)
    echo "Calling variants for $SAMPLE ..."

    # 1️⃣ Generate mpileup (BCF format)
    bcftools mpileup -Ou -f $REF $BAM > $VCF_DIR/${SAMPLE}.bcf

    # 2️⃣ Call variants
    bcftools call -mv -Ou $VCF_DIR/${SAMPLE}.bcf > $VCF_DIR/${SAMPLE}.call.bcf

    # 3️⃣ Normalize and left-align indels
    bcftools norm -f $REF -d both -Ou $VCF_DIR/${SAMPLE}.call.bcf > $VCF_DIR/${SAMPLE}.norm.bcf

    # 4️⃣ Convert to final VCF
    bcftools view $VCF_DIR/${SAMPLE}.norm.bcf -Ov -o $VCF_DIR/${SAMPLE}.vcf

    echo "✅ Done: $VCF_DIR/${SAMPLE}.vcf"
done

echo "🎉 Variant calling finished for all samples!"
