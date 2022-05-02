nextflow.enable.dsl=2

params.inFiles=null
params.outDir=null

include {optional_input} from '../process/flexible_input.nf'

def usage() {
    log.info """
    nextflow run ./test_flexible_input.nf [options]
    
    --inFiles <paths>: input files to be copied.

    --outDir <path>: a directory to save outputs

    --destDir <path>: the same as '--outDir', but has
    lower priority, used if '--outDir' is ommited.

    """
}

workflow {
    if(! params.inFiles) {
        exit 1, usage()
    }

    ch_in_files=Channel.fromPath(params.inFiles)
    def outDir = params.outDir ?: ""
    optional_input(ch_in_files, outDir)
}

