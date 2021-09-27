
Channel
    .fromPath(params.s3path, checkIfExists:true)
    .set {file_ch}

file_ch.println()

