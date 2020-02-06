#!/bin/bash


for tsetName in adult_brain embryonic_somatic_muscle adult_circulatory embryonic_trachea adult_cns embryonic_ventral_nervous_system adult_foregut endoderm.mapping1 adult_mesoderm.mapping1 eye-antennal_disc adult_midgut eye.mapping1 adult_muscle eye.mapping2 adult_nervous eye_disc adult_pns fat_body.mapping1 adult_sense_organ female_gonad.mapping1 adult_somatic_muscle female_reproductive amnioserosa.mapping1 genital_disc antenna glia.mapping1 antennal_disc glia.mapping2 antennal_lobe glia blastoderm.mapping1 gonad cardiac.mapping1 haltere_disc disc.mapping1 imaginal_disc disc.mapping2 leg_disc dorsal_ectoderm.mapping1 leg ectoderm.mapping1 male_gonad.mapping1 ectoderm.mapping2 male_reproductive emb-larv_circulatory_system malpig.mapping1 emb-larv_excretory mesectoderm.mapping1 emb-larv_fat_body mesoderm.mapping1 emb-larv_foregut mesoderm.mapping2 emb-larv_hindgut myoblast emb-larv_visceral neuron emb-larval_cns pns.mapping1 emb-larval_mushroombody reproductive.mapping2 emb-larval_neuron salivary.mapping1 emb-larval_opticlobe somatic_muscle.mapping1 embryonic_epidermis trachea.mapping1 embryonic_midgut ventral_ectoderm.mapping1 embryonic_muscle visceral.mapping1 embryonic_pns wing.mapping2 embryonic_salivary embryonic_sense_organ

do
	echo "starting to run snake make for $tsetName"
	snakemake $tsetName/crms.fasta $tsetName/neg.fasta -j 100 --config tset=$tsetName --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -t {cluster.time} --output {cluster.output} --nodes {cluster.nodes} --ntasks-per-node {cluster.ntasks-per-node} --mem {cluster.mem} --mail-type {cluster.mail-type} --mail-user {cluster.mail-user}"

	echo "Done snakemake for another set"
	echo "cleaning intermediate files"
	./clean.sh

	echo "DONE 1 more"

done
echo "Done ALL"


