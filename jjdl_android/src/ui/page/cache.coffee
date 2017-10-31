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
    navigation: PropTypes.object.isRequired

    cache_path: PropTypes.string

    on_clear_cache: PropTypes.func.isRequired
  }

  _on_menu: ->
    @props.navigation.navigate 'DrawerOpen'

  _render_button: ->
    if @props.cache_path?
      (cE Button, {
        text: '清除'
        on_press: @props.on_clear_cache
        })

  render: ->
    cache_path = '没有内容'
    if @props.cache_path?
      cache_path = @props.cache_path

    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'right'
        text: '缓存'
        on_nav: @_on_menu
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
          cache_path
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


mapStateToProps = ($$state, props) ->
  {
    cache_path: $$state.get 'cache_path'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_clear_cache = ->
    # TODO
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
