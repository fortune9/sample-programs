#!/usr/bin/env python

def z_try():
    try:
        print("I am in z-try without problem");
    except:
        pass;

def z_try_except():
    try:
        print("try_except here" + x)
    except:
        print("z_try_except is wrong")

def z_final():
    try:
        print(d);
    except Exception as inst:
        print("Exception is ", inst);
    finally:
        print("Run in finally")


if __name__ == '__main__':
    z_try();
    z_try_except();
    z_final();

