# full_scroll.coffee, jjdl_android/src/ui/sub/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  ScrollView
} = require 'react-native'


FullScroll = cC {
  displayName: 'FullScroll'

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE ScrollView, {
        style: {
          flex: 1
        },
        contentContainerStyle: {
          flexGrow: 1
        } },
        (cE View, {
          style: {
            flex: 1
          } },
          @props.children
        )
      )
    )
}

module.exports = FullScroll
