
process print_msg {

    echo true

    script:
    """
    echo msg: ${params.msg}
    echo msG: ${params.msG}
    """
}

