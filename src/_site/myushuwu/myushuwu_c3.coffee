# myushuwu_c3.coffee, jjdl-js/src/_site/myushuwu/
# re-pack chapters of myushuwu
#
# support chapter title:
#   '第01章'  '第02章'

{ N_CHAR } = require './_c_base'
MyushuwuC2 = require './myushuwu_c2'

class MyushuwuC3 extends MyushuwuC2

  get_site: ->
    'myushuwu-c3'

  get_n_char: ->
    N_CHAR

module.exports = MyushuwuC3  # class
