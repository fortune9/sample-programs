#!/usr/bin/env python

import multiprocessing as mp;
import random;
import string;
import sys;

random.seed(123);

# define an output queue
output=mp.Queue();

# define a function
def rand_string(length, output):
    rand_str=''.join(random.choice(
        string.ascii_lowercase +
        string.ascii_uppercase +
        string.digits) 
        for i in range(length));
    output.put(rand_str);

# setup a list of processes to run
processes=[mp.Process(target=rand_string, args=(5,output)) for i in range(4)];

# run the processes
for p in processes:
    print("Starting process %s" %(p.name));
    p.start();

# wait the processes to finish
for p in processes:
    p.join();

# get results from the queue
results=[output.get() for p in processes];

print(results);

sys.exit(0);

