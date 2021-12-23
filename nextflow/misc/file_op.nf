params.in="."
params.outdir="tmp_out"

myDir=file(params.outdir)
myDir.mkdirs()

Channel
    .fromPath(params.in)
    .set {file_ch}

/*
file_ch
    .subscribe { it.copyTo(myDir) }
*/

process copy_file {
    publishDir params.outdir, mode: 'copy'
    cpus 1
    memory "1 GB"

    input:
    file f from file_ch

    script:
    //f.copyTo(myDir) // This doesn't work
    """
    cp -a '$f' '${params.outdir}/'
    """
}

