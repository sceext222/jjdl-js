# config.coffee, jjdl_android/src/

P_VERSION = 'jjdl_android version 0.1.0 test20171102 2016'
P_REPO = 'https://github.com/sceext222/jjdl-js'


SITE_LIST = [
  'jjwxc'
  'mjjwxc'
  'myushuwu'
]

# root path to store jjdl_android files
SDCARD_JJDL_ROOT = '/sdcard/jjdl/'
CACHE_PATH = '/sdcard/jjdl/cache'

# assets files
LICENSE_FILE = 'LICENSE'
PM_BRIDGE_URL = 'file:///android_asset/pm_bridge.html'


module.exports = {
  P_VERSION
  P_REPO

  SITE_LIST

  SDCARD_JJDL_ROOT
  CACHE_PATH

  LICENSE_FILE
  PM_BRIDGE_URL

  # runtime vars
  store: null  # redux store

  # loaded assets
  license_text: null
}
