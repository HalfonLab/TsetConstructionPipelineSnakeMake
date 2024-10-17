localrules: SelectSmallestFeature,concatenate,movingMaskedCrms,movingMaskedNegs
species=['Dana', 'Dere','Dgri', 'Dmoj', 'Dper', 'Dpse', 'Dsec', 'Dsim', 'Dvir', 'Dyak','Dmel']

inputFile=config['tset']
tsetName=config['tset']
fdir='fasta_log_files'+inputFile


rule SelectSmallestFeature:
	input:
		expand("in/{input}",input=inputFile)
	output:
		expand("{input}_output.bed",input=inputFile)
	shell:
		"/projects/academic/mshalfon/Scripts/SelectSmallestFeature.py -i {input} -o {output}"

rule liftOver:
	input:
		bed_file= expand("{input}_output.bed",input=inputFile),
		chain_files_dir= "/projects/academic/mshalfon/dm6-DrosSpecies_chain_files/",
		genome_files_dir="/projects/academic/mshalfon/drosSpecies_fasta_files/",
		path_to_executable="/projects/academic/mshalfon/liftOver/"
	output:
	   	expand("{specie}.{input}_output.bed.fa", specie=species, input=inputFile)
	log:
		expand("logs/liftover/{input}.log",input=inputFile)
	shell:
		"scripts/liftover_script_modified.sh {input.bed_file} {input.path_to_executable} {input.chain_files_dir} {input.genome_files_dir} 2> {log}"

rule concatenate:
	input:
		out=expand("{specie}.{input}_output.bed.fa", specie=species, input=inputFile)
	output:	
 		fileName=expand("{tset}/crms.fa",tset=tsetName),
		dir=directory(fdir)
	shell:
		"""
		cat {input.out} > {output.fileName}
		mkdir {output.dir}
		mv D* {output.dir}

		"""

rule negative:
	input:
		infileName=expand("{tset}/crms.fa",tset=tsetName),
		genomedir="/projects/academic/mshalfon/RandomSameGC_files/finalchr",
		gene="/projects/academic/mshalfon/RandomSameGC_files/genes.goodchronly"

	output:
		outfileName=expand("{tset}/neg.fa",tset=tsetName)

	log:
		expand("logs/bkg/{input}.log",input=inputFile)
	shell:
		"perl scripts/randomWithSameGC.pl --crm {input.infileName} --output {output.outfileName} --size 10 --genomedir {input.genomedir} --gene {input.gene} --suffix .fa 2> {log}"

rule maskingCrms:
	input:
		inCrms=expand("{tset}/crms.fa",tset=tsetName)

	output:
		outCrms="crms.fa.2.7.7.80.10.50.500.mask"
	shell:
		"/projects/academic/mshalfon/Scripts/trf409.linux64 {input.inCrms} 2 7 7 80 10 50 500 -m -h || true"

rule movingMaskedCrms:
	input:
		maskedCrms="crms.fa.2.7.7.80.10.50.500.mask",
		unMaskedCrms=expand("{tset}/crms.fa",tset=tsetName)
	output:
		maskedCrmsName=expand("{tset}/crms.fasta",tset=tsetName)
	shell:
		"""
		mv {input.maskedCrms} {output.maskedCrmsName}
		rm {input.unMaskedCrms}
		rm crms.fa.2.7.7.80.10.50.500.dat 
		"""

rule masking_negs:
	input:
		inNegs=expand("{tset}/neg.fa",tset=tsetName)
	output:
		outNegs="neg.fa.2.7.7.80.10.50.500.mask"
	shell:
		"/projects/academic/mshalfon/Scripts/trf409.linux64 {input.inNegs} 2 7 7 80 10 50 500 -m -h || true"

rule movingMaskedNegs:
	input:
		maskedNegs="neg.fa.2.7.7.80.10.50.500.mask",
		unMaskedNegs=expand("{tset}/neg.fa",tset=tsetName)
	output:
		maskedNegsName=expand("{tset}/neg.fasta",tset=tsetName)

	shell:
		"""
		mv {input.maskedNegs} {output.maskedNegsName}
		rm {input.unMaskedNegs}
		rm neg.fa.2.7.7.80.10.50.500.dat 
		"""
