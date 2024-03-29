
params.fastqPath=false

if(! params.fastqPath) {
    exit 1, "Option --fastqPath is needed"
}

Channel
    .fromFilePairs("${params.fastqPath}", flat: true)
    .splitFastq(by: 2, pe: true, file: "nfs")
    .view()

