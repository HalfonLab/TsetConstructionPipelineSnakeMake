#!/bin/sh
#SBATCH --partition=general-compute
#SBATCH --qos=supporters
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=20000


#SBATCH --output="slurmlognegNonCodingTset.date.txt"
#SBATCH --mail-user=hasibaas@buffalo.edu
#SBATCH --mail-type=ALL

module load bioperl/1.6.1
module load perl/5.20.2

ulimit -s unlimited

echo "SLURM_JOB_ID="$SLURM_JOB_ID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURM_NPROCS"=$SLURM_NPROCS
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "SLURM_SUBMIT_DIR="$SLURM_SUBMIT_DIR


for dir in set_31 set_32 set_33 set_34 set_35 set_36 set_37 set_38 set_39 set_40
do 

	CRMS=/projects/academic/mshalfon/files4hasiba/SCRMshaw/creatingNegsForRandomTrainingSets/$dir/crms.fasta
	OUT=/projects/academic/mshalfon/files4hasiba/SCRMshaw/creatingNegsForRandomTrainingSets/$dir/neg.fasta
	GENOMEDIR=/projects/academic/mshalfon/RandomSameGC_files/finalchr 
	GENE=/projects/academic/mshalfon/RandomSameGC_files/genes.goodchronly

	echo "Current Value of CRMS directory:="$dir 
	EXE="perl /projects/academic/mshalfon/files4hasiba/SCRMshaw/creatingNegsForRandomTrainingSets/randomWithSameGC.pl"
	ARGS=" --crm $CRMS --output $OUT --size 1 --genomedir $GENOMEDIR --gene $GENE --suffix .fa"
	$EXE $ARGS
	
	

done #end of loop
echo "ALL Done!"
