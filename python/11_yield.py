def test_yield():
    yield "a statement";
    got=(yield "expression");
    print(f"I got '{got}'");
    print("done");


if __name__ == '__main__':
    gen=test_yield();
    #gen.send("First sent"); # triggered errors
    print("First call");
    ret=next(gen);
    print(f"ret is {ret}"); # return the value following 'yield'
    print("Second call");
    ret=next(gen); # value following yield
    print(f"ret is {ret}");
    print("Third call");
    ret=gen.send("third sent"); # no more value to return
    print(f"ret is {ret}");
