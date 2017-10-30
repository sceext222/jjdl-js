# left.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

# TODO


Page = cC {
  displayName: 'PageLeft'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, null,
      (cE Text, null,
        'page left'
      )
      # TODO
    )
}

module.exports = Page
