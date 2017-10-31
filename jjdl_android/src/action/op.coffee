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

load_license = ->
  (dispatch, getState) ->
    text = await RNFS.readFileAssets(config.LICENSE_FILE)
    dispatch action.set_license_text(text)

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


module.exports = {
  check_cache  # thunk
  load_license  # thunk
  clear_cache  # thunk
}
