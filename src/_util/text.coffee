# text.coffee, jjdl-js/src/_util/


clean_html_text = (raw) ->
  o = []
  for i in raw
    # replace \r, \n, tab to space (' ')
    one = i.split('\r').join(' ').split('\n').join(' ').split('\t').join(' ')
    # replace chinese BIG space
    one = one.split('　').join(' ')
    # replace multi spaces to only one space
    while one.indexOf('  ') != -1
      one = one.split('  ').join(' ')
    o.push one
  o

clean_text = (raw, join = '\n') ->
  a = clean_html_text Array.from(raw)
  o = []
  for i in a
    one = i.trim()
    if one != ''
      o.push one
  o.join join


indent_line = (raw, prefix = '  ') ->
  a = raw.split '\n'
  o = []
  for i in a
    if i.trim() != ''
      i = prefix + i
    o.push i
  o.join '\n'


module.exports = {
  clean_html_text
  clean_text

  indent_line
}
