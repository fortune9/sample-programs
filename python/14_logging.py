#!/usr/bin/env python

import logging as lg;

# create my own logger
logger=lg.getLogger(__name__);
# set logger level, this controls what messages sent to handlers
logger.setLevel(lg.DEBUG);

# create handlers
c_handler=lg.StreamHandler();
f_handler=lg.FileHandler("file.log", mode="w");
c_handler.setLevel(lg.WARNING);
f_handler.setLevel(lg.DEBUG);

# create formatters and add to handlers
formatter=lg.Formatter('[%(asctime)s %(levelname)s] %(name)s - %(message)s',
        datefmt='%m/%d/%Y %H:%M:%S');
c_handler.setFormatter(formatter);
f_handler.setFormatter(formatter);

# add handlers to logger, can have multiple handlers
logger.addHandler(f_handler);
logger.addHandler(c_handler);

logger.debug("This is a debug message");
logger.info("This is a info messsage");
logger.warning("This is a warning message");
logger.error("This is an error message");

print("Logging is done");


