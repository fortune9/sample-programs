
nextflow.enable.dsl=2

params.outdir="test_out"

if(! params.inFiles) {
    exit 1, "Parameter --inFiles is required"
}


workflow FILE_TO_SHEET {

    take:
    ch_files

    main:
    def outFile = "${params.outdir}/test_collected_files.csv"
    def header = "sampleId,fastq_1,fastq_2" // not working for single-end
    ch_files
        .map { it ->
            def id = it.name.replaceAll(/_S\d+_R\d_\d+\.(fastq|fq)\.gz$/, "")
            [id, "$it"]
        }
        .groupTuple(by:0)
        .map { id, fastqs ->
            if( fastqs instanceof List) {
                if( "${fastqs[0]}" =~ /_S\d+_R2_\d+/) { // switch the two files
                    fastqs=[fastqs[1], fastqs[0]]
                }
                "${id},${fastqs[0]},${fastqs[1]}"
            } else {
                "${id},${fastqs}"
            }
        }
        .collectFile( name: outFile, newLine: true, seed: header) 
        .set { ch_sheet }

    emit:
    ch_sheet
}

workflow {

    Channel
        .fromPath(params.inFiles)
        .set { ch_in_files }

    //ch_in_files.view()

    FILE_TO_SHEET(ch_in_files)

    FILE_TO_SHEET.out.ch_sheet.view()
}

