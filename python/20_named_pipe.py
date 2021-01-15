#!/usr/bin/env python

import os, time, sys
pipe_name = 'pipe_test'

def child( ):
    pipeout = os.open(pipe_name, os.O_WRONLY)
    counter = 0
    while True:
        time.sleep(1)
        os.write(pipeout, b'Number %03d\n' % counter)
        counter = (counter+1) % 5
    print("Child completed");

def parent( ):
    pipein = open(pipe_name, 'r')
    counter=0;
    while True:
        line = pipein.readline()[:-1]
        print('Parent %d got "%s" at %s' % (os.getpid(), line,
            time.time( )))
        counter+=1;
        if counter > 10:
            break;
    pipein.close();
    print("Parent completed");

if not os.path.exists(pipe_name):
    os.mkfifo(pipe_name)  
pid = os.fork()    
if pid != 0:
    parent()
else:       
    child()
