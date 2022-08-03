
//nextflow.enable.dsl=2

// this parameter is defined in including script too.
params.globalInput="global input in module"
// the following parameter is module-specific, so need use addParams
// in including script
params.moduleInput="module input"
params.moduleInputNoChange="module input no change"

process print_info {
    echo true

    script:
    """
    cat <<EOF
    In print_info:
    globalInput: ${params.globalInput}
    moduleInput: ${params.moduleInput}
    moduleInputNoChange: ${params.moduleInputNoChange}
    EOF
    """
    
}

workflow sub_wf1 {
    print_info()
}


workflow {
    println "You won't see this if this script is included/imported"
    sub_wf1()
}

