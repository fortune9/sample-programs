params.msg="This is default msg in msg.nf"

ch_msg = Channel.value(params.msg)

process print_msg {
    echo true
    input:
    val x

    script:
    println x
    """
    echo "Received: $x"
    """
}

process print_msg1 {
    echo true

    script:
    """
    echo ${params.msg}
    """
}

