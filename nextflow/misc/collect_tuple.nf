log.info """\
    NEXTFLOW Pipeline
    =================
    outdir: ${params.outdir}
    workdir: $workDir
    """
    .stripIndent()

Channel
    .from(['a', 1], ['b', 2], ['c',3])
    .set {tp_ch}

//tp_ch.view()

println "After collect()"

println tp_ch.collect().getClass()
//tp_ch.collect().view()

