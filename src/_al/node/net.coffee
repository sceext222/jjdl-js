# net.coffee, jjdl-js/src/_al/node/

request = require 'request-promise-native'


dl_page = (uri, encoding = null, gzip = true) ->
  await request {
    uri
    encoding
    gzip
  }


module.exports = {
  dl_page  # async
}
