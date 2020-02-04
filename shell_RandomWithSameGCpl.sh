
CRMS=tset/crms.fasta
OUT=tset/neg.fasta
GENOMEDIR=/projects/academic/mshalfon/RandomSameGC_files/finalchr 
GENE=/projects/academic/mshalfon/RandomSameGC_files/genes.goodchronly

#echo "Current Value of CRMS directory:="$dir 
EXE="perl /projects/academic/mshalfon/files4hasiba/SCRMshaw/creatingNegsForRandomTrainingSets/randomWithSameGC.pl"
ARGS=" --crm $CRMS --output $OUT --size 1 --genomedir $GENOMEDIR --gene $GENE --suffix .fa"
$EXE $ARGS
