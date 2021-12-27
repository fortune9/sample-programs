// This workflow tests where the output files
// will be: params.output (by workflow) or
// params.destDir (by included process)a.
// The answer is: it is determined by process's params.destDir

nextflow.enable.dsl=2

params.infiles=null


if(! params.infiles) {
    exit 1, "option --infiles is required"
}

def wfOut="out_by_wf"
//wfOut="out_by_wf"

println "${wfOut}"

include { copy_file } from \
    '../process/copy_file.nf' addParams (
        destDir: "${wfOut}" // sets parameter, but can be overriden by command line --destDir
    )

Channel
    .fromPath(params.infiles, checkIfExists: true)
    .set {file_ch}

workflow {
    log.info """
    infiles: ${params.infiles}
    outdir: ${params.outdir}
    """

    copy_file(file_ch) // output to params.destDir
}

