# site.coffee, jjdl-js/src/

Jjwxc = require './_site/jjwxc'
Mjjwxc = require './_site/mjjwxc'

Myushuwu   = require './_site/myushuwu/myushuwu'
MyushuwuC  = require './_site/myushuwu/myushuwu_c'
MyushuwuC2 = require './_site/myushuwu/myushuwu_c2'
MyushuwuC3 = require './_site/myushuwu/myushuwu_c3'
MyushuwuC4 = require './_site/myushuwu/myushuwu_c4'

SITE_LIST = {
  'jjwxc': Jjwxc
  'mjjwxc': Mjjwxc

  'myushuwu': Myushuwu
  'myushuwu-c': MyushuwuC
  'myushuwu-c2': MyushuwuC2
  'myushuwu-c3': MyushuwuC3
  'myushuwu-c4': MyushuwuC4
}


create = (site, uri) ->
  core = SITE_LIST[site]
  if ! core?
    throw new Error "no such site [#{site}]"
  new core uri


module.exports = {
  SITE_LIST

  create
}
