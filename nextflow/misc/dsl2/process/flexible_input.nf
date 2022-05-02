// This process tests when an optional input is not
// provided, using parameters to provide values

params.destDir="destDir"


process optional_input {
    publishDir { out ? out : params.destDir }, mode: "copy"

    input:
    path f
    val out

    output:
    path "${f}.copied", emit: ch_copied_file

    script:
    """
    cp $f "${f}.copied"
    """
}

