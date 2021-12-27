// this process copies files to
// a folder given by option --destDir

params.destDir="destDir"


process copy_file {
    publishDir params.destDir, mode: "copy"

    input:
    path f

    output:
    path "${f}.copied", emit: ch_copied_file

    script:
    """
    cp $f "${f}.copied"
    """
}

