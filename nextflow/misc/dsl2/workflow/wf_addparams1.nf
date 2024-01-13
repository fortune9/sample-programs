/*
This workflow shows that parameters with uppercase
letters in names differ from those with lowercase
only in terms of parameter override.
*/

nextflow.enable.dsl=2

params.msg="workflow msg lower case"
params.msG="workflow msg upper case"
params.testvar=false

// include the process
include { print_msg } from \
    './msg.nf' addParams (
        //msg: "include msg lower case",
        msg: params.msg,
        msG: "include msg upper case"
        )


workflow {
    print_msg()
    if(params.testvar) {
        println "${params.testvar} is true"
    } else {
        println "${params.testvar} is false"
    }
}

