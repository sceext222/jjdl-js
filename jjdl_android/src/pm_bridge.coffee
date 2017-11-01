# pm_bridge.coffee, jjdl_android/src/
#
# postMessage {
#   _id: 1
#   type: ''
#   payload: ANY
# }
#

config = require './config'
action = require './action/root'
op = require './action/op'


_log = (text) ->
  config.store.dispatch action.log(text)


_on_message = (raw, that) ->
  data = JSON.parse raw
  switch data.type
    when 'log'
      _log data.payload
    when 'dl_page'
      # TODO
      null
    when 'check_cache'
      # TODO
      null
    when 'start'
      $$state = config.store.getState()
      # send start args
      to = {
        type: 'args'
        payload: {
          site: $$state.get 'site'
          url: $$state.get 'url'
        }
      }
      that.postMessage JSON.stringify(to)
    when 'init'
      _log "DEBUG: WebView UA: #{data.payload.ua}"
      # inject jjdl_core.js
      that.injectJavaScript config.jjdl_core_js
    when 'end'
      _log "[已结束]"
      config.store.dispatch action.set_is_doing(false)
      config.store.dispatch op.check_cache()
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
