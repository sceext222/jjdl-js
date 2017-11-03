# jjdl.coffee, jjdl-js/src/
# main bin entry of jjdl-js
#
#   $ node jjdl.js SITE URL
# eg:
#   $ node jjdl.js jjwxc "http://www.jjwxc.net/XXX.html"
#
path = require 'path'

config = require './config'
util = require './util'
al = require './al'
site = require './site'


_save_meta = (data) ->
  meta_file = path.join config.OUTPUT_DIR, util.meta_filename(data.meta)
  await al.save_file meta_file, util.print_json(data.meta)

main = (site_name, uri) ->  # async
  core = site.create site_name, uri

  data = await core.main()
  # first meta file
  await _save_meta data
  # pre-pack and second meta file
  data = core.pre_pack data
  await _save_meta data

  text = core.pack(data)
  # save result text file
  await al.save_file path.join(config.OUTPUT_DIR, util.pack_filename(data.meta)), text


_help = ->
  '''
  Usage for jjdl-js:
      node jjdl.js SITE URL

      --help
      --version

  LICENSE: GNU GPLv3+  <https://github.com/sceext222/jjdl-js>
  '''

_version = ->
  config.P_VERSION

p_args = (args) ->  # async
  if args.length < 1
    console.log "ERROR: bad command line, please try `--help`"
    process.exit 1

  switch args[0]
    when '--help'
      console.log _help()
      return
    when '--version'
      console.log _version()
      return

  await main args[0], args[1]

_start = ->
  try
    await p_args process.argv[2..]
  catch e
    console.log "unknow ERROR: #{e}  #{e.stack}"
    process.exit 1
_start()
