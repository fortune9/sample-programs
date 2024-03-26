
process generate_ch1 {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(txt)

    output:
    tuple val(sample_id), path("out.txt"), emit: result

    script:
    """
    touch out.txt
    """
}

process generate_ch2 {
    tag "$sample_id"

    input:
    tuple val(sample_id), path(txt)

    output:
    tuple val("$sample_id"), path("out1.txt"), emit: result

    script:
    """
    touch out1.txt
    """
}

workflow {
    

    ch1 = Channel
            .fromPath(params.infile1, checkIfExists: true)
            .splitCsv(header: ["chunk_id","index"], sep: "\t")
            .map { row -> 
                [ row.chunk_id, row.index ] }

    ch2 = Channel
            .fromPath(params.infile2, checkIfExists: true)
            .splitCsv(header: ["chunk_id","index"], sep: "\t")
            .map { row -> 
                [ row.chunk_id, row.index ] }

    ch1
        .join(ch2, by: 0)
        .filter { id, i1, i2 -> i1 != i2 }
        .view()

    return

    /*
    ch1
        .combine(ch2, by: 0)
        .view()
    */

    res1 = generate_ch1(ch1).result
    res2 = generate_ch2(ch2).result
    
    res1
        .view() { id, f -> "res1: $id $f" }
    res2
        .view() { id, f -> "res2: $id $f" }

    res1
        .combine(res2, by: 0)
        .set { merged_res }

    merged_res
        .view() { it -> "merged: $it" }

    merged_res
        .map { it -> "$it" }
        .collectFile(name: "tmp_result.csv", newLine: true, storeDir: "/home/ubuntu/work/temp")
        .view()
}

