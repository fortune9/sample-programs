
params.in=null

log.info """\
    NEXTFLOW PIPELINE
    ===================================
    Test different kinds of input files.
    'NO_FILE' is a special file which is
    absent.

    Example uses:
    nextflow run test_file1.nf --in '*.txt'
    nextflow run test_file1.nf --in NO_FILE
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

if(params.in == "NO_FILE") {
    Channel.empty().set {file_ch}
} else {
    //Channel.fromPath(params.in).set {file_ch}
    Channel.fromPath(params.in.split(/\s+/).flatten()) // allow input can be space-separated multiple strings
    //    .map { it -> file(it) }
        .set {file_ch}
}

process view_file {
    echo true

    input:
    path f from file_ch

    output:
    path 'line_count.txt' into line_count_ch

    script:
    """
    echo File: $f
    wc -l $f >line_count.txt
    """
}

// combine all output and view it
line_count_ch
//    .collect() { it.text } // return a list as a whole
//    .map() { it.text } // return each element separately
    .flatMap() { it.text } // same as above
    .collectFile(name: 'final_line_count.txt', newLine: true)
    .view()

