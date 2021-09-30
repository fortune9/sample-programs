
params.in=null

log.info """\
    NEXTFLOW PIPELINE
    ===================================
    Test different kinds of input files.
    'NO_FILE' is a special file which is
    absent.

    Example uses:
    nextflow run test_file.nf --in '*.txt'
    nextflow run test_file.nf --in NO_FILE
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
    Channel.fromPath(params.in).set {file_ch}
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

line_count_ch
    .subscribe {
        print it;
        print it.text
        }

