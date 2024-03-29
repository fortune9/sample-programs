params.outdir="misc_out"

process FILE_SIZE {
    debug params.verbose
    tag "${task.index}"
    //label 'process_low8'
    cpus 2
    memory { def s=fileList*.size().max() as MemoryUnit ;
            def minMem = MemoryUnit.of('4 GB');
            def maxMem = MemoryUnit.of('7 GB');
            s = s < minMem ? minMem : s;
            s = s > maxMem ? maxMem : s;
            s
         }
    time '1 d'

    publishDir "${params.outdir}"

    input:
    path fileList

    output:
    path "${task.index}/stats.txt", emit: stat

    script:
    println "Input size: " + fileList.size()
    println "File sizes: " + fileList*.size()
    """
    taskId=${task.index}
    mkdir \$taskId
    outFile=${task.index}/stats.txt
    echo "${task.memory} -- ${task.cpus} -- ${task.time}" >\$outFile
    for i in ${fileList}
    do
        echo \$i >>\$outFile
        stat -c %s -L \$i >>\$outFile
    done
    """
}

