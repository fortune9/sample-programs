// test how params are set when including a workflow

nextflow.enable.dsl=2

params.globalInput="global input in main"

// use addParams to add user-specific params
// note that all parameters setting here can be overriden by command
// line specifications
include { sub_wf1 } from "./sub_workflow1.nf" addParams (
    globalInput: "global input added wf1",
    moduleInput: "module input added wf1"
)

// use params to set module-specific values without being affected by
// external environment, and they are immune to command line changes
include { sub_wf1 as sub_wf2 } from "./sub_workflow1.nf" params (
    globalInput: "global input added wf2",
    moduleInput: "module input added wf2"
)



workflow {
    sub_wf1()
    log.info """
    In main script:
    globalInput: ${params.globalInput}
    moduleInput: ${params.moduleInput} // No access
    moduleInputNoChange: ${params.moduleInputNoChange} // no access
    """
    sub_wf2()
}

