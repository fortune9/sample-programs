
# this program shows how python's coroutine works

def print_name(pref):
    print("Searching prefix: {}".format(pref));
    while True:
        name=(yield "Justice");
        if pref in name:
            print(name);


if __name__ == '__main__':
    corou=print_name("Hello"); # get the coroutine object, nothing prints
    #corou.__next__(); # reach first yield
    next(corou); # needed before sending any data
    print("Sending inputs");
    got=corou.send("ZZ"); # add more data and resume
    print(f"I got '{got}'")
    corou.send("Hello LZ"); # this will print
    corou.send("Hello Joyce"); # and this too, because containing 'Hello'
    #corou.close();

