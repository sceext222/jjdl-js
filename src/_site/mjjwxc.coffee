# mjjwxc.coffee, jjdl-js/src/_site/
# site: http://m.jjwxc.net/

util = require '../util'

Site = require './_site'

class Mjjwxc extends Site
  # eg: http://m.jjwxc.net/book2/3010233?more=1&whole=1
  _INDEX_URL_SUFFIX = '?more=1&whole=1'

  dl_index: (uri) ->  # async
    # check index url and fix it
    if uri.indexOf('?') != -1
      uri = uri.split('?')[0]
    uri += _INDEX_URL_SUFFIX
    await super uri

  parse_index: ($) ->
    o = {
      url: null
      opt: null

      site: 'mjjwxc'
      page_title: $('title').text().trim()
    }

    # title and author
    o.title = $('div.b.module > h2.big.o').text().split('>')[1].trim()
    author_a = $ '#info #left > li:first-child a'
    o.author = {
      name: author_a.text()
      url: author_a.prop 'href'
    }

    o.wenan = util.clean_text util.$_to_text($, util.$_get_all_text($, $('#novelintro')))
    o.mark = util.clean_text util.$_to_text($, util.$_get_all_text($, $('#novelintro').next())), '  '
    o.info = util.clean_text util.$_to_text($, util.$_get_all_text($, $('#info #left'))), '  '

    # chapter list
    o.chapter = {}

    raw_list = $ 'div.b.module > div:nth-child(3) > a'
    for i in [0... raw_list.length]
      # TODO ignore bad chapter

      text = $(raw_list[i]).text()
      one = {
        title: text[(text.indexOf('.') + 1)..].trim()
        desc: ''  # not support
        uri: $(raw_list[i]).prop 'href'
      }
      index = Number.parseInt text.split('.')[0]
      o.chapter[index] = one
    o

  parse_one_chapter: ($) ->
    noveltext = $ 'div.b.module > div:nth-child(2)'
    raw = util.$_get_all_text $, noveltext
    # TODO get more info

    text = util.clean_text util.$_to_text($, raw)
    {
      text
    }

module.exports = Mjjwxc  # class
