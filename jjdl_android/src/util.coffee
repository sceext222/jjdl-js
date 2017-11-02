# util.coffee, jjdl_android/src/

Buffer = require 'buffer'
RNFS = require 'react-native-fs'
{ default: RNFetchBlob } = require 'react-native-fetch-blob'

# FIXME
config = require './config'
action = require './action/root'

_log = (text) ->
  config.store.dispatch action.log(text)


rm_tree = (filename) ->
  if ! await RNFS.exists(filename)
    return  # ignore if not exist
  await RNFS.unlink(filename)

# return base64 string
dl_page = (uri, encoding = null, gzip = true) ->
  res = await RNFetchBlob.fetch 'GET', uri
  res.base64()

module.exports = {
  rm_tree  # async
  dl_page  # async
}
