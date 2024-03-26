/*
Channel
    .of( [1], [2], 3, 4 )
    .collect()
    .view()
*/

nextflow.enable.dsl=2


def my_test(val, ch_file) {
    
    def fileContents = new File(val).text
    //def fileContents = val.text
    def resultMap = [:]

    fileContents.eachLine { line ->
    // Split each line by a delimiter, such as '='
    def parts = line.split(' : ')

    // Extract key and value
    def key = parts[0].trim()
    def value = parts[1].trim()

    // Add key-value pair to the map
    resultMap[key] = value
    }

    return resultMap
}

process file_to_map {
    tag "$val"

    input:
    val inFile
    path in_ch

    output:
    val resultMap, emit: myMap

    exec:
    def fileContents = file(in_ch).text
    //def fileContents = val.text
    def resultMap = [:]
    fileContents.eachLine { line ->
    // Split each line by a delimiter, such as '='
    def parts = line.split(' : ')
    // Extract key and value
    def key = parts[0].trim()
    def value = parts[1].trim()
    // Add key-value pair to the map
    resultMap[key] = value
    }

}


left  = Channel.of(['X', 1], ['Y', 2], ['Z', 3], ['P', 7])
right = Channel.of(['Z', 6], ['Y', 5], ['X', 4])
//left.join(right).view()

workflow {

    outFile = "${params.outdir}/my_channel.tsv"
    left
        .map { it -> "${it[0]} : ${it[1]}" }
        .collectFile(
            name: "my_channel.tsv", 
          //  name: outFile,
            newLine: true,
            storeDir: "${params.outdir}"
            )
        .set { mapFile }

    //println mapFile.first()
    mapFile.view()

    //myMap = my_test(outFile, mapFile)
    myMap = file_to_map(outFile, mapFile).myMap
    println myMap

}

