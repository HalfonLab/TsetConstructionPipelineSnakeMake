#!/bin/bash -l

#SBATCH --partition=general-compute
#SBATCH --qos=general-compute
#SBATCH --time=1:00:00
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --mem=23000
#SBATCH --job-name="TsetSnakemake"
#SBATCH --output="TsetSnakemake.out"
#SBATCH --mail-user=mshalfon@buffalo.edu
#SBATCH --mail-type=ALL


module load foss
module load python
module load snakemake
module load bioperl
module load perl
module load bedtools

#Usage: path to input directory of CRM bed files must go on command line
#check for command line
if [ -z $1 ]; then	#this syntax checks if there is a value for the first argument 
    echo "Path to the directory with input CRM .bed files needs to be provided on the command line"
    exit 1
fi

directory=$1


# Iterate over each file in the directory
for file in "$directory"/*; do
	# Check if it's a file (not a directory)
  	if [ -f "$file" ]; then
    	# Print the basename of the file
    	tsetName=$(basename "$file")
  	fi


	echo "starting to run snake make for $tsetName"
	snakemake $tsetName/crms.fasta $tsetName/neg.fasta -j 100 --config tset=$tsetName 

	echo "Done snakemake for another set"
	echo "cleaning intermediate files"
	./clean.sh

	echo "DONE 1 more"

done
echo "Done ALL"



