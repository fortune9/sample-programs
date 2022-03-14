
nextflow.enable.dsl=2

params.run=false

// one can define variables and include processes
// include process
include { print_msg; print_msg1 } from '../process/msg.nf'
// define channel
ch_msg=Channel.value("Msg from subwork flow")

// the code outside of workflow scopes is run when
// inclusion by other scripts happens
if(!params.run) {
    log.info "Inclusion of workflows in this file not allowed"
    exit 1
}

workflow sub_wf1 {
    // the code runs when it is called by other workflows, not at
    // inclusion step
    if(!params.run) {
    log.info "Inclusion of sub_wf1 is not allowed"
    exit 1
    }
    println "This is sub_wf1"
    //print_msg(Channel.value("Printing using included process 'print_msg'"))
    //print_msg1()
    print_msg(ch_msg)
}


workflow {
    println "You won't see this if this script is included/imported"
    sub_wf1()
}

