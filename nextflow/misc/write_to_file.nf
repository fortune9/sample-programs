#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

params.outdir="results"

workflowInfo=[:]
workflowInfo['Nextflow Version'] = "${nextflow.version}"
workflowInfo['Pipeline Release'] = workflow.revision
workflowInfo['Workflow Profile']   = workflow.profile
workflowInfo['Output Path'] = "${params.outdir}"
workflowInfo['Annotation DB'] = params.annoSrcDb

import groovy.json.JsonOutput

def json_str = JsonOutput.toJson(workflowInfo)

println JsonOutput.prettyPrint(json_str)

if(! ("${params.outdir}" =~ /^s3:\//) ) {
    if(! file("${params.outdir}").exists() ) {
        exit 1, "Output folder ${params.outdir} doesn't exist"
    }
}
outFile="${params.outdir}/workflow.log"

out=file(outFile)
out.text = JsonOutput.prettyPrint(json_str)

log.info "Log info is written to ${outFile}"
