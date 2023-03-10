if [ -z "$1" ] 
then
	echo "$0 requires script to run as first argument"
	exit 1
fi

for F in *_hg-mask_unmapped.bam_R_1.fastq
do
	export F1=$F
	export F2=${F1%%_R_1.fastq}_R_2.fastq
	export FS=${F1%%.bam_R_1_trim.fastq}
	export W=$PWD
	echo qsub -N "${1}_$FS" -e "$HOME/pmg/${1}-${FS}.err" -o "$HOME/pmg/${1}-${FS}.out" -q paidq -P `project code Viromics` -V $1
done

