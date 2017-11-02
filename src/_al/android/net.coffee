# net.coffee, jjdl-js/src/_al/android/

pm_bridge = require './pm_bridge'


dl_page = (uri, encoding = null, gzip = true) ->
  result = await pm_bridge.with_callback {
    type: 'dl_page'
    payload: {
      uri
      encoding
      gzip
    }
  }
  Buffer.from result, 'base64'


module.exports = {
  dl_page  # async
}
