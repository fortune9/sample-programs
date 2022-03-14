
nextflow.enable.dsl=2

include { sub_wf1 } from './sub_workflow_include_process.nf'

workflow {
    log.info """
    This is the main workflow, and calling a sub
    workflow from ./sub_workflow_include_process.nf
    """

    sub_wf1()
}

