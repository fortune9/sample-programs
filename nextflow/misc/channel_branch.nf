// separate files into channels based on file pattern

params.pattern='test'
params.infiles=null
//def pat = ~"${params.pattern}" // ~'string' to define pattern
def pat = /${params.pattern}/  // or /string/ to define, equivalent

if(! params.infiles) {
    exit 1, "Usage: nextflow run channel_branch.nf --infiles='./*.nf' --pattern '^def'"
}

Channel
    .fromPath(params.infiles)
    .branch {
        pat: it.name =~ pat // equivalent to it.name =~ /test/
        other: true
    }
    .set {ch_file}

log.info "Files matching pattern"
ch_file.pat.view() {it -> it.name}

/*
log.info "Other files"
ch_file.other.view() {it -> it.name}
*/
