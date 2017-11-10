# myushuwu.coffee, jjdl-js/src/_site/
# site: https://m.yushuwu.com/

util = require '../util'
al = require '../al'
cache = require '../cache'

Site = require './_site'

_SITE_LIST_REVERSE_MARK = 'ul,li{transform: rotate(180deg);}'

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
    # check chapter numbers
    chapter_num = util.get_first_number $('.lb_mulu.chapterList h3 span').text()
    guess_num = end - start + 1
    if chapter_num is guess_num
      # check pass, use old guess method
      index = 0
      for i in [start .. end]
        one = {
          title: ''  # not support
          desc: ''
          uri: "#{before}#{i}#{after}"
        }
        index += 1
        o.chapter[index] = one
    # use raw list if possible
    else if chapter_num is raw_list.length
      for i in [0... raw_list.length]
        one = {
          title: ''
          desc: ''
          uri: $(raw_list[i]).prop('href')
        }
        o.chapter[i + 1] = one
    else  # check index list a
      for i in raw_list
        if $(i).text().indexOf('...') != -1
          o._index_list_page = $(i).prop('href')
          break
      if o._index_list_page?
        o._chapter_num = chapter_num
      else  # FIXME
        throw new Error "bad chapter number, #{guess_num} != #{chapter_num}"
    o

  # eg: 'javascript:goChapter(52632,6844354);' -> 'https://m.yushuwu.com/novel/52632/6844354.html'
  _parse_go_chapter: (raw, good) ->
    p = good.split '/'
    args = raw.split('(')[1].split(')')[0].split(',')
    p[p.length - 2] = args[0].trim()
    p[p.length - 1] = args[1].trim() + '.' + p[p.length - 1].split('.')[1]

    o = p.join '/'
    # DEBUG
    al.logw "href: #{raw} -> #{o}"
    o

  _parse_one_index_list: ($, raw_list) ->
    style = $('style').text()

    a_list = $('body>ul>li>a')
    # check reverse list
    if style.indexOf(_SITE_LIST_REVERSE_MARK) != -1
      a_list = Array.from(a_list).reverse()
    # add each chapter page
    for i in [1 ... a_list.length - 1]
      a = a_list[i]
      href = $(a).prop('href')
      # check href
      if ! href.startsWith 'http'
        href = @_parse_go_chapter href, raw_list[0]
      raw_list.push href
      # FIXME DEBUG
      #al.logd "FIXME: #{$(a).text()}"

    # check next page
    next = $('#next').prop('href')
    if next.startsWith 'http'
      next
    else
      null

  get_all_index: ->  # async
    if ! @meta._index_list_page?
      return
    # DEBUG
    al.logd "try to get #{@meta._chapter_num} index .. . "

    raw_list = []  # URL in this list
    # download all index list pages and get all chapter items
    index_list = @meta._index_list_page
    while index_list?
      $ = util.parse_html (await cache.load_page index_list), index_list
      index_list = @_parse_one_index_list $, raw_list

    # check chapter_num, again
    if raw_list.length != @meta._chapter_num
      throw new Error "bad chapter number: #{raw_list.length} != #{@meta._chapter_num}"
    # make meta info
    index = 0
    for i in raw_list
      one = {
        title: ''
        desc: ''
        uri: i
      }
      index += 1
      @meta.chapter[index] = one

  parse_one_chapter: ($) ->
    noveltext = $ '#nr1'
    text = util.clean_text util.$_to_text($, util.$_get_all_text($, noveltext))
    {
      text
    }

module.exports = Myushuwu  # class
