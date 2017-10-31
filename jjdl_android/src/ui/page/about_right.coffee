# about_right.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

Top = require '../sub/top'


Page = cC {
  displayName: 'PageAboutRight'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, null,
      (cE Top, {
        type: 'left'
        text: 'TODO'
        on_nav: () -> null
        })
      # TODO body
      (cE Text, null,
        'page about right'
      )
      # TODO
    )
}

module.exports = Page
