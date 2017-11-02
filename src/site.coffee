# site.coffee, jjdl-js/src/

Jjwxc = require './_site/jjwxc'
Mjjwxc = require './_site/mjjwxc'
Myushuwu = require './_site/myushuwu'
MyushuwuC = require './_site/myushuwu_c'


SITE_LIST = {
  'jjwxc': Jjwxc
  'mjjwxc': Mjjwxc
  'myushuwu': Myushuwu
  'myushuwu-c': MyushuwuC
}


create = (site, uri) ->
  new SITE_LIST[site] uri


module.exports = {
  SITE_LIST

  create
}
