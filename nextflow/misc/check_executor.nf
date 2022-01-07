
process executor_who {
    echo true
    // set conditional container
    container { "${task.executor}" == "awsbatch" ? \
    "002226384833.dkr.ecr.us-east-1.amazonaws.com/diffmeth:latest" :  null }

    script:
    """
    if [[ ${task.executor} == "awsbatch" ]]; then
        echo I am in awsbatch
    else
        echo I am in ${task.executor}
    fi
    """
}

