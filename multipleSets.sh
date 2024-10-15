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

tsetFile=$1
#temporary, will need fixing to handle a list of file names

for tsetName in $tsetFile

do
	echo "starting to run snake make for $tsetName"
	snakemake $tsetName/crms.fasta $tsetName/neg.fasta -j 100 --config tset=$tsetName 

	echo "Done snakemake for another set"
	echo "cleaning intermediate files"
	./clean.sh

	echo "DONE 1 more"

done
echo "Done ALL"

#hasiba's original:
#	snakemake $tsetName/crms.fasta $tsetName/neg.fasta -j 100 --config tset=$tsetName --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -t {cluster.time} --output {cluster.output} --nodes {cluster.nodes} --ntasks-per-node {cluster.ntasks-per-node} --mem {cluster.mem} --mail-type {cluster.mail-type} --mail-user {cluster.mail-user}"


