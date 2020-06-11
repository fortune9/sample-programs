# a test of writing iterator class.
# which must have __next__() method


class my_iterator():
    '''
    an iterator to return numbers
    '''

    def __init__(self, max=0):
        self.n=0;
        self.max=max;

    def __next__(self):
        if self.n <= self.max:
            res=f"Hello {self.n}";
            self.n+=1;
            return res;
        else:
            raise StopIteration;

class my_iterable():
    '''
    an iterable to return numbers
    '''
    def __init__(self, max=0):
        self.n=0;
        self.max=max;

    def __next__(self):
        if self.n <= self.max:
            res=f"Hello {self.n}";
            self.n+=1;
            return res;
        else:
            raise StopIteration;

    def __iter__(self):
        '''
        This function makes this class an iterable, because it adds a
        function iter()
        '''
        self.n=0;
        return(self);

if __name__ == '__main__':
    maxN=10;
    print("Iterator class");
    iter1=my_iterator(maxN); # this is iterator, can't be used in
    try:
        iter(iter1);
        print("Iterator has iter() method");
    except:
        print("Iterator has no iter() method");

    try:
        print(next(iter1));
        print("Iterator has next() method");
    except:
        print("Iterator has no next() method");

    # for loop as iterable
    for i in range(maxN):
        print("{0} : {1}".format(i, next(iter1)));

    print("Iterable class");
    iter2=my_iterable(maxN);
    try:
        iter(iter2);
        print("Iterable has iter() method");
    except:
        print("Iterable has no iter() method");

    try:
        print(next(iter2));
        print("Iterable has next() method");
    except:
        print("Iterable has no next() method");

    for s in iter2:
        print(s);

