# myushuwu.coffee, jjdl-js/src/_site/
# site: https://m.yushuwu.com/

Site = require './_site'
util = require '../util'


class Myushuwu extends Site

  parse_index: ($) ->
    o = {
      url: null
      opt: null

      site: 'myushuwu'
      page_title: $('title').text().trim()
    }
    # title and author
    h = $ 'ul.h_nav_items > li'
    o.title = $(h[h.length - 1]).text().trim()
    o.author = {
      name: $('td.article_info_td h2').text().trim()
    }

    wenan = $ 'pre', $('div.lb_jj').next()
    o.wenan = util.clean_text util.$_to_text($, util.$_get_all_text($, wenan))
    o.info = util.clean_text util.$_to_text($, util.$_get_all_text($, $('.article_info_td'))), '  '

    # chapter list
    o.chapter = {}

    raw_list = $ '.lb_mulu.chapterList li a'
    # guess all chapters
    first = $(raw_list[0]).prop('href')
    last = $(raw_list[raw_list.length - 1]).prop('href')
    before = first[.. first.lastIndexOf('/')]
    after = first[first.lastIndexOf('.') ..]
    start = Number.parseInt first[first.lastIndexOf('/') + 1 ... first.lastIndexOf('.')]
    end = Number.parseInt last[last.lastIndexOf('/') + 1 ... last.lastIndexOf('.')]

    index = 0
    for i in [start .. end]
      one = {
        title: ''  # not support
        desc: ''
        uri: "#{before}#{i}#{after}"
      }
      index += 1
      o.chapter[index] = one
    o

  parse_one_chapter: ($) ->
    noveltext = $ '#nr1'
    text = util.clean_text util.$_to_text($, util.$_get_all_text($, noveltext))
    {
      text
    }

module.exports = Myushuwu  # class
