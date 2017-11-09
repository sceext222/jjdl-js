# log.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  ScrollView
} = require 'react-native'

co = require '../color'
ss = require '../style'

Top = require '../sub/top'
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
      (cE View, {
        style: {
          # top border
          borderTopWidth: ss.BORDER_WIDTH
          borderTopColor: co.BORDER
        } },
        (cE Button, {
          text: '停止'
          bg: co.BG_BTN  # TODO danger button
          on_press: @props.on_stop
        })
      )

  _on_auto_scroll: ->
    # TODO improve scroll logic
    _do_scroll = =>
      @_scroll.scrollToEnd()
    setTimeout _do_scroll, 1e2  # with a small latency

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
      (cE View, {
        style: {
          flex: 1
        } },
        (cE ScrollView, {
          onContentSizeChange: @_on_auto_scroll
          ref: (it) =>
            @_scroll = it
          style: {
            flex: 1
          }
          contentContainerStyle: {
            flexGrow: 1
          } },
          (cE View, {
            style: {
              flex: 1
            } },
            # horizontal scroll
            (cE ScrollView, {
              horizontal: true
              style: {
                flex: 1
              } },
              (cE Text, {
                selectable: true
                style: {
                  fontSize: ss.LOG_TEXT_SIZE
                  color: co.TEXT
                  fontFamily: 'monospace'
                } },
                @props.log_text
              )
            )
          )
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
    # log for DEBUG
    dispatch action.log('[stopped]')
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
