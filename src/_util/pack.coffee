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
  o += "#{data.meta.title}\n"
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
  o += "jjdl-js:: title #{data.meta.title}\n"
  o += "    chapter count #{Object.keys(data.chapter).length}, words count #{words_count} \n"
  o += "jjdl-js: last_update #{last_update()}\n\n"
  o

_pack_one_chapter = (data, index) ->
  o = '\n'
  # TODO zfill to chapter count
  chapter_name = "第 #{index} 章  #{data.meta.chapter[index].title}"
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
  al.logd "words count #{words_count}"
  o

pack_filename = (meta) ->
  # TODO improve name
  main = meta.title.split('\n').join(' ').split(' ').join('-')
  # time
  t = new Date().toISOString()
  time = t.split('T')[0].split('-').join('') + '-' + t.split('T')[1].split('.')[0].split(':').join('')

  "#{main}-#{time}#{config.PACK_FILE}"


module.exports = {
  pack
  pack_filename
}
