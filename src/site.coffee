# site.coffee, jjdl-js/src/

Jjwxc = require './_site/jjwxc'


SITE_LIST = {
  'jjwxc': Jjwxc
  # TODO
}


create = (site, uri) ->
  new SITE_LIST[site] uri


module.exports = {
  SITE_LIST

  create
}
