# text.coffee, jjdl-js/src/_util/

_NUM_CHAR = '0123456789'


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


# get first number from one line, eg: 'X 123 Y'
get_first_number = (raw, default_value = null) ->
  start = null
  end = null
  # scan num char
  for i in [0... raw.length]
    if (! start?) and (_NUM_CHAR.indexOf(raw[i]) != -1)
      start = i
    else if (start?) and (_NUM_CHAR.indexOf(raw[i]) is -1)
      end = i
      break
  # check no number
  if ! start?
    if default_value?
      return default_value
    else
      throw new Error "no number in text: `#{raw}`"
  # check no end
  if ! end?
    end = raw.length
  # parse number
  Number.parseInt raw[start ... end]


module.exports = {
  clean_html_text
  clean_text

  indent_line

  get_first_number
}
