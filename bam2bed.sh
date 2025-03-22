#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_bam_file> <output_directory>"
  exit 1
fi

input_bam=$1
output_dir=$2

mkdir -p "$output_dir"

source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

conda env list | grep -q 'bam2bed' || conda create -n bam2bed bedtools -y

conda activate bam2bed

base_name=$(basename "$input_bam" .bam)

bed_file="$output_dir/$base_name.bed"
filtered_bed_file="$output_dir/${base_name}_chr1.bed"

bedtools bamtobed -i "$input_bam" > "$bed_file"

if [ ! -s "$bed_file" ]; then
  echo " Original BED file not generated or is empty!"
  exit 1
fi

#grep "^Chr1\t" "$bed_file" > "$filtered_bed_file"
awk '$1 == "Chr1"' "$bed_file" > "$filtered_bed_file"

if [ ! -s "$filtered_bed_file" ]; then
  echo "Filtered BED file is empty!"
  exit 1
fi

line_count=$(wc -l < "$filtered_bed_file")
printf "%s\n" "$line_count" > "$output_dir/bam2bed_number_of_rows.txt"
#echo "$line_count" > "$output_dir/bam2bed_number_of_rows.txt"

cat "$output_dir/bam2bed_number_of_rows.txt"

echo "Script completed successfully."
echo "Your name: [Viancy]"
