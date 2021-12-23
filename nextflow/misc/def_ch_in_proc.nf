/* This process is to test whether one can
define channels inside a process
*/

params.infile=null

if(! params.infile) {
    exit 1, "parameter '--infile' is needed"
}

process test_ch {
    // yes, we can define channel in process
    Channel
        .fromPath(params.infile, checkIfExists: true)
        .set{ch_in}

    // this script block is always needed
    script:
    """
    echo "${ch_in.view()}"
    """
}

