# about.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

Top = require '../sub/top'


Page = cC {
  displayName: 'PageAbout'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, null,
      (cE Top, {
        type: 'right'
        text: '关于'
        on_nav: () -> null
        })
      # TODO body
      (cE Text, null,
        'page about'
      )
      # TODO
    )
}

module.exports = Page
