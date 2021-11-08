
params.in=null

log.info """\
    NEXTFLOW PIPELINE
    ===================================
    Check file extensions

    Example uses:
    nextflow run test_file1.nf --in '*.txt'
    # new feature
    nextflow run test_file1.nf --in 'a*.txt  b*.txt'
    ------------------------------------
    Input: ${params.in}
    ===================================
    """
    .stripIndent()

if(!params.in) {
    exit 1, "Please provide input file using argument --in"
}

Channel.fromPath(params.in.split(/\s+/).flatten()) // allow input can be space-separated multiple strings
        .set {file_ch}

process get_ext {
    echo true

    input:
    path f from file_ch

    script:
    if("$f".endsWith(".gz"))
        """
        echo $f is compressed
        """
    else
        """
        echo $f is not compressed
        """
}


