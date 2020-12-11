import logging;
import logging.config as log_conf;
import json;
from pathlib import Path;

curDirPath=Path(__file__).parent; # the Path object of current dir

logConfFile=curDirPath / "conf/logger.json";

with open(logConfFile,"r") as f:
    logDict=json.load(f);

# use this dictionary to configure the top logging system
log_conf.dictConfig(logDict);

logger=logging.getLogger(__name__);
#logger=logging.getLogger(); # set root logger
logger.debug("Created logger named '%s'", __name__);

