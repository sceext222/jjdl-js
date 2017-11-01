# log.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

co = require '../color'
ss = require '../style'

Top = require '../sub/top'
FullScroll = require '../sub/full_scroll'
Button = require '../sub/button'


# TODO auto-scroll to end on every log output
Page = cC {
  displayName: 'PageLog'
  propTypes: {
    log_text: PropTypes.string.isRequired
    is_doing: PropTypes.bool.isRequired

    on_menu: PropTypes.func.isRequired
    on_stop: PropTypes.func.isRequired
  }

  _render_button: ->
    if @props.is_doing
      (cE Button, {
        text: '停止'
        bg: co.BG_BTN_DANGER
        on_press: @props.on_stop
        })

  render: ->
    text = '日志'
    if @props.is_doing
      text = '正在处理 .. . '

    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'right'
        text
        on_nav: @props.on_menu
        })
      # body
      (cE FullScroll, null,  # TODO maybe not need FullScroll
        (cE Text, {
          selectable: true
          style: {
            fontSize: ss.TEXT_SIZE
            color: co.TEXT
            fontFamily: 'monospace'
          } },
          @props.log_text
        )
      )
      # stop button
      @_render_button()
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../../action/root'
op = require '../../action/op'


mapStateToProps = ($$state, props) ->
  {
    log_text: $$state.get('logs').join '\n'
    is_doing: $$state.get 'is_doing'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_menu = ->
    props.navigation.navigate 'DrawerOpen'
  o.on_stop = ->
    # just change is_doing to false
    dispatch action.set_is_doing(false)
    dispatch op.check_cache()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
