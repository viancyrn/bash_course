#!/bin/bash
input_bam=/scratch/bash_course/lecture_4/assignment/GSM1606197.bam
output_dir=~/bam2bed
bed_file="$output_dir/test.bed"
filtered_bed_file="$output_dir/test_chr1.bed"
bedtools bamtobed -i "$input_bam" > "$bed_file"
awk '$1 == "Chr1"' "$bed_file" > "$filtered_bed_file"
wc -l "$filtered_bed_file"
echo "Script completed successfully."
echo "Your name: [Viancy]"
