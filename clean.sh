#!/bin/sh

filebase=$1
output_bed="$filebase_output.bed"

rm -r fasta_log*
mv log.lift* logs/

rm $output_bed
