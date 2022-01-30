params.type='any'
params.maxdepth=1

Channel
    .fromPath(params.s3path, checkIfExists:true, type:params.type,
    maxDepth:params.maxdepth)
    .into {file_ch; file_ch1}

file_ch.println()

log.info "After filtering"

file_ch1
    .filter { "$it" =~ /process/ }
//    .count()
    .view()

