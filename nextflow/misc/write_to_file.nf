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

def json_str = JsonOutput.prettyPrint(JsonOutput.toJson(workflowInfo))

println json_str

outFile="${params.outdir}/workflow.log"

Channel.of(json_str).set {ch_log} 
ch_log.count().view() {"size: $it"}

ch_log.collectFile(name: outFile)

if(! ("${params.outdir}" =~ /^s3:\//) ) {
    if(! file("${params.outdir}").exists() ) {
        exit 1, "Output folder ${params.outdir} doesn't exist"
    }
}

// for unknown reason, the following code has no effect,
// unless the channel operation lines 21-26 are removed
out=file(outFile)
// the following will not work if the outdir doesn't exist yet
//out.append(json_str)
out.text = "appended string"

log.info "Log info is written to ${outFile}"
