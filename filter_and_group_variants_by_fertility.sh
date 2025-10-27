#!/bin/bash

# ================================
# Analyse des variants selon la fertilité
# Auteur : Fadi Slimi
# Objectif :
#  - Filtrer les variants QUAL>20
#  - Regrouper par gène (ACE ou SPATA)
#  - Lister les échantillons partageant chaque variant
# ================================

BASE_DIR=~/Equss_Caballus
FERTILITY_FILE=$BASE_DIR/Fertility_clean.tsv
OUT_DIR=$BASE_DIR/results_variants
mkdir -p "$OUT_DIR"

# Fichiers de sortie
ACE_LOW=$OUT_DIR/ACE_low_medium_fertility_variants.tsv
ACE_HIGH=$OUT_DIR/ACE_high_fertility_variants.tsv
SPATA_LOW=$OUT_DIR/SPATA_low_medium_fertility_variants.tsv
SPATA_HIGH=$OUT_DIR/SPATA_high_fertility_variants.tsv

# Nettoyage des anciennes sorties
> "$ACE_LOW"; > "$ACE_HIGH"; > "$SPATA_LOW"; > "$SPATA_HIGH"

echo "[INFO] Démarrage de l'analyse des variants..."
echo "----------------------------------------------"

# Fichiers temporaires
tmp_ACE_low=$(mktemp)
tmp_ACE_high=$(mktemp)
tmp_SPATA_low=$(mktemp)
tmp_SPATA_high=$(mktemp)

# Lecture du tableau Fertility_clean.tsv
tail -n +2 "$FERTILITY_FILE" | while IFS=$'\t' read -r vcf_file fertility; do
    sample_path="$BASE_DIR/$vcf_file"
    sample_name=$(basename "$vcf_file" | sed 's/.merged.vcf.gz//;s/.vcf.gz//;s/\.\.//g')

    if [[ ! -f "$sample_path" ]]; then
        echo "[WARN] Fichier introuvable: $sample_path"
        continue
    fi

    # Identifier le gène
    if [[ "$vcf_file" == ACE_Equ_Caba/* ]]; then
        gene="ACE"
    elif [[ "$vcf_file" == SPATA_Equ_Caba/* ]]; then
        gene="SPATA"
    else
        echo "[WARN] Ligne ignorée: $vcf_file"
        continue
    fi

    echo "[INFO] Traitement de $sample_name ($gene, fertilité: $fertility)..."

    # Extraire les variants QUAL>20 avec le nom de l’échantillon
    tmp_filtered=$(mktemp)
    bcftools view -i 'QUAL>20' "$sample_path" | \
        grep -v '^#' | \
        awk -v s="$sample_name" '{print $1"\t"$2"\t"$4"\t"$5"\t"s}' > "$tmp_filtered"

    # Selon la fertilité, ajouter dans le bon groupe
    if [[ "$fertility" == "faible" || "$fertility" == "moyenne" ]]; then
        if [[ "$gene" == "ACE" ]]; then
            cat "$tmp_filtered" >> "$tmp_ACE_low"
        else
            cat "$tmp_filtered" >> "$tmp_SPATA_low"
        fi
    elif [[ "$fertility" == "bonne" ]]; then
        if [[ "$gene" == "ACE" ]]; then
            cat "$tmp_filtered" >> "$tmp_ACE_high"
        else
            cat "$tmp_filtered" >> "$tmp_SPATA_high"
        fi
    fi

    rm "$tmp_filtered"
done

# Fonction de fusion : combine les variants identiques et regroupe les noms d’échantillons
merge_variants() {
    local input=$1
    local output=$2
    echo -e "CHROM\tPOS\tREF\tALT\tSamples" > "$output"
    awk '
        {
            key = $1"\t"$2"\t"$3"\t"$4
            if (key in variants) {
                variants[key] = variants[key]","$5
            } else {
                variants[key] = $5
            }
        }
        END {
            for (k in variants) {
                print k"\t"variants[k]
            }
        }
    ' "$input" | sort -k1,1 -k2,2n >> "$output"
}

echo "[INFO] Fusion des variants partagés..."
merge_variants "$tmp_ACE_low"  "$ACE_LOW"
merge_variants "$tmp_ACE_high" "$ACE_HIGH"
merge_variants "$tmp_SPATA_low"  "$SPATA_LOW"
merge_variants "$tmp_SPATA_high" "$SPATA_HIGH"

# Nettoyage
rm "$tmp_ACE_low" "$tmp_ACE_high" "$tmp_SPATA_low" "$tmp_SPATA_high"

echo "----------------------------------------------"
echo "[✅] Analyse terminée ! Résultats disponibles dans : $OUT_DIR"
echo "   - $ACE_LOW"
echo "   - $ACE_HIGH"
echo "   - $SPATA_LOW"
echo "   - $SPATA_HIGH"
echo "----------------------------------------------"
