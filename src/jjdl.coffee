# jjdl.coffee, jjdl-js/src/
# main bin entry of jjdl-js
#
# TODO command-line args
#

al = require './al'
util = require './util'
site = require './site'


main = (args) ->  # async
  s = args[0]  # site
  uri = args[1]

  core = site.create s, uri

  data = await core.main()
  # save meta file
  filename = data.meta.title.split('\n').join(' ').split(' ').join('-')
  await al.save_file "#{config.META_FILE[0]}#{filename}#{config.META_FILE[1]}", JSON.stringify(data.meta, '', '    ') + '\n'

  text = core.pack(data)
  # save result text file
  await al.save_file util.pack_filename(data.meta), text


# start from main
_start = ->
  try
    await main process.argv[2..]
  catch e
    console.log "unknow ERROR: #{e}  #{e.stack}"

_start()
