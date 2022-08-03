
params.in=null
def prog="resource_check.nf"

log.info """\
    NEXTFLOW PIPELINE
    ===================================
    This program tests how CPU and memory setting
    affects the performance of a process

    It also read files, and S3 and local files may
    perform differently, particularly for big files.

    Example uses:
    nextflow run test_file1.nf --in '*.txt'
    nextflow run test_file1.nf --in NO_FILE
    # new feature
    nextflow run test_file1.nf --in 'a*.txt  b*.txt'
    ------------------------------------
    Input: ${params.in}
    awsMaxTransfer: ${params.awsMaxTransfer}
    batchQueue: ${params.awsQueue}
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

x = new java.util.Date()
println "file_ch channel ${x.toString()}"

process view_file {
    echo true

    input:
    path f from file_ch

    output:
    path 'line_count.txt' into line_count_ch

    script:
    """
    echo mem: ${task.memory}
    echo cpus: ${task.cpus}
    echo File: $f
    if [[ "$f" =~ \\.gz\$ ]]; then
        zcat $f | head -1000 | wc -l >line_count.txt
    else
        cat $f | wc -l >line_count.txt
    fi
    """
}

// combine all output and view it
line_count_ch
//    .collect() { it.text } // return a list as a whole
//    .map() { it.text } // return each element separately
    .flatMap() { it.text } // same as above
    .collectFile(name: 'final_line_count.txt', newLine: true)
    .view()

