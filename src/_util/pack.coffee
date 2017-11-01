# pack.coffee, jjdl-js/src/_util/

config = require '../config'
al = require '../al'

{
  last_update
} = require './util'
{
  indent_line
} = require './text'

# TODO improve words count


# first part of final pack text
_pack_meta = (data, words_count) ->
  o = '\n\n'
  o += "jjdl-js:: URL #{data.meta.url}\n"
  o += "jjdl-js:: #{config.P_VERSION}\n\n"

  # title and page_title
  title = "#{data.meta.title}  @#{data.meta.author.name}"
  if data.meta.author.url?
    title += " <#{data.meta.author.url}>"
  o += "#{title}\n"
  o += "(#{data.meta.page_title})\n\n"

  # wenan, info, mark  # for jjwxc
  if data.meta.wenan?
    o += "#{indent_line data.meta.wenan}\n\n"
  if data.meta.info?
    o += "#{data.meta.info}\n\n"
  if data.meta.mark?
    o += "#{data.meta.mark}\n\n"

  # words count
  o += "jjdl-js:: chapter count #{Object.keys(data.chapter).length}, words count #{words_count} \n"
  o += "jjdl-js:: last_update #{last_update()}\n\n"
  o

# last part of final pack text
_pack_last = (data, words_count) ->
  o = '\n'
  o += "jjdl-js:: URL #{data.meta.url}\n"
  o += "jjdl-js:: title #{data.meta.title}  @#{data.meta.author.name}\n"
  o += "    chapter count #{Object.keys(data.chapter).length}, words count #{words_count} \n"
  o += "jjdl-js: last_update #{last_update()}\n\n"
  o

_pack_one_chapter = (data, index) ->
  o = '\n'
  # TODO improve zfill to chapter count
  c = "#{index}"
  if c.length < 2
    c = '0' + c
  chapter_name = "第 #{c} 章  #{data.meta.chapter[index].title}  #{data.meta.chapter[index].desc}"
  o += "#{chapter_name}\n"

  # main text
  main_text = data.chapter[index].text
  o += "#{indent_line main_text}\n"  # raw chapter text
  # add words count
  words_count = main_text.length
  o += "jjdl-js:: words count #{words_count} \n\n"
  o


pack = (data) ->
  # words count first
  words_count = 0
  for i of data.chapter
    words_count += data.chapter[i].text.length

  o = _pack_meta data, words_count
  # pack each chapter
  for i of data.chapter
    o += _pack_one_chapter data, i
  o += _pack_last data, words_count
  # DEBUG words count
  al.logi "words count #{words_count}"
  o


_make_main_name = (meta) ->
  title = meta.title.split('\n').join(' ').split(' ').join('-')
  author = meta.author.name.trim()
  "#{title}@#{author}-#{meta.site}"

_make_time_name = ->
  # TODO support GMT+0800 (CST)
  t = new Date().toISOString()
  date = t.split('T')[0].split('-').join('')
  time_s = t.split('T')[1].split('.')[0].split(':').join('')
  "#{date}-#{time_s}"

pack_filename = (meta) ->
  "#{_make_main_name meta}-#{_make_time_name meta}#{config.PACK_FILE}"

meta_filename = (meta) ->
  "#{config.META_FILE[0]}#{_make_main_name meta}#{config.META_FILE[1]}"


module.exports = {
  pack
  pack_filename
  meta_filename
}
