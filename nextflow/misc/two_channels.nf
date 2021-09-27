/*
 * This pipeline does the following things:
 * 1. call methylation values using Methyldackel
 */

// default output dir
params.outdir = "bedgraph"
params.taskCpus = 1

log.info """\
         Call Methylation from Bam files - N F   P I P E L I N E
         ===================================
         genome : ${params.genome}
         bamFiles : ${params.bamfiles}
         outdir : ${params.outdir}
         """
         .stripIndent()


Channel
    .fromPath( params.bamfiles, checkIfExists:true)
    .set {bamFiles}

// index first
process index {
    input:
    path genome from Channel.fromPath(params.genome).collect()

    output:
    tuple path(genome), path(faIndex) into fa_index

    script:
    faIndex=genome + '.fai'
    """
    samtools faidx $genome
    """
}

// call methylation with index from 'index'
process call_meth {
    
    publishDir params.outdir, mode: 'copy'
    cpus params.taskCpus
    echo true

    input:
    tuple path(genome), path(faIndex) from fa_index
    path f from bamFiles

    output:
    path "*.bedGraph.gz", emit: outfile

    script:
    """
    out=\$(basename $f)
    out=\${out%_R1_val_*}
    MethylDackel extract -@ ${task.cpus} -o \$out --CHH --CHG \
        $genome $f && gzip *.bedGraph
    """
}

workflow.onComplete {
        log.info ( workflow.success ? "\nDone! Results are in --> $params.outdir\n" : "Oops .. something went wrong" )
}
