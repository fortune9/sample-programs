// test inclusion of processes twice and see
// 1. how channels defined in process file be used?
// 2. how change parameters affect each inclusion

nextflow.enable.dsl=2

params.msg="workflow msg"

// inclusion of print_msg doesn't work, because needs ch_msg as input

include { print_msg1 as msg0 } from \
    '../process/msg.nf'

include { print_msg1 as msg1 } from \
    '../process/msg.nf' addParams (
        msg: "workflow msg1"
        )

include { print_msg1 as msg2 } from \
    '../process/msg.nf' addParams (
        msg: "workflow msg2"
        )


workflow {
    msg0()
    msg1()
    msg2()
}

