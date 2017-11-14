# myushuwu_c4.coffee, jjdl-js/src/_site/myushuwu/
# improve for myushuwu_c, support skip chapter index

MyushuwuC = require './myushuwu_c'

class MyushuwuC4 extends MyushuwuC

  get_site: ->
    'myushuwu-c4'

  check_chapter_index: (chapter_index, n) ->
    if n >= (chapter_index + 1)
      {
        ok: true
        _chapter_index: n  # support reset chapter_index
      }
    else
      {}

module.exports = MyushuwuC4  # class
