nextflow.enable.dsl=1

log.info """\
    NEXTFLOW PIPELINE
    =================
    This demonstrates how to use scope variables
    """
    .stripIndent()

// params are defined in nextflow.config
/*
params {
    L11 = "Level 1, Element 11"
    L12 {
        L121 = "Level 2, Element 121"
        }
    }
*/

params.label = null

// The ways to access scope variables
// if in string, '$' is required
println "$params.L11"
// two different ways of access elements: '.' and []
println params.L12['L121']
println params.L12.L121

// variable overrides
println "mem:" + params.maxMemory
println "outdir:" + params.outdir

// some workflow metadata
println "profile:" + workflow.profile
if("$workflow.profile".contains("test")) {
    println "I am in test mode"
}

process test_proc {
    // one can use parameter to control the label
    // both of the following work
    //label "${ params.label == null ? 'basic' : params.label }"
    label params.label == null ? 'basic' : params.label 
    echo true
    //cpus { "$workflow.profile".contains("test") ? 1 : 2}

    script:
    """
    echo "This is a test process: ${task.label}"
    echo "CPUS: ${task.cpus}"
    echo "MEM: ${task.memory}"
    """
}
