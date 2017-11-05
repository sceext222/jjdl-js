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
    # check external_list
    if await RNFS.exists(config.EXTERNAL_LIST)
      raw = await RNFS.readFile config.EXTERNAL_LIST
      list = _parse_list raw
      if list?
        dispatch action.set_site_list list
      # ignore error
    else  # load default list
      dispatch action.set_site_list config.SITE_LIST

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
    if await RNFS.exists(config.EXTERNAL_CORE)
      core = config.LOCAL_URL_PREFIX + config.EXTERNAL_CORE
      dispatch action.set_pm_bridge_url(core)
      # DEBUG
      dispatch action.log("Use core: #{core}")
    # start core
    dispatch action.set_is_doing(true)

module.exports = {
  check_cache  # thunk
  load_assets  # thunk
  clear_cache  # thunk

  start_jjdl  # thunk
}
