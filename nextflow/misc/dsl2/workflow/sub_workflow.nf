
nextflow.enable.dsl=2

params.run=false

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
}


workflow {
    println "You won't see this if this script is included/imported"
    sub_wf1()
}

