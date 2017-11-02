# config.coffee, jjdl_android/src/

P_VERSION = 'jjdl_android version 0.1.0-1 test20171102 0135'
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
PM_BRIDGE_HTML = 'pm_bridge.html'
JJDL_CORE_JS = 'jjdl_core.js'
LIB_JS = 'lib.js'

# LIB_JS html insert position
LIB_JS_INSERT = '// LIB_JS INSERT POSITION //'


module.exports = {
  P_VERSION
  P_REPO

  SITE_LIST

  SDCARD_JJDL_ROOT
  CACHE_PATH

  LICENSE_FILE
  PM_BRIDGE_HTML
  JJDL_CORE_JS
  LIB_JS

  LIB_JS_INSERT

  # runtime vars
  store: null  # redux store

  # loaded assets
  license_text: null
  pm_bridge_html: null
  jjdl_core_js: null
  lib_js: null
}
