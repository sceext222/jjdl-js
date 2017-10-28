# cache.coffee, jjdl-js/src/
url = require 'url'
path = require 'path'

config = require './config'
al = require './al'

# escape urls (for filename, path)
_EU_CHAR = '#'
_EU_C = {
  '#': '#'
  ':': '='  # colon
  '/': '-'  # slash
  '?': '_'  # question mark
  '&': '+'  # And

  '*': 'a'  # Asterisk
  '\\': 'b'  # Backslash
  '"': 'd'  # Double quotation marks
  '>': 'g'  # Greater than
  '<': 'l'  # Less than
  '|': 'p'  # Pipe
  '\'': 'q'  # Quote mark
}


_escape_url = (raw) ->
  o = ''
  for c in raw
    if _EU_C[c]?
      o += _EU_CHAR + _EU_C[c]
    else
      o += c
  o


load_page = (uri) ->
  # check cache file
  i = url.parse uri
  cache_file = path.join config.CACHE_DIR, _escape_url(i.host), _escape_url(i.path)

  if await al.file_exist(cache_file)
    al.logd "cache HIT #{cache_file}"
    return await al.read_file(cache_file)
  else  # download page
    al.logd "GET #{uri}"
    data = await al.dl_page(uri)
    await al.save_file(cache_file, data)  # update cache
    return data


# TODO clean cache ?

module.exports = {
  load_page  # async
}
