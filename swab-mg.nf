nextflow.enable.dsl=2

process picard_bts {
	cpus 64
	memory '64 GB'
	time '6h'

	input: 
		path(basecall_dir)
	output:
		tuple val(index_sample), path("${index_sample}.bam")

	"""
	java -Xmx48g -jar ${params.picard_path} \
	IlluminaBasecallsToSam \
        LANE=001 NUM_PROCESSORS=0 \
        BASECALLS_DIR= ${params.basecall_dir} \
        READ_STRUCTURE= ${params.picard_read_str} \
        RUN_BARCODE= ${params.picard_run_barcode} \
        SEQUENCING_CENTER=SCRI \
        IGNORE_UNEXPECTED_BARCODES=true \
        LIBRARY_PARAMS=${params.picard_librarydef} > picard-bts.out 2>picard-bts.err
	"""
}

process count_umi {
	input:
		tuple val(index_sample), path(sam_file)
	output:
		tuple val(index_sample), path("${index_sample}-umi.uniq.txt")
	"""
	$params.samtools_exec view $sam_file | sed -E 's|.*\tRX:Z:(.*)|\1|;t;d' > ${inde_sample}-umi.txt
sort ${index_sample}-umi.txt > ${index_sample}-umi.sort.txt
uniq -c ${index_sample}-umi.sort.txt > ${index_sample}-umi.uniq.txt
	"""
}

workflow {
	println "Running workflow for ${params.basecall_dir}"
	def sams = picard_bts("${params.basecall_dir}")	
}
