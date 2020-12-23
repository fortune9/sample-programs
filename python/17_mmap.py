#!/usr/bin/env python

from timeit import timeit;
import logging;
from mmap import mmap, ACCESS_READ;

def mmap_read(fh,start=0,size=-1):
    '''
    test read speed using mmap
    '''
    mm=mmap(fh.fileno(),0,access=ACCESS_READ);
    mm.seek(start);
    mm.read(size);
    #print(mm.read());
    mm.close();

def normal_read(fh, start=0, size=-1):
    '''
    read using the normal read
    '''
    fh.seek(start);
    fh.read(size);
    #print(fh.read())


logging.basicConfig(level=logging.DEBUG);
logger=logging.getLogger();

f="/home/ubuntu/tools/backup/tmp-work/genomes/ucsc/test.fa"
#f=__file__;

#fh1=open(f,"rt"); # read in text mode also work
#fh2=open(f,"rt");
fh1=open(f,"rb");
fh2=open(f,"rb");

times=100;

logger.info("mmap read")
print("used time: %r" % timeit("mmap_read(fh1)", number=times,
    globals=globals()));
logger.info("normal read")
print("used time: %r" % timeit("normal_read(fh2)", number=times,
    globals=globals()));

start=100;
size=10;
logger.info("mmap read, %d bytes from %d" % (size, start))
print("used time: %r" % timeit("mmap_read(fh1, start, size)", number=times,
    globals=globals()));
logger.info("normal read, %d bytes from %d" % (size, start))
print("used time: %r" % timeit("normal_read(fh2, start, size)", number=times,
    globals=globals()));

fh1.close();
fh2.close();

