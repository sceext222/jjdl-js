# start.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
  TextInput
  ProgressBarAndroid: ProgressBar
} = require 'react-native'

co = require '../color'
ss = require '../style'

ItemRight = require '../sub/item_right'
Input = require '../sub/input'
Button = require '../sub/button'


Page = cC {
  displayName: 'PageStart'
  propTypes: {
    site: PropTypes.string.isRequired
    url: PropTypes.string.isRequired
    show_button: PropTypes.bool.isRequired
    is_loading: PropTypes.bool.isRequired

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

  _render_body: ->
    if @props.is_loading
      (cE View, {
        style: {
          # TODO
        } },
        (cE ProgressBar, {
          # FIXME react-native BUG here
          styleAttr: 'Horizontal'
          })
        (cE Text, {
          style: {
            textAlign: 'center'
            fontSize: ss.TEXT_SIZE
            color: co.TEXT_SEC
          } },
          '正在加载 .. . '
        )
      )
    else
      # FIXME text input BUG
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

          backgroundColor: co.BG
          flexWrap: 'wrap'
        } })

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE View, {
        style: {
          # bottom border
          borderBottomWidth: ss.BORDER_WIDTH
          borderBottomColor: co.BORDER
        } },
        (cE ItemRight, {
          type: null
          bg: co.BG
          on_press: @props.on_show_site
          },
          (cE Text, {
            style: {
              flex: 1
              fontSize: ss.TITLE_SIZE
              color: co.TEXT
            } },
            'Site'
          )
          (cE Text, {
            style: {
              paddingRight: ss.TOP_PADDING
              fontSize: ss.TITLE_SIZE
              color: co.TEXT_SEC
            } },
            @props.site
          )
        )
      )
      # URL
      @_render_body()
      # start button
      @_render_button()
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

util = require '../../util'
action = require '../../action/root'
op = require '../../action/op'

mapStateToProps = ($$state, props) ->
  is_doing = $$state.get 'is_doing'
  is_loading = false

  show_button = false
  if ! is_doing
    show_button = true
  url = $$state.get 'url'
  if url.trim() is ''
    show_button = false

  site = util.parse_site_name $$state.get('site')

  {
    site
    url
    show_button
    is_loading
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
    dispatch op.start_jjdl()
    _show_log()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
