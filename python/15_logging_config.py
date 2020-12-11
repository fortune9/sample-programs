#!/usr/bin/env python

import sys;
import modules.tests.logger;
import logging;

print("""
This program tests how logging system is triggered when a module
is imported, here modules.tests.logger. As you can see, the logger
is created when the module is imported and named after module's name.
In addition to the module's loggers, the root logger is also
configured in modules/conf/logger.json, and is called when a root
logger is created.

The root logger uses StreamHandler and the module's logger uses
FileHandler into 'modules.log'.
""");

print("Loading succeed");

log=logging.getLogger(); # get the root logger
log.info("This is the logger from main program");

