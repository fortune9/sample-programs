
nextflow.enable.dsl=2

params.outdir="stool_dna_out"

// for some steps, run multiple files in one process due to their
// resource light-use
def batchSize = params.batchSize ?: 5
if(params.split_align) {
    batchSize *= 3
}

println "batch size: ${params.batchSize} -- $batchSize"

include { FILE_SIZE } from '../processes/misc' addParams (
    outdir: params.outdir
    )

workflow {

    Channel
        .fromPath(params.inFiles)
        .set { ch_in_files }

    FILE_SIZE(ch_in_files.collate(batchSize))
}
