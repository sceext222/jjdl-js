# _c_base.coffee, jjdl-js/src/_site/myushuwu/
# re-pack chapters of myushuwu

util = require '../../util'
al = require '../../al'

Myushuwu = require './myushuwu'


N_CHAR = '0123456789'

class CBase extends Myushuwu

  # for sub-class
  get_site: ->
    throw new Error 'not implemented'

  # check next chapter mark
  check_chapter_line: (text, chapter_index) ->
    throw new Error 'not implemented'  # for sub-class

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
        # support reset chapter_index
        if check._chapter_index?
          chapter_index = check._chapter_index
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

module.exports = {
  N_CHAR

  CBase  # class
}
