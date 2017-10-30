# main.coffee, jjdl_android/src/ui/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Image
} = require 'react-native'
{
  DrawerNavigator
  DrawerItems
} = require 'react-navigation'
{ default: IconF } = require 'react-native-vector-icons/Feather'

PageStart = require './page/start'
PageStartSite = require './page/start_site'
PageLog = require './page/log'
PageCache = require './page/cache'
PageAbout = require './page/about'
PageAboutTech = require './page/about_tech'
PageAboutLicense = require './page/about_license'

PageLeft = require './page/left'  # TODO


_LEFT_ICON_SIZE = 20
_LEFT_WIDTH = 150


Main = DrawerNavigator {
  start: {
    screen: PageStart
    navigationOptions: {
      drawerLabel: '开始'
      drawerIcon: ({ tintColor, focused }) ->
        (cE IconF, {
          name: 'arrow-right'
          size: _LEFT_ICON_SIZE
          style: {
            color: tintColor
          } })
    }
  }
  log: {
    screen: PageLog
    navigationOptions: {
      drawerLabel: '日志'
      drawerIcon: ({ tintColor, focused }) ->
        (cE IconF, {
          name: 'activity'
          size: _LEFT_ICON_SIZE
          style: {
            color: tintColor
          } })
    }
  }
  cache: {
    screen: PageCache
    navigationOptions: {
      drawerLabel: '缓存'
      drawerIcon: ({ tintColor, focused }) ->
        (cE IconF, {
          name: 'download'
          size: _LEFT_ICON_SIZE
          style: {
            color: tintColor
          } })
    }
  }
  about: {
    screen: PageAbout
    navigationOptions: {
      drawerLabel: '关于'
      drawerIcon: ({ tintColor, focused }) ->
        (cE IconF, {
          name: 'info'
          size: _LEFT_ICON_SIZE
          style: {
            color: tintColor
          } })
    }
  }
}, {
  drawerWidth: _LEFT_WIDTH
  contentComponent: (props) ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE DrawerItems, props)
      (cE View, {
        style: {
          flex: 1
        } })
      (cE Image, {
        source: require '../img/jjdl-logo-512.png'
        resizeMode: 'contain'
        style: {
          width: _LEFT_WIDTH
          height: _LEFT_WIDTH
        } })
    )
}

module.exports = Main
