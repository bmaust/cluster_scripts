#!/bin/bash

module load openjdk-17.0.3_7-gcc-12.1.0
/home/bmaust/local/bin/nextflow run $1

for F in *_R1_001.trim.fastq.gz
do
	export FS=${F/_L001_R1_001.trim.fastq.gz/}
	export F1=$F
	export F2=${FS}_L001_R2_001.trim.fastq.gz
	export WHERE=$PWD

	sbatch /home/bmaust/cluster-scripts/do-bbdeplete.job 
done
