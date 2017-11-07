# util.coffee, jjdl_android/src/

RNFS = require 'react-native-fs'

rm_tree = (filename) ->
  if ! await RNFS.exists(filename)
    return  # ignore if not exist
  await RNFS.unlink(filename)

module.exports = {
  rm_tree  # async
}
