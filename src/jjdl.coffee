# jjdl.coffee, jjdl-js/src/
# main entry of jjdl-js (jjdl_core for jjdl_android)
path = require 'path'

config = require './config'
util = require './util'
al = require './al'
site = require './site'

pm_bridge = require './_al/android/pm_bridge'


main = (site_name, uri) ->  # async
  # DEBUG
  al.logd config.P_VERSION
  al.logd "site = [#{site_name}], url = #{uri}"

  core = site.create site_name, uri

  data = await core.main()
  # save meta file
  meta_file = path.join config.OUTPUT_DIR, util.meta_filename(data.meta)
  await al.save_file meta_file, util.print_json(data.meta)

  text = core.pack(data)
  # save result text file
  await al.save_file path.join(config.OUTPUT_DIR, util.pack_filename(data.meta)), text

_main = (args) ->
  try
    await main(args.site, args.url)
  catch e
    al.loge "unknow ERROR: #{e}  #{e.stack}"
  # always send end msg
  pm_bridge.send {
    type: 'end'
  }

_init = ->
  pm_bridge.set_main _main
  # init message
  pm_bridge.send {
    type: 'start'
  }
_init()
