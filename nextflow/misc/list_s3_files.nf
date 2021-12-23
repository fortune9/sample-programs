params.type='any'
params.maxdepth=1

Channel
    .fromPath(params.s3path, checkIfExists:true, type:params.type,
    maxDepth:params.maxdepth)
    .set {file_ch}

file_ch.println()

