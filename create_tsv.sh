#!/bin/bash
# Script pour créer un TSV propre avec VCF et niveau de fertilité
# SORTIE : Fertility_clean.tsv

OUTPUT="Fertility_clean.tsv"
echo -e "VCF_file\tFertility" > $OUTPUT

# ACE_Equ_Caba
declare -A ACE_fertility=(
    ["1d.merged.vcf"]="bonne"
    ["3d.merged.vcf"]="moyenne"
    ["4.merged.vcf"]="bonne"
    ["5.merged.vcf"]="moyenne"
    ["7.merged.vcf"]="faible"
    ["9.merged.vcf"]="bonne"
    ["10.merged.vcf"]="moyenne"
    ["11.merged.vcf"]="bonne"
    ["12.merged.vcf"]="faible"
    ["13.merged.vcf"]="moyenne"
    ["16.merged.vcf"]="faible"
    ["26.merged.vcf"]="bonne"
    ["29.merged.vcf"]="moyenne"
    ["M.merged.vcf"]="faible"
    ["20.merged.vcf"]="bonne"
    ["50.merged.vcf"]="bonne"
    ["6.merged.vcf"]="faible"
    ["8.merged.vcf"]="faible"
)

for file in "${!ACE_fertility[@]}"; do
    echo -e "ACE_Equ_Caba/$file\t${ACE_fertility[$file]}" >> $OUTPUT
done

# SPATA_Equ_Caba
declare -A SPATA_fertility=(
    ["8J..vcf"]="faible"
    ["14J..vcf"]="moyenne"
    ["24J..vcf"]="moyenne"
    ["25.1.vcf"]="faible"
    ["26J..vcf"]="bonne"
    ["27J..vcf"]="moyenne"
    ["28.vcf"]="faible"
    ["30J..vcf"]="bonne"
    ["33.vcf"]="moyenne"
    ["49.vcf"]="moyenne"
    ["50.2.vcf"]="bonne"
    ["52..vcf"]="bonne"
    ["107.vcf"]="faible"
    ["10.vcf"]="faible"
)

for file in "${!SPATA_fertility[@]}"; do
    echo -e "SPATA_Equ_Caba/$file\t${SPATA_fertility[$file]}" >> $OUTPUT
done

echo "✅ TSV créé : $OUTPUT"

