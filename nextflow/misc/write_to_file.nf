#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

workflowInfo=[:]
workflowInfo['Nextflow Version'] = "${nextflow.version}"
workflowInfo['Pipeline Release'] = workflow.revision
workflowInfo['Workflow Profile']   = workflow.profile
workflowInfo['Annotation DB'] = params.annoSrcDb

import groovy.json.JsonOutput

def json_str = JsonOutput.toJson(workflowInfo)

println JsonOutput.prettyPrint(json_str)


out=file("workflow.log")
out.text = JsonOutput.prettyPrint(json_str)

log.info "Log info is written to ${out.name}"
