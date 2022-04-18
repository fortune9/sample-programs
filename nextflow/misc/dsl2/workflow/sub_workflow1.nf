
nextflow.enable.dsl=2

// this parameter is defined in including parameter too.
params.globalInput="global input in module"
// the following parameter is module-specific, so need use addParams
// in including script
params.moduleInput="module input"
params.moduleInputNoChange="module input no change"

workflow sub_wf1 {
    log.info """
    In workflow sub_wf1:
    globalInput: ${params.globalInput}
    moduleInput: ${params.moduleInput}
    moduleInputNoChange: ${params.moduleInputNoChange}
    """
}


workflow {
    println "You won't see this if this script is included/imported"
    sub_wf1()
}

