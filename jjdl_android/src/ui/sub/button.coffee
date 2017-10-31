# button.coffee, jjdl_android/src/ui/sub/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  TouchableNativeFeedback
} = require 'react-native'

co = require '../color'
ss = require '../style'


Button = cC {
  displayName: 'Button'
  propTypes: {
    text: PropTypes.string.isRequired
    bg: PropTypes.string  # background-color

    on_press: PropTypes.func.isRequired
  }

  render: ->
    backgroundColor = co.BG_BTN
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
          justifyContent: 'center'
          backgroundColor
        } },
        (cE Text, {
          style: {
            fontSize: ss.TITLE_SIZE
            color: co.TEXT_TITLE
          } },
          @props.text
        )
      )
    )
}

module.exports = Button
