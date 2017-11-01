# net.coffee, jjdl-js/src/_al/android/

request = require 'browser-request'


dl_page = (uri, encoding = null, gzip = true) ->
  new Promise (resolve, reject) ->
    request {
      uri
      encoding
      gzip
    }, (err, res, body) ->
      if err
        reject err
      else
        resolve body


module.exports = {
  dl_page  # async
}
