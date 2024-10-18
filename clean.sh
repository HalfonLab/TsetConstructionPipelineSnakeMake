#!/bin/sh

filebase=$1
output_bed="${filebase}_output.bed"

rm -r fasta_log*
mv log.lift* logs/

rm $output_bed
