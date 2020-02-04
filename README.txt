ccr

eval "$(/util/common/python/py37/anaconda-2019.10/bin/conda shell.bash hook)"
conda activate snakemake
module load bioperl/1.6.1
module load perl/5.20.2
module load bedtools


command

snakemake mapping1.test/crms.fasta mapping1.test/neg.fasta -j 100 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -t {cluster.time} --output {cluster.output} --nodes {cluster.nodes} --ntasks-per-node {cluster.ntasks-per-node} --mem {cluster.mem} --mail-type {cluster.mail-type} --mail-user {cluster.mail-user}"
