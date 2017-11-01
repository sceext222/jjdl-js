# cache.coffee, jjdl_android/src/ui/page/

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
Button = require '../sub/button'


Page = cC {
  displayName: 'PageCache'
  propTypes: {
    show_button: PropTypes.bool.isRequired
    cache_path: PropTypes.string.isRequired

    on_menu: PropTypes.func.isRequired
    on_clear_cache: PropTypes.func.isRequired
  }

  _render_button: ->
    if @props.show_button
      (cE Button, {
        text: '清除'
        on_press: @props.on_clear_cache
        })

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'right'
        text: '缓存'
        on_nav: @props.on_menu
        })
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
            fontSize: ss.TEXT_SIZE
            color: co.TEXT_SEC
          } },
          @props.cache_path
        )
      )
      # clear cache button
      @_render_button()
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

  show_button = false
  if cache_path? and (! is_cleaning) and (! is_doing)
    show_button = true

  if ! cache_path?
    cache_path = '没有内容'
  if is_cleaning
    cache_path = '正在清除 .. . '

  {
    show_button
    cache_path
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_menu = ->
    props.navigation.navigate 'DrawerOpen'
  o.on_clear_cache = ->
    dispatch op.clear_cache()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
