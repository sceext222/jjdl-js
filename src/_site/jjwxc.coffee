# jjwxc.coffee, jjdl-js/src/_site/
# site: http://www.jjwxc.net

Site = require './_site'
util = require '../util'


_clean_text = (raw, join = '\n') ->
  a = util.clean_html_text Array.from(raw)
  o = []
  for i in a
    one = i.trim()
    if one != ''
      o.push one
  o.join join


class Jjwxc extends Site

  parse_index: ($) ->
    o = {
      url: null
      opt: null

      site: 'jjwxc'
      page_title: $('title').text().trim()
    }
    # main novel text info
    sptd = $ '.sptd'
    o.title = _clean_text $(sptd[0]).text(), ' '
    o.mark = _clean_text $(sptd[sptd.length - 1]).text(), ' '

    readtd = $ '.readtd'
    o.wenan = _clean_text util.$_to_text(util.$_get_all_text(readtd[0]))
    o.info = _clean_text util.$_to_text(util.$_get_all_text(readtd[1])), ' '

    # chapter list
    o.chapter = {}

    raw_list = $ '#oneboolt tr[itemprop~=chapter]'
    for i in [0... raw_list.length]
      # TODO ignore bad chapter
      a = $ 'a', raw_list[i]
      if a.length < 1
        continue  # ignore this item

      one = {
        title: _clean_text a.text(), ' '
        uri: a.attr 'href'
      }
      # TODO get more chapter info
      index = $($('td', raw_list[i])[0]).text()
      o.chapter[index] = one
    o

  parse_one_chapter: ($) ->
    noveltext = $ 'div.noveltext'
    raw = util.$_get_all_text noveltext
    # remove no use text
    raw = raw.not util.$_get_all_text($('> div', noveltext)[0..1])
    raw = raw.not util.$_get_all_text($('#favorite_3', noveltext))
    # TODO more clean

    text = _clean_text util.$_to_text(raw)

    {
      text
    }

module.exports = Jjwxc  # class
