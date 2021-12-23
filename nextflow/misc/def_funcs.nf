nextflow.enable.dsl=2

def fun(msg="This is default") {
    log.info " $msg "
}

def minus(a=0,b=0) {
    a-b
}

fun("hello")
fun() // use default value

println minus(10,3)
println minus(b=10,a=3) // switch parameters doesn't work
println minus() // use default values work

