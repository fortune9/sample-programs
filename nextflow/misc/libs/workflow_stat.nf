// collect info for a workflow
def workflow_info(params, workflow, nextflow) {
    // create a map to store the info
    workflowInfo=[:]
    workflowInfo['Nextflow Version'] = nextflow.version
    workflowInfo['Pipeline Repository'] = workflow.repository
    workflowInfo['Pipeline Release'] = workflow.revision
    workflowInfo['Workflow Profile']   = workflow.profile
    workflowInfo['Workdir']   = workflow.workDir
    workflowInfo['Outdir']   = params.outdir
    workflowInfo['Config Files']   = workflow.configFiles
    workflowInfo['Container']   = workflow.container
    workflowInfo['User Command']   = workflow.commandLine
    workflowInfo['Genome Version'] = params.genome
    workflowInfo['Annotation DB'] = params.annoSrcDb

    if (workflow.profile == 'awsbatch') {
        workflowInfo['AWS Region']   = params.awsRegion
        workflowInfo['AWS Queue']    = params.awsQueue
    }

    return workflowInfo
}

import groovy.json.JsonOutput
// object to json format
def obj_to_json(obj) {
    
    def json_str = JsonOutput.prettyPrint(JsonOutput.toJson(obj))
    return json_str
}
