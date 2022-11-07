#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { workflow_info } from './libs/workflow_stat.nf'

process display_info_exec {

    debug true

    input:
    val info

    exec:
    println info.getClass()
    //set=info.entrySet()
    info.each { entry ->
        println "$entry.key --> $entry.value"
        }
}

process display_info_bash {

    debug true

    input:
    val info

    script:
    println info.getClass()
    //set=info.entrySet()
    bashCmd=""
    info.each { entry ->
        bashCmd += "$entry.key --> $entry.value\n"
        }
    """
    echo "$bashCmd"
    """
}


workflow {

    workflowInfo=workflow_info(params, workflow, nextflow)
    log.info "By Groovy"
    tmp1=display_info_exec(workflowInfo)
    log.info "By bash"
    display_info_bash(workflowInfo)
}

