# myushuwu_c2.coffee, jjdl-js/src/_site/
# re-pack chapters of myushuwu

util = require '../util'

MyushuwuC = require './myushuwu_c'

_MARK_CHAR = ['第', '章']
_N_CHAR = '一二三四五六七八九十百千'

_N_MAX = 8

class MyushuwuC2 extends MyushuwuC

  get_site: ->
    'myushuwu-c2'

  check_chapter_line: (text, chapter_index) ->
    line = text.trim()
    if line[0] != _MARK_CHAR[0]
      return null
    # deep check
    for i in [1.. _N_MAX]
      if _N_CHAR.indexOf(line[i]) is -1
        break
    if line[i] != _MARK_CHAR[1]
      return null

    {
      title: line[..i].trim()
      desc: line[i + 1 ..].trim()
    }

module.exports = MyushuwuC2  # class
