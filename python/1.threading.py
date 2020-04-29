import threading;
from queue import Queue;
import time;
import sys;

def testThread(num):
    print("This is %d" % (num));


if __name__ == "__main__":
    for i in range(5):
        t=threading.Thread(target=testThread, args=(i,));
        t.start();

sys.exit(0);

