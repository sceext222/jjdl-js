# about.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  Dimensions

  View
  Text
  Image
} = require 'react-native'

config = require '../../config'

co = require '../color'
ss = require '../style'

Top = require '../sub/top'
FullScroll = require '../sub/full_scroll'
ItemRight = require '../sub/item_right'


_get_versions = ->
  o = []
  o.push config.P_VERSION
  o.push config.P_REPO
  # TODO

  o.join '\n'


Page = cC {
  displayName: 'PageAbout'
  propTypes: {
    screenProps: PropTypes.object.isRequired
    navigation: PropTypes.object.isRequired

    on_show_tech: PropTypes.func.isRequired
    on_show_license: PropTypes.func.isRequired
  }

  _on_menu: ->
    @props.screenProps.navigation.navigate 'DrawerOpen'

  _on_show_right: ->
    @props.navigation.navigate 'right'

  _on_show_tech: ->
    @props.on_show_tech()
    @_on_show_right()

  _on_show_license: ->
    @props.on_show_license()
    @_on_show_right()

  render: ->
    (cE View, {
      style: {
        flex: 1
        backgroundColor: co.BG
      } },
      (cE Top, {
        type: 'right'
        text: '关于'
        on_nav: @_on_menu
        })
      # body
      (cE FullScroll, null,
        # main logo
        (cE Image, {
          source: require '../../img/jjdl-logo-1024.png'
          resizeMode: 'contain'
          style: {
            width: Dimensions.get('window').width
            height: Dimensions.get('window').width
          } })
        # versions
        (cE Text, {
          selectable: true
          style: {
            fontSize: ss.TEXT_SIZE
            color: co.TEXT
            padding: ss.TOP_PADDING
            paddingTop: 0

            flex: 1
            flexShrink: 0
          } },
          _get_versions()
        )
        # tech and LICENSE buttons
        (cE ItemRight, {
          text: '技术'
          on_press: @_on_show_tech
          })
        (cE ItemRight, {
          on_press: @_on_show_license
          },
          (cE Text, {
            style: {
              fontSize: ss.TEXT_SIZE
              color: co.TEXT_SEC
              paddingRight: ss.TOP_PADDING
            } },
            'LICENSE'
          )
          (cE Text, {
            style: {
              fontSize: ss.TEXT_SIZE
              color: co.TEXT
            } },
            'GNU GPLv3+'
          )
        )
      )
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../../action/root'


mapStateToProps = ($$state, props) ->
  {}

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_show_tech = ->
    dispatch action.set_about_right('tech')
  o.on_show_license = ->
    dispatch action.set_about_right('license')
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
