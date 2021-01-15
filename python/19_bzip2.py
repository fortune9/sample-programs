#!/usr/bin/env python

import sys;
import logging;
import bz2;

logging.basicConfig(level=logging.DEBUG);

f="modules.log.bz2";

with bz2.open(f, "rb") as fh:
    fh.seek(10);
    data=fh.read(10);
    print(data.decode());

sys.exit(0);
