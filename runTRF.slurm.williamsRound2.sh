#!/bin/sh
#SBATCH --partition=general-compute
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
##SBATCH --job-name="single-job"

#SBATCH --output="slurmlog.date.txt"

#SBATCH --mail-user=mshalfon@buffalo.edu
#SBATCH --mail-type=ALL


ulimit -s unlimited



echo "SLURM_JOB_ID="$SLURM_JOB_ID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURM_NPROCS"=$SLURM_NPROCS
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "SLURM_SUBMIT_DIR="$SLURM_SUBMIT_DIR







/projects/academic/mshalfon/supl_scripts/tandem_repeat_mask/trf409.linux64  crms.fasta 2 7 7 80 10 50 500 -m -h

/projects/academic/mshalfon/supl_scripts/tandem_repeat_mask/trf409.linux64 neg.fasta 2 7 7 80 10 50 500 -m -h


mv crms.fasta crms.fasta.unmasked
mv crms.fasta.2.7.7.80.10.50.500.mask crms.fasta

mv neg.fasta neg.fasta.unmasked
mv neg.fasta.2.7.7.80.10.50.500.mask neg.fasta



echo "All Done!"
