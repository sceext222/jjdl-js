# item_right.coffee, jjdl_android/src/ui/sub/

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


ItemRight = cC {
  displayName: 'ItemRight'
  propTypes: {
    type: PropTypes.string  # 'right' (default), 'check'
    text: PropTypes.string
    is_check: PropTypes.bool
    bg: PropTypes.string  # background-color
    # children
    on_press: PropTypes.func.isRequired
  }

  _render_text: ->
    color = co.TEXT
    if (@props.type is 'check') and (! @props.is_check)
      color = co.TEXT_SEC

    if @props.text?
      (cE Text, {
        style: {
          fontSize: ss.TEXT_SIZE
          color
        } },
        @props.text
      )

  _render_right: ->
    color = co.TEXT_SEC
    name = 'chevron-right'
    if @props.type is 'check'
      if @props.is_check
        name = 'check'
        color = co.TEXT_BG
      else
        name = null
    # check not render right
    if @props.type is null
      name = null

    if name?
      (cE View, {
        style: {
          width: ss.TOP_HEIGHT
          flexDirection: 'row'
          alignItems: 'center'
          justifyContent: 'center'
        } },
        (cE IconF, {
          name
          size: ss.TOP_ICON_SIZE
          style: {
            color
          } })
      )

  render: ->
    backgroundColor = co.BG
    if @props.is_check
      backgroundColor = co.BG_SEC
    if @props.bg?
      backgroundColor = @props.bg

    (cE TouchableNativeFeedback, {
      onPress: @props.on_press
      background: TouchableNativeFeedback.Ripple co.BG_TOUCH
      },
      (cE View, {
        style: {
          height: ss.TOP_HEIGHT
          flexDirection: 'row'
          alignItems: 'center'
          backgroundColor
          padding: ss.TOP_PADDING
          paddingRight: 0
        } },
        (cE View, {
          style: {
            flex: 1
            flexDirection: 'row'
            alignItems: 'center'
          } },
          @_render_text()
          @props.children  # if any
        )
        @_render_right()
      )
    )
}

module.exports = ItemRight
