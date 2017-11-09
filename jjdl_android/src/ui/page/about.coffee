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

co = require '../color'
ss = require '../style'

Top = require '../sub/top'
FullScroll = require '../sub/full_scroll'
ItemRight = require '../sub/item_right'


Page = cC {
  displayName: 'PageAbout'
  propTypes: {
    version_text: PropTypes.string.isRequired

    on_menu: PropTypes.func.isRequired
    on_show_tech: PropTypes.func.isRequired
    on_show_license: PropTypes.func.isRequired
  }

  render: ->
    (cE View, {
      style: {
        flex: 1
        backgroundColor: co.BG
      } },
      (cE Top, {
        type: 'right'
        text: '关于'
        on_nav: @props.on_menu
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
            color: co.TEXT_SEC
            padding: ss.TOP_PADDING
            paddingTop: 0

            flex: 1
            flexShrink: 0
          } },
          @props.version_text
        )
        # tech and LICENSE buttons
        (cE ItemRight, {
          text: '技术'
          on_press: @props.on_show_tech
          })
        (cE ItemRight, {
          on_press: @props.on_show_license
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

config = require '../../config'
action = require '../../action/root'


_get_versions = ->
  o = []
  o.push config.P_VERSION
  o.push config.P_REPO
  # TODO

  o.join '\n'


mapStateToProps = ($$state, props) ->
  {}

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.version_text = _get_versions()

  _show_right = ->
    props.navigation.navigate 'right'

  o.on_menu = ->
    props.screenProps.navigation.navigate 'DrawerOpen'
  o.on_show_tech = ->
    dispatch action.set_about_right('tech')
    _show_right()
  o.on_show_license = ->
    dispatch action.set_about_right('license')
    _show_right()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
