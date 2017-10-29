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

_clean_index_text = (raw, join = ' ') ->
  _clean_text [raw], join


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
    # title and autor
    o.title = _clean_index_text $('h1', sptd[0]).text()
    author_a = $ 'h2 a', sptd[0]
    o.author = {
      name: author_a.text()
      url: author_a.attr 'href'
    }

    o.mark = _clean_text util.$_to_text($, util.$_get_all_text($, sptd[sptd.length - 1])), '  '

    readtd = $ '.readtd'
    o.wenan = _clean_text util.$_to_text($, util.$_get_all_text($, readtd[0]))
    o.info = _clean_text util.$_to_text($, util.$_get_all_text($, readtd[1])), ' '

    # chapter list
    o.chapter = {}

    raw_list = $ '#oneboolt tr[itemprop~=chapter]'
    for i in [0... raw_list.length]
      # TODO ignore bad chapter
      a = $ 'a', raw_list[i]
      if a.length < 1
        continue  # ignore this item

      td = $ 'td', raw_list[i]
      td_time = td[td.length - 1]
      # get more chapter info
      one = {
        title: _clean_index_text a.text()
        desc: _clean_index_text $(td[2]).text()
        words: Number.parseInt($('[itemprop=wordCount]', raw_list[i]).text())
        time: {
          update: _clean_index_text $(td_time).text()
          release: _clean_index_text $(td_time).attr('title')
        }
        uri: a.attr 'href'
      }
      index = $($('td', raw_list[i])[0]).text().trim()
      o.chapter[index] = one
    o

  parse_one_chapter: ($) ->
    noveltext = $ 'div.noveltext'
    raw = util.$_get_all_text $, noveltext
    # remove no use text
    raw = raw.not util.$_get_all_text($, $('> div', noveltext)[0..1])
    raw = raw.not util.$_get_all_text($, $('#favorite_3', noveltext))
    # TODO more clean
    # TODO add one line after '作者有话说'

    text = _clean_text util.$_to_text($, raw)

    {
      text
    }

module.exports = Jjwxc  # class
