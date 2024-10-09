
#####################################################

****** Training set construction pipeline ********

(c) Hasiba Asma

Date: Jan 2020

updated: Oct 2021 (edited readme, fixed snakemake file)

This pipeline follows all the steps mentioned in 3.2 section of protocol (Kazemian & Halfon 2019). 
A bed file of known CRMs from melanogaster as input is needed, and then pipeline grabs its orthologs (using liftover) from other species, repeats masked, also generate negative set, and returns us the final fasta files of positive (CRMs) and negatives (background sequences) to be used with SCRMshaw. 

#####################################################


**Steps to follow:**
1.	Git clone this folder to your directory on ccr/cluster
2.	Copy paste following commands to load the required modules
```
  module load foss
  module load python
  module load snakemake
  module load bioperl
  module load perl
  module load bedtools
```
3.	Copy new_fasta_files to this directory (make sure it has dm6.fa in it as well). This "new_fasta_files" could not be uploaded on github since it was too big, thus can be copied from here: /projects/academic/mshalfon/files4hasiba/TsetConstructionPipelineSnakeMake/new_fasta_files/
4.	Copy your training set bedfile or files (containing crm’s coord information of Dmel) in “in” folder
5.	Edit multipleSets.sh in such a way to put the name of the file (from set3) in its for loop, and execute it (this will have snakemake command of some sort of this type)
>  snakemake mapping1.test/crms.fasta mapping1.test/neg.fasta -j 100 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -t {cluster.time} --output {cluster.output} --nodes {cluster.nodes} --ntasks-per-node {cluster.ntasks-per-node} --mem {cluster.mem} --mail-type {cluster.mail-type} --mail-user {cluster.mail-user}"

6.	Ouput folder will be created, once it finish running which’ll have two files as their final output i.e., crms.fa and neg.fa (double check to make sure these have correct number of headers (also double check dmel is also in there somewhere))



