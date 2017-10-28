# util.coffee, jjdl-js/src/_util/

{ JSDOM } = require 'jsdom'
$ = require 'jquery'


parse_html = (raw) ->
  dom = new JSDOM raw
  $ dom.window

$_get_all_text = (raw) ->
  $('*', raw).contents().filter () ->
    @nodeType is 3

$_to_text = (raw) ->
  raw.map (x) ->
    $(x).text()


last_update = ->
  "#{new Date().toISOString()}Z"


module.exports = {
  parse_html
  $_get_all_text
  $_to_text

  last_update
}
