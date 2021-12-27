// Output channel size

nextflow.enable.dsl = 2

if(! params.infiles) {
    exit 1, "Usage: nextflow run channel_size.nf --infiles='./*.nf'"
}

Channel
    .fromPath(params.infiles)
    .set {ch_file}

// This doesn't work
println "here is  ${ch_file.count().view()}"
//ch_file.pat.view() {it -> it.name}
ch_file.count().view() { it -> "The channel size is $it" }

