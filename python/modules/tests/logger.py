import logging;
import modules.tests;

def print_loggers():
    '''
    print all existing logger names, including root
    '''
    for name in logging.root.manager.loggerDict:
        print("Found logger '%s' in '%s'" % (name,__name__))

logger=logging.getLogger(__name__);
print_loggers();

logger.debug("Logging from child logger '%s'", __name__);
#print("Loading from child logger '%s'" % __name__);
#print("I can see the value %d in __init__.py" % modules.tests.init_x);

if __name__ == '__main__':
    #print("I am in %s" % __file__)
    logger.info("This is the logger %s", __name__);

