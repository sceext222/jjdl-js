# more.coffee, jjdl_android/src/ui/page/

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


Page = cC {
  displayName: 'PageMore'
  propTypes: {
    show_clear_button: PropTypes.bool.isRequired
    show_upgrade_button: PropTypes.bool.isRequired
    cache_path: PropTypes.string.isRequired
    is_cache_path: PropTypes.bool.isRequired

    on_menu: PropTypes.func.isRequired
    on_clear_cache: PropTypes.func.isRequired
    on_check_upgrade: PropTypes.func.isRequired
  }

  _render_clear_button: ->
    if @props.show_clear_button
      (cE Button, {
        text: '清除'
        on_press: @props.on_clear_cache
      })

  _render_cache: ->
    fontFamily = undefined
    if @props.is_cache_path
      fontFamily = 'monospace'

    (cE View, {
      style: {
        #flex: 1
      } },
      (cE Text, {
        style: {
          fontSize: ss.TITLE_SIZE
          color: co.TEXT
          padding: ss.TOP_PADDING
        } },
        '缓存'
      )
      # cache path
      (cE View, {
        style: {
          flex: 1
          flexDirection: 'row'
          alignItems: 'center'
          justifyContent: 'center'
        } },
        (cE Text, {
          style: {
            fontFamily
            fontSize: ss.TEXT_SIZE
            color: co.TEXT_SEC
          } },
          @props.cache_path
        )
      )
      # clear cache button
      @_render_clear_button()
    )

  _render_upgrade_button: ->
    if @props.show_upgrade_button
      (cE Button, {
        text: '检查'
        on_press: @props.on_check_upgrade
      })

  _render_upgrade: ->
    (cE View, {
      style: {
        # TODO
      } },
      (cE Text, {
        style: {
          fontSize: ss.TITLE_SIZE
          color: co.TEXT
          padding: ss.TOP_PADDING
        } },
        '更新'
      )
      # placeholder
      (cE View, {
        style: {
          flex: 1
        } })
      # check upgrade button
      @_render_upgrade_button()
    )

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'right'
        text: '更多'
        on_nav: @props.on_menu
        })
      (cE FullScroll, null,
        @_render_cache()
        @_render_upgrade()
      )
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../../action/root'
op = require '../../action/op'


mapStateToProps = ($$state, props) ->
  cache_path = $$state.get 'cache_path'
  is_cleaning = $$state.get 'is_cleaning'
  is_doing = $$state.get 'is_doing'

  show_clear_button = false
  if cache_path? and (! is_cleaning) and (! is_doing)
    show_clear_button = true

  show_upgrade_button = true
  if is_doing
    show_upgrade_button = false

  is_cache_path = true
  if ! cache_path?
    cache_path = '没有内容'
    is_cache_path = false
  if is_cleaning
    cache_path = '正在清除 .. . '
    is_cache_path = false

  {
    show_clear_button
    show_upgrade_button
    cache_path
    is_cache_path
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_menu = ->
    props.navigation.navigate 'DrawerOpen'
  o.on_clear_cache = ->
    dispatch op.clear_cache()
  o.on_check_upgrade = ->
    dispatch op.check_upgrade()
    # show log page
    props.navigation.navigate 'log'
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
