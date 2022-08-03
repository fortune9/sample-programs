// test how params are set when including a workflow

nextflow.enable.dsl=2

params.msg="workflow msg"
params.moduleInput="module input initiated in main"
params.globalInput="global input in main"

/*
// external environment, and they are immune to command line changes
include { sub_wf1 as sub_wf2 } from "./sub_workflow1.nf" params (
    globalInput: "global input added wf2",
    moduleInput: "module input added wf2"
)
*/

// also include a process
include { print_info as pi} from \
    './sub_process.nf' addParams (
    globalInput: "global input added for print_info",
    moduleInput: "module input added for print_info"
    )

include { print_msg1 as msg1 } from \
    '../process/msg.nf' addParams (
        msg: "workflow msg1"
        )

workflow {
    log.info """
    In main script:
    globalInput: ${params.globalInput}
    moduleInput: ${params.moduleInput} // No access
    moduleInputNoChange: ${params.moduleInputNoChange} // no access
    """
//    sub_wf2()
//    print_info()
    pi()
    msg1()
}

