#!/bin/bash

source /mbshome/vverhoeven/miniforge3/etc/profile.d/conda.sh

/mbshome/vverhoeven/miniforge3/condabin/conda create -n bam2bed -y bedtools
conda_create_return=$?
echo "conda create return code: $conda_create_return"

/mbshome/vverhoeven/miniforge3/condabin/conda activate bam2bed
conda_activate_return=$?
echo "conda activate return code: $conda_create_return"

echo "Conda environment creation and activation attempted"

input_bam=$1
output_dir=$2

mkdir -p "$output_dir"

base_name=$(basename "$input_bam" .bam)

bed_file="$output_dir/test.bed"
bedtools bamtobed -i "$input_bam" > "$bed_file"

filtered_bed_file="$output_dir/${base_name}_chr1.bed"
grep "^Chr1\t" "$bed_file" > "$filtered_bed_file"

wc -l < "$filtered_bed_file" > "$output_dir/bam2bed_number_of_rows.txt"

echo "Script completed successfully."
echo "Your name: [Viancy]" 

