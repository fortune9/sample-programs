params.input='./'
params.resDir=null

log.info """\
    NEXTFLOW PIPELINE -- COUNT LINES
    ================================
    input: ${params.input}
    resDir: ${params.resDir}
    outdir: ${params.outdir}

    The <input can be either a folder or file>

    This program tests how to change output directory with
    the parameter '--resDir'
    """
    .stripIndent()


if(! (params.resDir && params.input) ) {
    exit 1, "Option --input and --resDir are required"
}

Channel
    .fromPath(params.input, checkIfExists: true, type: 'any')
    .set {file_ch}


process count_lines {
    echo true
    publishDir params.resDir, mode: 'copy'

    input:
    path f from file_ch.collect()

    output:
    path 'line_counts.txt' into line_count_ch

    script:
    """
    echo "#Input $f" >line_counts.txt
    if [[ -d "$f" ]]; then
        files=\$(find $f/ -type f -maxdepth 1 -not -path '*/.*')
    else
        files="$f"
    fi
    echo \$files
    for i in \$files
    do
        echo Counting \$i
        wc -l \$i >>line_counts.txt
    done
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

