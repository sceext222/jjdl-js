# op.coffee, jjdl_android/src/action/

RNFS = require 'react-native-fs'

config = require '../config'
util = require '../util'
action = require './root'


check_cache = ->
  (dispatch, getState) ->
    if await RNFS.exists(config.CACHE_PATH)
      dispatch action.set_cache_path(config.CACHE_PATH)
    else
      dispatch action.set_cache_path(null)

load_assets = ->
  (dispatch, getState) ->
    # load LICENSE
    config.license_text = await RNFS.readFileAssets config.LICENSE_FILE
    dispatch action.set_loaded('license', true)
    # pm_bridge.html
    config.pm_bridge_html = await RNFS.readFileAssets config.PM_BRIDGE_HTML
    dispatch action.set_loaded('pm_bridge', true)
    # load lib.js first
    config.lib_js = await RNFS.readFileAssets config.LIB_JS
    # jjdl_core.js
    config.jjdl_core_js = await RNFS.readFileAssets config.JJDL_CORE_JS
    dispatch action.set_loaded('jjdl_core', true)

clear_cache = ->
  (dispatch, getState) ->
    dispatch action.set_is_cleaning(true)
    try
      await util.rm_tree config.CACHE_PATH
    catch e
      # just ignore
    dispatch action.set_is_cleaning(false)
    # check again after clean
    dispatch check_cache()

start_jjdl = ->
  (dispatch, getState) ->
    # check url empty
    url = getState().get 'url'
    if url.trim() is ''
      return  # just ignore

    dispatch action.set_is_doing(true)

module.exports = {
  check_cache  # thunk
  load_assets  # thunk
  clear_cache  # thunk

  start_jjdl  # thunk
}
