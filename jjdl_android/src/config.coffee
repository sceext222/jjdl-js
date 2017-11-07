# config.coffee, jjdl_android/src/

P_VERSION = 'jjdl_android version 0.2.0-2 test20171108 0204'
P_REPO = 'https://github.com/sceext222/jjdl-js'


# root path to store jjdl_android files
SDCARD_JJDL_ROOT = '/sdcard/jjdl/'
CACHE_PATH = '/sdcard/jjdl/cache'

# assets files
LICENSE_FILE = 'LICENSE'
ANDROID_ASSET_URL = 'file:///android_asset/'
FILE_URL = 'file://'

CORE_DIR = 'core'  # android_asset/core/
EXTERNAL_CORE_DIR = '/sdcard/jjdl/core'

CORE_PM_BRIDGE = 'pm_bridge.html'
CORE_SITE_LIST = 'site_list'
CORE_META = 'core_meta.json'


module.exports = {
  P_VERSION
  P_REPO

  SDCARD_JJDL_ROOT
  CACHE_PATH

  LICENSE_FILE
  ANDROID_ASSET_URL
  FILE_URL

  CORE_DIR
  EXTERNAL_CORE_DIR

  CORE_PM_BRIDGE
  CORE_SITE_LIST
  CORE_META

  # runtime vars
  store: null  # redux store

  # loaded assets
  license_text: null
}
