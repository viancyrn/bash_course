#!/bin/bash

echo "Starting BAM to BED conversion.."

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_bam_file> <output_directory>
  exit 1
fi

input_bam=$1
output_dir=$2

mkdir -p "$output_dir"

source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

base_name=$(basename "$input_bam" .bam)

bed_file="$output_dir/test.bed"
bedtools bamtobed -i "$input_bam" > "$bed_file"

filtered_bed_file="$output_dir/${base_name}_chr1.bed"
grep "^Chr1\t" "$bed_file" > "$filtered_bed_file"

wc -l < "$filtered_bed_file" > "$output_dir/bam2bed_number_of_rows.txt"

echo "Script completed successfully."
echo "Your name: [Viancy]" 

