# util.coffee, jjdl_android/src/

RNFS = require 'react-native-fs'


rm_tree = (filename) ->
  if ! await RNFS.exists(filename)
    return  # ignore if not exist
  await RNFS.unlink(filename)


# support comment in site_list
parse_site_name = (raw) ->
  if '#' in raw
    o = raw.split('#', 1)[0].trim()
  else
    o = raw.trim()
  o


module.exports = {
  rm_tree  # async

  parse_site_name
}
