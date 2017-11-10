# myushuwu_c3.coffee, jjdl-js/src/_site/
# re-pack chapters of myushuwu
#
# support chapter title:
#   '第01章'  '第02章'

util = require '../util'

MyushuwuC2 = require './myushuwu_c2'

_N_CHAR = '0123456789'

class MyushuwuC3 extends MyushuwuC2

  get_site: ->
    'myushuwu-c3'

  get_n_char: ->
    _N_CHAR

module.exports = MyushuwuC3  # class
