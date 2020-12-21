#!/usr/bin/env python
import sys;
import logging;

def return_str(x: str, y: str="fixed") -> str:
    '''
    receive strings and return a string
    '''
    return(x+" "+y);

def return_list(x: list, y: list=[1,2]) -> list:
    '''
    combine two lists
    '''
    return(x+y);

print(return_str("ZZG","Good"));
print(return_str("ZZG"));

print(return_list([3,4,9]));

