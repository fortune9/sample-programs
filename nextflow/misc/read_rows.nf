params.in='./'
params.sep=','
params.header=true

log.info """\
    NEXTFLOW PIPELINE -- COUNT LINES
    ================================
    input: ${params.in}
    sep: ${params.sep}

    This program reads a text file and output
    each row separately.

    Available parameters:
    --in: input file
    --sep: field separator
    --header: true (default): input file has header; false: no header
    """
    .stripIndent()

if(! params.in) {
    exit 1, "No input file"
}

Channel
    .fromPath(params.in, checkIfExists: true, type: 'any')
    .splitCsv(header:params.header, sep:params.sep)
    .set {file_ch}


process output_row {
    echo true
    publishDir params.outdir, mode: 'copy'

    input:
    val row from file_ch

    output:
    path "new_file.txt" into new_file_ch

    script:
    println row
    """
    echo $row >new_file.txt
    """
}

/*
line_count_ch
    .collectFile()
    .view()
*/

workflow.onComplete {
    log.info (
        workflow.success ? 
            "\nDone! Results are in -> $params.outdir\n"
            : "Oops .. something went wrong"
            )
}

