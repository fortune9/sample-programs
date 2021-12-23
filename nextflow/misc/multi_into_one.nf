/*
This program tests whether one input channel can receive
inputs from the outputs of multiple channels
*/

log.info """
Nextflow Pipeline Sample
=====================================
Example:
nextflow run multi_into_one.nf

The program shows that the same channel can't
be used more than twice (input or output).
"""

multi_ch = Channel.empty()

process in1 {
    output:
    val 'x' into multi_ch1 // need be unique, can't use multi_ch

    exec:
    x="in1"
}

process in2 {
    output:
    val 'y' into multi_ch2 // need be unique, can't use multi_ch

    exec:
    y="in2"
}

process out {
    echo true

    input:
    val i from multi_ch1.mix(multi_ch2)

    script:
    """
    echo Received $i
    """
}
