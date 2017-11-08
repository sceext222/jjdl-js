# gen_core_meta.coffee, jjdl-js/src/tool/
#
#   $ node gen_core_meta.js DIR
# eg:
#   $ node gen_core_meta.js core/
#
path = require 'path'
fs = require 'fs'
{ promisify } = require 'util'
crypto = require 'crypto'

fs_readdir = promisify fs.readdir
fs_readFile = promisify fs.readFile
fs_rename = promisify fs.rename
fs_stat = promisify fs.stat
fs_writeFile = promisify fs.writeFile


# config
CORE_META = 'core_meta.json'
JJDL_CORE = 'jjdl_core.js'
JJDL_CORE_VERSION_MARK = 'jjdl-js version'

_WRITE_REPLACE_SUFFIX = '.tmp'


_last_update = ->
  new Date().toISOString()

_save_json = (filename, data) ->  # async
  text = JSON.stringify(data, '', '    ') + '\n'
  tmp = filename + _WRITE_REPLACE_SUFFIX
  await fs_writeFile tmp, text, 'utf-8'  # write
  await fs_rename tmp, filename  # replace

_get_version = (filename) ->  # async
  text = await fs_readFile filename, 'utf-8'
  i = text.indexOf JJDL_CORE_VERSION_MARK
  _not_quote = (c) ->
    (c != '\'') and (c != '"')

  start = i
  while _not_quote text[start]
    start -= 1
  end = i
  while _not_quote text[end]
    end += 1
  text[start + 1 ... end]  # TODO

# sha256()
_hash_file = (filename) ->  # async
  new Promise (resolve, reject) ->
    h = crypto.createHash 'sha256'

    s = fs.createReadStream filename
    s.on 'data', (chunk) ->
      h.update chunk
    s.on 'end', () ->
      resolve h.digest('hex')
    s.on 'error', (e) ->
      reject e

_gen_one_file_info = (filename) ->  # async
  s = await fs_stat filename
  {
    size: s.size
    sha256: await _hash_file filename
  }

# TODO not support sub-dir now
_gen_core_meta = (core_dir) ->  # async
  o = {
    type: 'auto'  # 'auto', 'EOL'
    core_version: ''
    file: {
      #FILE_NAME: {
      #  size: -1
      #  sha256: ''  # hex
      #}
    }
  }

  list = await fs_readdir core_dir
  for i in list
    if i is CORE_META
      continue  # skip core_meta.json itself
    o.file[i] = await _gen_one_file_info path.join(core_dir, i)
  o.core_version = await _get_version path.join(core_dir, JJDL_CORE)
  o._last_update = _last_update()
  o

main = (core_dir) ->  # async
  meta = await _gen_core_meta core_dir
  await _save_json path.join(core_dir, CORE_META), meta


p_args = (args) ->  # async
  # TODO error process

  await main args[0]

_start = ->
  try
    await p_args process.argv[2..]
  catch e
    console.log "unknow ERROR: #{e}  #{e.stack}"
    process.exit 1
_start()
