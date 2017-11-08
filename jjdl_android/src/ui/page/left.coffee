# left.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  Image
} = require 'react-native'
{
  DrawerItems
} = require 'react-navigation'

co = require '../color'
ss = require '../style'


Page = cC {
  displayName: 'PageLeft'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, {
      style: {
        flex: 1
        backgroundColor: co.BG_LEFT
      } },
      (cE DrawerItems, @props)
      (cE View, {
        style: {
          flex: 1
        } })
      (cE Image, {
        source: require '../../img/jjdl-logo-512.png'
        resizeMode: 'contain'
        style: {
          width: ss.LEFT_WIDTH
          height: ss.LEFT_WIDTH
        } })
    )
}

module.exports = Page
