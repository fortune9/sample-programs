/*
 * This pipeline does the following 2 things:
 * 1. merge CpG contexts from two strands into one
 * 2. rename/compress the file to follow the format <id>_CpG.bedGraph.gz
 */

// default output dir
params.outdir = "results"

log.info """\
         Merge Context in BedGraph - N F   P I P E L I N E
         ===================================
         genome : ${params.genome}
         bgFile : ${params.bgfile}
         outdir : ${params.outdir}
         """
         .stripIndent()

Channel
    .fromPath( params.bgfile, checkIfExists:true)
    .set {bgFiles}

process index {
    input:
    path genome from params.genome
    //path genome from Channel.fromPath(params.genome)

    output:
    path faIndex into fa_index

    script:
    faIndex=genome + '.fai'
    """
    samtools faidx $genome
    """
}

process merge {
    
    publishDir params.outdir, mode: 'copy'
    cpus 2

    input:
    path f from bgFiles
    path faIndex from fa_index
    path genome from params.genome

    output:
    path "*.bedGraph.gz", emit: outfile

    script:
    """
    #echo \$PATH
    out=\$(basename $f)
    out=\${out/%_R1_val_*/.bedGraph.gz}
    MethylDackel mergeContext  $genome $f | gzip -c >\$out
    #merge_context.sh ${genome} $f
    """
}

workflow.onComplete {
        log.info ( workflow.success ? "\nDone! Results are in --> $params.outdir\n" : "Oops .. something went wrong" )
}

