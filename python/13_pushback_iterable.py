
# create a iterable which allows push back a popped value

class my_iterator():
    '''
    an iterator
    '''
    def __init__(self, max=0):
        self.n=0;
        self.stack=[];
        self.max=max;

    def __next__(self):
        if self.stack:
            currN=self.stack.pop(0);
        else:
            currN=self.n;
            self.n+=1;
        if currN <= self.max:
            res=f"Hello {currN}";
            return res;
        else:
            raise StopIteration;

    def push_back(self,val):
        self.stack.append(val);


class my_iterable():
    '''
    an iterable
    '''
    def __init__(self, max=0):
        self.max=max;

    def __iter__(self):
        '''
        This function makes this class an iterable, because it adds a
        function iter()
        '''
        return(my_iterator(self.max));

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
        print(next(iter1)); iter1.push_back(0);
        print("Iterator has next() method");
    except:
        print("Iterator has no next() method");

    # for loop as iterable
    twice=False;
    for i in range(maxN):
        print("{0} : {1}".format(i, next(iter1)));
        if i % 2 == 0: # use push back to make even number print twice
            if not twice:
                iter1.push_back(i);
                twice=True;
            else:
                twice=False;

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

    
