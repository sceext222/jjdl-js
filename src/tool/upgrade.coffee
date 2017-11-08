# upgrade.coffee, jjdl-js/src/tool/
# with browserify
path = require 'path'

al = require '../al'
pm_bridge = require '../_al/android/pm_bridge'


# config
UPDATE_URL_BASE = 'https://raw.githubusercontent.com/sceext222/jjdl-js/release-core/core/0.2.0/'

CORE_META = 'core_meta.json'
CORE_DIR = 'core'  # /sdcard/jjdl/core/


_upgrade_each_file = (lm, rm) ->  # async
  for filename of rm.file
    # check skip this file
    if lm.file[filename]? and (lm.file[filename].sha256 is rm.file[filename].sha256)
      al.logd "SKIP #{filename}"
      continue
    # download new file
    url = UPDATE_URL_BASE + filename
    al.logd "GET #{url}"
    raw = await al.dl_page url
    # upgrade this file
    al.logd "UPGRADE #{filename}"
    await al.save_file path.join(CORE_DIR, filename), raw
    # update local core_meta.json
    lm.file[filename] = rm.file[filename]
    text = JSON.stringify(lm, '', '    ') + '\n'
    await al.save_file path.join(CORE_DIR, CORE_META), text

# local core_meta.json placeholder
_FAKE_LOCAL_META = {
  file: {}
}

main = ->  # async
  remote_meta = UPDATE_URL_BASE + CORE_META
  # DEBUG
  al.logd "GET #{remote_meta}"

  raw = await al.dl_page remote_meta
  meta = JSON.parse raw.toString('utf-8')
  # check upgrade type
  if meta.type is 'EOL'
    al.logi "EOL: #{meta.comment}"  # print EOL comment text
    return
  if meta.type != 'auto'
    throw new Error "unknow upgrade type: #{meta.type}"

  # load local meta
  local_meta = path.join CORE_DIR, CORE_META
  if ! await al.file_exist(local_meta)
    al.logi "local #{CORE_META} not exist !"
    # load default fake meta
    lm = _FAKE_LOCAL_META  # lm: local meta
  else
    local_raw = await al.read_file local_meta
    try
      lm = JSON.parse local_raw.toString('utf-8')
    catch e
      al.loge "BAD local #{CORE_META}"
      lm = _FAKE_LOCAL_META
  # upgrade all files
  await _upgrade_each_file lm, meta
  # update local meta
  await al.save_file local_meta, raw
  # TODO more log

_start = ->
  try
    await main()
  catch e
    al.loge "unknow ERROR: #{e}  #{e.stack}"
  # always end
  pm_bridge.send {
    type: 'end'
  }
_start()
