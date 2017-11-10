# myushuwu_c.coffee, jjdl-js/src/_site/
# re-pack chapters of myushuwu
#
# support chapter title:
#   '1 XXX'   '2 YYY'   '3 ZZZ'
#   '01'      '02'      '03'
#   '01 XXX'  '02 YYY'  '03 ZZZ'

util = require '../util'
al = require '../al'

Myushuwu = require './myushuwu'

_NUM_CHAR = '0123456789'
_MARK_CHAR = ' '  # special

class MyushuwuC extends Myushuwu

  # for sub-class
  get_site: ->
    'myushuwu-c'

  # check next chapter mark
  check_chapter_line: (text, chapter_index) ->
    # skip start number, eg:  '01'  '02'  '03'
    for i in [0... text.length]
      if _NUM_CHAR.indexOf(text[i]) is -1
        break
    # check full number
    if i is text.length
      n = Number.parseInt text
      if n is (chapter_index + 1)
        return {
          title: text.trim()
          desc: ''
        }
      return null
    # check special char
    if text[i] is _MARK_CHAR
      o = {
        title: text[0... i].trim()
        desc: text[i + 1 ..].trim()
      }
    else
      o = {
        title: text[0... i].trim()
        desc: text[i ..].trim()
      }
    n = Number.parseInt text[0... i]
    if n is (chapter_index + 1)
      o
    else
      null

  pre_pack: (data) ->
    # DEBUG
    al.logd "repack chapters .. . "

    # reset site
    data.meta.site = @get_site()
    data.meta._old_chapter = util.json_clone data.meta.chapter

    # concat all chapters raw text
    chapter_text = []
    for i of data.chapter
      chapter_text.push data.chapter[i].text
    raw_text = chapter_text.join('\n').split('\n')

    # reset each chapter
    data.meta.chapter = {}
    data.chapter = {}

    chapter_index = 0
    one_chapter_text = []  # one chapter lines
    one_chapter = {
      title: ''
      desc: ''
    }
    for i in raw_text
      # check next chapter mark
      check = @check_chapter_line i, chapter_index
      if check?
        # save last chapter
        data.meta.chapter[chapter_index] = one_chapter
        data.chapter[chapter_index] = {
          text: one_chapter_text.join '\n'
        }
        # reset chapter
        one_chapter_text = []
        one_chapter = check
        chapter_index += 1
      else
        one_chapter_text.push i
    # check add last chapter
    if one_chapter_text.length > 0
      data.meta.chapter[chapter_index] = one_chapter
      data.chapter[chapter_index] = {
        text: one_chapter_text.join '\n'
      }
    # reset _last_update
    data.meta._last_update = util.last_update()
    data

module.exports = MyushuwuC  # class
