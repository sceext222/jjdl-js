# util.coffee, jjdl_android/src/

{ Buffer } = require 'buffer'

RNFS = require 'react-native-fs'
{ default: RNFetchBlob } = require 'react-native-fetch-blob'

rm_tree = (filename) ->
  if ! await RNFS.exists(filename)
    return  # ignore if not exist
  await RNFS.unlink(filename)

# return base64 string
dl_page = (uri, encoding = null, gzip = true) ->
  res = await RNFetchBlob.fetch 'GET', uri
  # check res type
  if res.type is 'base64'
    return res.data
  # encode data to base64
  b = Buffer.from res.data
  b.toString 'base64'

module.exports = {
  rm_tree  # async
  dl_page  # async
}
