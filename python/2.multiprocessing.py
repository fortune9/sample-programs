import multiprocessing;
import sys;

def spawn(id):
    print("This is multiprocessing process %d" %(id));

if __name__ == "__main__":
    for i in range(5):
        p=multiprocessing.Process(target=spawn, args=(i,));
        p.start();

sys.exit(0);


