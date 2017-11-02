# al.coffee, jjdl-js/src/

config = require './config'

{
  dl_page
} = require './_al/android/net'
{
  log_line
} = require './_al/android/log'
{
  file_exist
  read_file
  save_file
} = require './_al/android/file'


# raw log
logr = (text) ->
  log_line text

log = (text, prefix = config.LOG_PREFIX) ->
  logr "#{prefix}: #{text}"

logd = (text) ->
  log text, "#{config.LOG_PREFIX}.#{config.LOG_P.d}"

logw = (text) ->
  log text, "#{config.LOG_PREFIX}.#{config.LOG_P.w}"

loge = (text) ->
  log text, "#{config.LOG_PREFIX}.#{config.LOG_P.e}"

logi = (text) ->
  log text, "#{config.LOG_PREFIX}.#{config.LOG_P.i}"


module.exports = {
  logr
  log
  logd
  logw
  loge
  logi

  dl_page  # async

  file_exist  # async
  read_file  # async
  save_file  # async
}
