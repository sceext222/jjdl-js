# config.coffee, jjdl_android/src/

P_VERSION = 'jjdl_android version 0.2.0-1 test20171105 1617'
P_REPO = 'https://github.com/sceext222/jjdl-js'


SITE_LIST = [
  'jjwxc'
  'mjjwxc'
  'myushuwu'
  'myushuwu-c'
  'myushuwu-c2'
]

# root path to store jjdl_android files
SDCARD_JJDL_ROOT = '/sdcard/jjdl/'
CACHE_PATH = '/sdcard/jjdl/cache'

# assets files
LICENSE_FILE = 'LICENSE'
PM_BRIDGE_URL = 'file:///android_asset/pm_bridge.html'
LOCAL_URL_PREFIX = 'file://'
EXTERNAL_CORE = '/sdcard/jjdl/core/pm_bridge.html'
EXTERNAL_LIST = '/sdcard/jjdl/core/site_list'


module.exports = {
  P_VERSION
  P_REPO

  SITE_LIST

  SDCARD_JJDL_ROOT
  CACHE_PATH

  LICENSE_FILE
  PM_BRIDGE_URL
  LOCAL_URL_PREFIX
  EXTERNAL_CORE
  EXTERNAL_LIST

  # runtime vars
  store: null  # redux store

  # loaded assets
  license_text: null
}
