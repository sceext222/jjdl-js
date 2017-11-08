# op.coffee, jjdl_android/src/action/

path = require 'path-browserify'

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

_parse_list = (raw) ->
  o = []
  for i in raw.split('\n')
    one = i.trim()
    if one != ''
      o.push one
  if o.length > 0
    o
  else
    null

load_assets = ->
  (dispatch, getState) ->
    # load LICENSE
    config.license_text = await RNFS.readFileAssets config.LICENSE_FILE
    dispatch action.set_loaded('license', true)
    # load site_list
    load_default_site_list = true
    external_site_list = path.join config.EXTERNAL_CORE_DIR, config.CORE_SITE_LIST
    if await RNFS.exists(external_site_list)
      raw = await RNFS.readFile external_site_list
      list = _parse_list raw
      if list?
        dispatch action.set_site_list list
        load_default_site_list = false
      # ignore error
    if load_default_site_list
      raw = await RNFS.readFileAssets path.join(config.CORE_DIR, config.CORE_SITE_LIST)
      list = _parse_list raw
      if list?
        dispatch action.set_site_list list
      # ignore error

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
    # check external core
    external_core = path.join config.EXTERNAL_CORE_DIR, config.CORE_PM_BRIDGE
    if await RNFS.exists(external_core)
      core = config.FILE_URL + external_core
      dispatch action.set_pm_bridge_url(core)
      # DEBUG
      dispatch action.log("Use core: #{core}")
    else  # use default core
      dispatch action.set_pm_bridge_url(null)
    # start core
    dispatch action.set_is_doing(true)

check_upgrade = ->
  (dispatch, getState) ->
    # DEBUG
    dispatch action.log("DEBUG: 开始检查更新 .. . ")
    dispatch action.set_pm_bridge_url(config.AUTO_UPGRADE)
    dispatch action.set_is_doing(true)


module.exports = {
  check_cache  # thunk
  load_assets  # thunk
  clear_cache  # thunk

  start_jjdl  # thunk
  check_upgrade  # thunk
}
