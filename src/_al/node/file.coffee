# file.coffee, jjdl-js/src/_al/node/
path = require 'path'
fs = require 'fs'
util = require 'util'


_WRITE_REPLACE_SUFFIX = '.tmp'

_fs_mkdir = util.promisify fs.mkdir
_fs_write_file = util.promisify fs.writeFile
_fs_rename = util.promisify fs.rename

_check_parent_dir = (filename) ->  # async
  parent = path.dirname filename
  if ! await file_exist(parent)
    await _check_parent_dir parent  # check parent first
    # try to create it
    await _fs_mkdir parent

read_file = util.promisify fs.readFile

file_exist = (filename) ->
  new Promise (resolve) ->
    fs.access filename, fs.constants.R_OK, (err) ->
      if err
        resolve false
      else
        resolve true

save_file = (filename, data) ->
  await _check_parent_dir filename
  tmp = filename + _WRITE_REPLACE_SUFFIX
  await _fs_write_file tmp, data  # write
  await _fs_rename tmp, filename  # replace


module.exports = {
  file_exist  # async
  read_file  # async
  save_file  # async
}
