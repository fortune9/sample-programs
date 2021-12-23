def msg="This is a message"

def func() {
    """
    echo This is a function >func_out.txt
    echo `pwd` >>func_out.txt
    """
}

process test_def {
    echo true
    publishDir "test_out"

    input:
    val msg from msg

    output:
    path "func_out.txt"

    func()

    script:
    """
    echo $msg
    """
}

