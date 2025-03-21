#!/bin/bash

set -x
echo "starting BAM to Bed conversion..."

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_bam_file> <output_directory>"
  exit 1
fi

intput_bam=$1
output_dir=$2

mkdir -p $output_dir

source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

conda activate bam2bed || conda create -n bam2bed bedtools -y && conda activate bam2bed

base_name=$(basename $input_bam .bam)

bed_file="$output_dir/$base_name.bed"
bedtools bamtobed -i $input_bam > $bed_file

filtered_bed_file="$output`-dir/${base_name}_chr1.bed"
grep -E '^chr1' $bed_file > $filtered_bed_file

wc -l < $filtered_bed_file > "$output_dir/bam2bed_number_of_rows.txt"

echo "Script completed successfully."
echo "Your name: [Viancy]" 
