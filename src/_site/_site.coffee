# _site.coffee, jjdl-js/src/_site/

util = require '../util'
cache = require '../cache'


class Site  # base site
  constructor: (@uri) ->
    @meta = null
    @chapter = {}

  # download index page
  dl_index: ->  # async
    # NOTE use cache by default
    page = await cache.load_page @uri
    util.parse_html page

  # parse index page to get meta data
  #
  # return {  # meta info
  #   url: ''  # meta TO ADD
  #   opt: null  # meta TO ADD
  #
  #   site: ''
  #   page_title: ''
  #
  #   title: ''
  #   wenan: ''  # FIXME jjwxc
  #   info: ''  # FIXME jjwxc
  #   mark: ''  # FIXME jjwxc
  #
  #   chapter: {
  #     INDEX: {
  #       title: ''
  #       uri: ''
  #     }
  #   }
  #   _last_update: ''  # meta TO ADD
  # }
  parse_index: ($) ->
    throw new Error "not implemented"  # MUST be implemented by sub class

  # download all chapters
  dl_chapters: ->  # async
    # TODO support multi-thread download
    # download with single thread
    o = {}
    for i of @meta.chapter
      # check url
      uri = @meta.chapter[i].uri
      if (! uri?) or (uri.trim() is '')
        al.logw "skip chapter #{i}: #{@meta.chapter[i].title}  (url = #{uri})"
        continue
      # download with cache
      page = await cache.load_page uri
      o[i] = util.parse_html page
    o

  # return {
  #   text: ''  # chapter text
  # }
  parse_one_chapter: ($) ->
    throw new Error "not implemented"

  # main entry: the whole download process
  #
  # return {
  #   meta: {}  # meta info
  #   chapter: {}  # each chapter info (chapter text)
  # }
  main: (opt) ->  # async
    # process index page
    $ = await @dl_index()
    @meta = @parse_index $
    # add meta
    @meta.url = @uri
    @meta.opt = opt
    @meta._last_update = util.last_update()
    # TODO DEBUG meta info (from index)

    raw = await @dl_chapters()
    for i of raw
      @chapter[i] = @parse_one_chapter raw[i]

    {
      @meta
      @chapter
    }

  # entry: pack all chapters' text to one file
  pack: (data) ->
    util.pack data

module.exports = Site  # class
