# myushuwu_c.coffee, jjdl-js/src/_site/myushuwu/
# re-pack chapters of myushuwu
#
# support chapter title:
#   '1 XXX'   '2 YYY'   '3 ZZZ'
#   '01'      '02'      '03'
#   '01 XXX'  '02 YYY'  '03 ZZZ'

{
  N_CHAR
  CBase
} = require './_c_base'


class MyushuwuC extends CBase

  get_site: ->
    'myushuwu-c'

  # for sub-class
  check_chapter_index: (chapter_index, n) ->
    if n is (chapter_index + 1)
      {
        ok: true
      }
    else
      {}

  # check next chapter mark
  check_chapter_line: (text, chapter_index) ->
    # skip start number, eg:  '01'  '02'  '03'
    for i in [0... text.length]
      if N_CHAR.indexOf(text[i]) is -1
        break
    # check full number
    if i is text.length
      n = Number.parseInt text
      _c = @check_chapter_index chapter_index, n
      if _c.ok
        return {
          title: text.trim()
          desc: ''

          _chapter_index: _c._chapter_index  # support reset chapter_index
        }
      return null
    else  # just trim(), not check special char
      o = {
        title: text[0... i].trim()
        desc: text[i ..].trim()
      }
    n = Number.parseInt text[0... i]
    _c = @check_chapter_index chapter_index, n
    if _c.ok
      o._chapter_index = _c._chapter_index
      o
    else
      null

module.exports = MyushuwuC  # class
