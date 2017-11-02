# config.coffee, jjdl-js/src/

P_VERSION = 'jjdl-js version 0.2.0-3 test20171103 0153'


LOG_PREFIX = 'jjdl-js'
LOG_P = {
  d: 'D'  # DEBUG
  w: 'W'  # WARNING
  e: 'E'  # ERROR
  i: 'I'  # INFO
  o: ' [ OK ] '
}

CACHE_DIR = 'cache'
OUTPUT_DIR = 'dl'

META_FILE = ['jjdl-', '-meta.json']
PACK_FILE = '-jjdl.txt'


module.exports = {
  P_VERSION

  LOG_PREFIX
  LOG_P

  CACHE_DIR
  OUTPUT_DIR

  META_FILE
  PACK_FILE
}
