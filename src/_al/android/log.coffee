# log.coffee, jjdl-js/src/_al/android/

pm_bridge = require './pm_bridge'

# raw log function
log_line = (text) ->
  pm_bridge.send {
    type: 'log'
    payload: text
  }


module.exports = {
  log_line
}
