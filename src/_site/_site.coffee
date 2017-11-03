# _site.coffee, jjdl-js/src/_site/

config = require '../config'
al = require '../al'
util = require '../util'
cache = require '../cache'


class Site  # base site
  constructor: (@uri) ->
    @meta = null
    @chapter = {}

  # download index page
  dl_index: (uri) ->  # async
    # use cache by default
    page = await cache.load_page uri
    util.parse_html page, uri

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
  #   author: {
  #     name: ''
  #     url: ''
  #   }
  #
  #   wenan: ''  # for jjwxc
  #   info: ''  # for jjwxc
  #   mark: ''  # for jjwxc
  #
  #   chapter: {
  #     INDEX: {
  #       title: ''
  #       desc: ''
  #       words: -1
  #       time: {
  #         update: ''
  #         release: ''
  #       }
  #       uri: ''
  #     }
  #   }
  #   _jjdl_version: ''  # meta TO ADD
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
      o[i] = await cache.load_page uri
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
    $ = await @dl_index @uri
    @meta = @parse_index $
    # add meta
    @meta.url = @uri
    @meta.opt = opt
    @meta._jjdl_version = config.P_VERSION
    @meta._last_update = util.last_update()
    # DEBUG meta info (from index page)
    al.logi "chapter #{Object.keys(@meta.chapter).length}: #{@meta.title}  @#{@meta.author.name}  (#{@meta.page_title})"

    raw = await @dl_chapters()
    al.logd "parse chapters .. . "
    for i of raw
      $ = util.parse_html raw[i], @meta.chapter[i].uri  # parse page (html) here
      @chapter[i] = @parse_one_chapter $

    {
      @meta
      @chapter
    }

  # entry: for re-pack chapters
  pre_pack: (data) ->
    data

  # entry: pack all chapters' text to one file
  pack: (data) ->
    util.pack data

module.exports = Site  # class
