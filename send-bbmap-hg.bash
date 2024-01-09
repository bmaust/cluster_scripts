#!/usr/bin/bash
if [ -z "$1" ] 
then
	echo "$0 requires script to run as first argument"
	exit 1
fi

# 1_S1_L001_R2_trim.fastq.gz 
for F in *R1_trim.fastq.gz
do
	export F1=$F
	export F2=${F1%%_R1.trim.fastq.gz}_R2.trim.fastq.gz
	FB=$(basename $F)
	export FS=${FB%%_L001_R1_trim.fastq.gz}
	echo qsub -N "bbmap_hu_$FS" -e "$HOME/v-virome/bbmap_hu_${FS}.err" -o "$HOME/v-virome/bbmap_hu_${FS}.out" -q paidq -P $(project code Viromics) -V $1 $F1 $F2 $FS
done

