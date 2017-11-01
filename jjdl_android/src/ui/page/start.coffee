# start.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  TextInput
} = require 'react-native'

co = require '../color'
ss = require '../style'

ItemRight = require '../sub/item_right'
Button = require '../sub/button'


Page = cC {
  displayName: 'PageStart'
  propTypes: {
    site: PropTypes.string.isRequired
    url: PropTypes.string.isRequired
    show_button: PropTypes.bool.isRequired

    on_change_url: PropTypes.func.isRequired
    on_show_site: PropTypes.func.isRequired
    on_start: PropTypes.func.isRequired
  }

  _render_button: ->
    if @props.show_button
      (cE Button, {
        text: '开始'
        on_press: @props.on_start
        })

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE ItemRight, {
        type: null
        bg: co.BG_TOP
        on_press: @props.on_show_site
        },
        (cE Text, {
          style: {
            flex: 1
            fontSize: ss.TITLE_SIZE
            color: co.TEXT_TITLE
          } },
          'Site'
        )
        (cE Text, {
          style: {
            paddingRight: ss.TOP_PADDING
            fontSize: ss.TITLE_SIZE
            color: co.TEXT
          } },
          @props.site
        )
      )
      # FIXME text input BUG
      # URL
      (cE TextInput, {
        value: @props.url
        placeholder: 'URL'
        placeholderTextColor: co.TEXT_SEC

        autoCapitalize: 'none'
        autoCorrect: false
        autoGrow: true
        underlineColorAndroid: 'transparent'

        onChangeText: @props.on_change_url

        style: {
          fontSize: ss.TEXT_SIZE
          color: co.TEXT
          fontFamily: 'monospace'

          backgroundColor: co.BG_SEC
          flexWrap: 'wrap'
        } })
      (cE View, {
        style: {
          flex: 1  # placeholder
        } })
      # start button
      @_render_button()
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../../action/root'


mapStateToProps = ($$state, props) ->
  is_doing = $$state.get 'is_doing'

  show_button = false
  if ! is_doing
    show_button = true
  # check loaded
  if ! $$state.getIn ['loaded', 'pm_bridge']
    show_button = false
  if ! $$state.getIn ['loaded', 'jjdl_core']
    show_button = false

  {
    site: $$state.get 'site'
    url: $$state.get 'url'
    show_button
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props

  _show_log = ->
    props.screenProps.navigation.navigate 'log'

  o.on_change_url = (url) ->
    dispatch action.set_url(url)
  o.on_show_site = ->
    props.navigation.navigate 'site'
  o.on_start = ->
    # TODO
    _show_log()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
