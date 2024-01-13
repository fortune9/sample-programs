nextflow.enable.dsl=2

process print_value {
    debug true

    input:
    val inputList

    script:
    println inputList.getClass()
    """
    for i in $inputList
    do
        echo \$i
    done
    """

}

Channel
    .of(1,2,3,4,5,6,7,8)
    //.buffer(size:3, remainder: true)
    .collate(3) // the same as above buffer
    .set {ch_list}

workflow {
    print_value(ch_list)
}

