
log.info """\
    Check whether the file object can be used to
    print out its content
    """

params.in=""

if( !params.in ) {
    println "Argument '--in' is required"
    exit 1
}


process write_file {
    echo true

    input:
    path f from Channel.fromPath(params.in)
    //val f from Channel.fromPath(params.in) // not stage file, not
    //working in containers, but ok for local

    script:
    if(Class.forName("sun.nio.fs.UnixPath").isInstance(f)) {
        println "$f is class 'sun.nio.fs.UnixPath'"
    }
    //println f.getClass()
    println f.class
    println f
    println f.toString().class
    println f.toString()
    println "Basename: " + f.baseName
    println "Filename: " + f.getFileName()
    //println f.text()
    """
    cat $f
    """
}
