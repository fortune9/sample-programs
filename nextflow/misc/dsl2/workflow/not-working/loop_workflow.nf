// Define the subworkflow as a process
process subWorkflow {
    input:
    val inputVal

    script:
    """
    echo "Running subworkflow with input: $inputVal"
    """
}

// Define the main workflow
workflow {

    // Define a list of inputs
    list_of_inputs = [1, 2, 3, 4, 5]

    // Iterate over the list of inputs
    for (inputVal in list_of_inputs) {

        // Call the subworkflow process with each input value
        subWorkflow(inputVal)
    }
}
