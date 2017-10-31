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
    navigation: PropTypes.object.isRequired
    # TODO
  }

  _on_back: ->
    @props.navigation.goBack()

  render: ->
    (cE View, null,
      (cE Top, {
        type: 'left'
        text: 'TODO'
        on_nav: @_on_back
        })
      # TODO body
      (cE Text, null,
        'page about right'
      )
      # TODO
    )
}

module.exports = Page
