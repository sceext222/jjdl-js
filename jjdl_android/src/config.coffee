# config.coffee, jjdl_android/src/

P_VERSION = 'jjdl_android version 0.1.0-1 test20171031 2331'
P_REPO = 'https://github.com/sceext222/jjdl-js'


SITE_LIST = [
  'jjwxc'
  'mjjwxc'
  'myushuwu'
]

# root path to store jjdl_android files
SDCARD_JJDL_ROOT = '/sdcard/jjdl/'

CACHE_PATH = '/sdcard/jjdl/cache'
LICENSE_FILE = 'LICENSE'


module.exports = {
  P_VERSION
  P_REPO

  SITE_LIST

  SDCARD_JJDL_ROOT
  CACHE_PATH
  LICENSE_FILE

  # runtime vars
  store: null  # redux store
}
