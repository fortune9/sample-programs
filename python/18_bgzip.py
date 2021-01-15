#!/usr/bin/env python

import sys;
import logging;
import bgzip;

logging.basicConfig(level=logging.DEBUG);

f="modules.log.gz";

with open(f, "rb") as raw:
    with bgzip.BGZipReader(raw) as fh:
        fh.seek(10);
        data=fh.read(10);
        print(data.decode());

sys.exit(0);
