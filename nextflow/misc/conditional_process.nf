params.in="."
params.skip=false

log.info """\
    NEXTFLOW PIPELINE -- Conditional Process
    ========================================
    Input  :  ${params.in}
    Outdir :  ${params.outdir}
    Skip   :  ${params.skip}
    ========================================
    Example use:
    nextflow run conditional_process.nf --in "input/*.txt" --skip true
    """
    .stripIndent()

Channel
    .fromPath(params.in, checkIfExists:true)
    .into {file_ch; file_ch_bk}

process to_skip {
    input:
    path f from file_ch

    output:
    path f into file_ch2
    stdout line_cnt_ch

    when:
    !params.skip

    script:
    """
    wc -l $f
    """
}

// this is not working, no way to check whether a channel is empty
if(file_ch2.toList().size() == 0) {
    file_ch2.ifEmpty("file_ch2 is empty").view()
}

process summarize {
    echo true

    input:
    path f from params.skip? file_ch_bk : file_ch2
    val x from Channel.of(1..3)

    // one can define variables here
    def i="run"
    if(params.skip) {
        println "process 'to_skip' is skipped"
        i="skipped"
    }

    script:
    """
    echo "$i: $x --> $f"
    """
}

