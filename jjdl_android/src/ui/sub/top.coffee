# top.coffee, jjdl_android/src/ui/sub/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  TouchableNativeFeedback
} = require 'react-native'
{ default: IconF } = require 'react-native-vector-icons/Feather'

co = require '../color'
ss = require '../style'


_top_button = (onPress, name) ->
  (cE TouchableNativeFeedback, {
    onPress
    background: TouchableNativeFeedback.Ripple co.BG_TOUCH
    },
    (cE View, {
      style: {
        height: ss.TOP_HEIGHT
        width: ss.TOP_HEIGHT
        flexDirection: 'row'
        alignItems: 'center'
        justifyContent: 'center'
      } },
      (cE IconF, {
        name
        size: ss.TOP_ICON_SIZE
        style: {
          color: co.TEXT_SEC
        } })
    )
  )


Top = cC {
  displayName: 'Top'
  propTypes: {
    type: PropTypes.string.isRequired  # 'left', 'right'
    text: PropTypes.string.isRequired

    on_nav: PropTypes.func.isRequired
  }

  # back button
  _render_left: ->
    if @props.type is 'left'
      _top_button @props.on_nav, 'chevron-left'

  # menu button
  _render_right: ->
    if @props.type is 'right'
      _top_button @props.on_nav, 'menu'

  render: ->
    # TODO top bottom shadow ?
    (cE View, {
      style: {
        backgroundColor: co.BG_TOP
        height: ss.TOP_HEIGHT
        flexDirection: 'row'
        alignItems: 'center'
      } },
      @_render_left()
      (cE Text, {
        style: {
          flex: 1
          fontSize: ss.TITLE_SIZE
          color: co.TEXT
          padding: ss.TOP_PADDING
        } },
        @props.text
      )
      @_render_right()
    )
}

module.exports = Top
