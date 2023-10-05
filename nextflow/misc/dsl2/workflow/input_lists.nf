/*
example use:
nextflow run input_lists.nf --id test --fileList '*.txt'

the parameter for '--fileList' must be quoted
*/

nextflow.enable.dsl=2

process count_lines {
    debug true
    tag "$id"

    input:
    val id
    path fileList

    script:
    println fileList.getClass()
    """
    # if a collected channel, here fileList is automatically converted
    # to a bash array
    echo $id: $fileList
    for f in ${fileList}
    do
        echo $id for \$f: `wc -l "\$f"` # quote the filename in case spaces in it
    done
    """
}

if(!params.id) {
    exit 1, "option --id is required"
}

if(params.fileList == null) {
    exit 1, "option --fileList is required"
}

def id = params.id
ch_file_list = Channel
                .fromPath(params.fileList, checkIfExists: true)

workflow {
    // files as a channel
    //count_lines(params.id, ch_file_list)
    // files as a list
    println "Rerun by using files as a list"
    count_lines(params.id, ch_file_list.collect())
}
