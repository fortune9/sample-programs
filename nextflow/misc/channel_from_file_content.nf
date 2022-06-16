/*
 * to show create file channels with the file names in a file
*/

// nextflow.enable.dsl=2

params.fileList = false
params.outdir = "nf_output"
params.prefix = null

log.info """\
    N F   P I P E L I N E
    ======================================================
    Creating file objects by reading filenames from a file
    """
    .stripIndent()


if(! params.fileList) {
    exit 1, "parameter --fileList is required"
}

// read the file paths
inFile=file(params.fileList)
paths=inFile.readLines()
if(params.prefix != null) {
    log.info "Adding prefix"
    paths=paths.collect() { "${params.prefix}/$it" }
}

// put them into a channel
Channel
    .fromPath(paths)
    .view() { it -> "${it.name} : ${it.size()}"}

