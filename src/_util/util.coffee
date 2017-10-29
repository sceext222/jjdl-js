# util.coffee, jjdl-js/src/_util/

{ JSDOM } = require 'jsdom'
jquery = require 'jquery'


parse_html = (raw) ->
  dom = new JSDOM raw
  jquery dom.window

$_get_all_text = ($, raw) ->
  set = $(raw).add $('*', raw)
  set.contents().filter () ->
    @nodeType is 3

$_to_text = ($, raw) ->
  a = Array.from raw
  # sort text by document order
  a = $.uniqueSort a

  o = []
  for i in a
    o.push $(i).text()
  o


last_update = ->
  "#{new Date().toISOString()}Z"


module.exports = {
  parse_html
  $_get_all_text
  $_to_text

  last_update
}
