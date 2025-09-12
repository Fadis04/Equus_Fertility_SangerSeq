#!/bin/bash
set -euo pipefail

# Répertoires
ACE_F="fastq_ace_f"
ACE_R="fastq_ace_r"
SPATA_F="fastq_spata_f"
SPATA_R="fastq_spata_r"
OUTDIR="fastp_clean"
mkdir -p $OUTDIR

# Fonction pour traiter un jeu (ACE ou SPATA)
process_gene() {
    F_DIR=$1
    R_DIR=$2
    GENE=$3

    echo "=== Traitement des échantillons $GENE ==="

    for f in $F_DIR/*.fastq; do
        base=$(basename "$f")
        sample=$(echo "$base" | sed -E 's/F|\.F/_/g' | cut -d'_' -f1)  # extrait l'ID (10, 25.1, etc.)

        # Chercher le reverse correspondant
        r=$(ls $R_DIR/*"$sample"R*.fastq 2>/dev/null || true)

        if [[ -n "$r" ]]; then
            echo "→ Traitement $sample ($GENE)"
            fastp \
              -i "$f" \
              -I "$r" \
              -o "$OUTDIR/${sample}_${GENE}_clean_F.fastq" \
              -O "$OUTDIR/${sample}_${GENE}_clean_R.fastq" \
              --detect_adapter_for_pe \
              --thread 4 \
              --html "$OUTDIR/${sample}_${GENE}_fastp.html" \
              --json "$OUTDIR/${sample}_${GENE}_fastp.json" \
              --trim_front1 3 --trim_front2 3 \
              --qualified_quality_phred 20 \
              --length_required 50
        else
            echo "⚠️ Pas de reverse trouvé pour $sample ($GENE)"
        fi
    done
}

# Lancer pour ACE et SPATA
process_gene $ACE_F $ACE_R "ACE"
process_gene $SPATA_F $SPATA_R "SPATA"
