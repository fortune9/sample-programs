#!/usr/bin/env python

import logging;

logging.basicConfig(format='%(asctime)s %(message)s', 
        datefmt='%m/%d/%Y %I:%M:%S %p',
        level=logging.DEBUG);

logging.debug("This is a debug message");
logging.info("This is a info messsage");
logging.warning("This is a warning message");
logging.error("This is an error message");

print("Logging is done");


