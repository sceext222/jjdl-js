# site.coffee, jjdl-js/src/

Jjwxc = require './_site/jjwxc'
Mjjwxc = require './_site/mjjwxc'


SITE_LIST = {
  'jjwxc': Jjwxc
  'mjjwxc': Mjjwxc
}


create = (site, uri) ->
  new SITE_LIST[site] uri


module.exports = {
  SITE_LIST

  create
}
