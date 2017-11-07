# file.coffee, jjdl-js/src/_al/android/
path = require 'path'

pm_bridge = require './pm_bridge'


# file cache to cache check exist and read file
_file_cache = {}


file_exist = (filename) ->
  raw = await pm_bridge.with_callback {
    type: 'check_cache'
    payload: filename
  }
  # update cache
  _file_cache[filename] = raw
  # check no file
  if raw is null
    return false
  true

# TODO maybe only for 'check_cache' ?
read_file = (filename) ->
  # check cache first
  if _file_cache[filename]?
    return Buffer.from _file_cache[filename], 'base64'
  # check no such file
  if _file_cache[filename] is null  # null, not undefined
    throw new Error "no such file #{filename}"
  # read file with pm_bridge
  raw = await pm_bridge.with_callback {
    type: 'check_cache'
    payload: filename
  }
  # check no file
  if raw is null
    throw new Error "no such file #{filename}"
  # return Buffer
  Buffer.from raw, 'base64'

save_file = (filename, data) ->
  b = Buffer.from data  # always write blob data
  await pm_bridge.with_callback {
    type: 'save_file'
    payload: {
      filename
      data: b.toString 'base64'
    }
  }

module.exports = {
  file_exist  # async
  read_file  # async
  save_file
}
