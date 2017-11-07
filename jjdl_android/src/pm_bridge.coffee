# pm_bridge.coffee, jjdl_android/src/
#
# postMessage {
#   _id: 1
#   type: ''
#   payload: ANY
# }
#

path = require 'path-browserify'
RNFS = require 'react-native-fs'
{
  ToastAndroid
} = require 'react-native'

config = require './config'
action = require './action/root'
op = require './action/op'
util = require './util'


_log = (text) ->
  config.store.dispatch action.log(text)

_send = (that, msg) ->
  that.postMessage JSON.stringify(msg)


_WRITE_REPLACE_SUFFIX = '.tmp'

_check_cache = (that, _id, filename) ->
  filename = path.join config.SDCARD_JJDL_ROOT, filename
  try
    if ! await RNFS.exists(filename)
      _send that, {
        _id
        type: 'callback'
        payload: null
      }
      return
    # read file as base64 (blob)
    data = await RNFS.readFile filename, 'base64'
    _send that, {
      _id
      type: 'callback'
      payload: data
    }
  catch e
    _send that, {
      _id
      type: 'callback'
      error: true
      payload: "ERROR: #{e}  #{e.stack}"
    }

_save_file = (that, _id, filename, data) ->
  filename = path.join config.SDCARD_JJDL_ROOT, filename
  try
    # check parent dir
    parent = path.dirname filename
    await RNFS.mkdir parent
    # write-replace
    tmp = filename + _WRITE_REPLACE_SUFFIX
    await RNFS.writeFile tmp, data, 'base64'
    await RNFS.moveFile tmp, filename
    # OK callback
    _send that, {
      _id
      type: 'callback'
    }
  catch e
    # ERROR callback
    _send that, {
      _id
      type: 'callback'
      error: true
      payload: "ERROR: #{e}  #{e.stack}"
    }

_dl_page = (that, _id, args) ->
  try
    result = await util.dl_page args.uri  # TODO args
    _send that, {
      _id
      type: 'callback'
      payload: result  # just base64
    }
  catch e
    _send that, {
      _id
      type: 'callback'
      error: true
      payload: "ERROR: #{e}  #{e.stack}"
    }


_on_message = (raw, that) ->
  data = JSON.parse raw
  switch data.type
    when 'log'
      _log data.payload
    when 'dl_page'  # with callback
      _dl_page that, data._id, data.payload
    when 'check_cache'  # with callback
      _check_cache that, data._id, data.payload
    when 'save_file'  # with callback
      _save_file that, data._id, data.payload.filename, data.payload.data
    when 'start'  # with send back
      $$state = config.store.getState()
      # send start args
      _send that, {
        type: 'args'
        payload: {
          site: $$state.get 'site'
          url: $$state.get 'url'
        }
      }
    when 'init'
      _log "DEBUG: WebView UA: #{data.payload.ua}"
      # inject jjdl_core.js
      # FIXME
      #that.injectJavaScript config.jjdl_core_js
    when 'end'
      _log "[已结束]"
      config.store.dispatch action.set_is_doing(false)
      config.store.dispatch op.check_cache()
      # show toast
      ToastAndroid.show 'jjdl: 已结束', ToastAndroid.SHORT
    else  # unknow message
      _log "WARNING: unknow message type [#{data.type}]  #{raw}"

on_message = (raw, that) ->
  try
    await _on_message raw, that
  catch e
    _log "unknow ERROR: #{e}  #{e.stack}\nBAD message: #{raw}"

module.exports = {
  on_message
}
