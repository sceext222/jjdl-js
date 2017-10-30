# about.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

# TODO


Page = cC {
  displayName: 'PageAbout'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, null,
      (cE Text, null,
        'page about'
      )
      # TODO
    )
}

module.exports = Page
