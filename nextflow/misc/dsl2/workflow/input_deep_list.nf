/*
Test how a process to access a list of lists as input
*/

numbers = Channel.of(1, 2, 3)
words = Channel.of('hello', 'ciao')
numbers
    .combine(words)
    .set { ch_list }
//    .view()

//ch_list.view() { 'item:' + it }

process read_list {
    debug true
    
    input:
    val list

    script:
    println list
    """
    echo 'Bash: ${list[0]} -- ${list[1]}'
    """
}


process read_deep_list {
    debug true

    input:
    val list

    script:
    println 'deep: ' + list
    """
    echo 'Deep: $list'
    for i in $list
    do
        echo "Each deep: \$i"
    done
    """
}

workflow {
    read_list(ch_list)
    read_deep_list(ch_list.collect(flat:false))
}
