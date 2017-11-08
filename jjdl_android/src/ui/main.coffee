# main.coffee, jjdl_android/src/ui/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
} = require 'react-native'
{
  DrawerNavigator
  TabNavigator
} = require 'react-navigation'
{ default: IconF } = require 'react-native-vector-icons/Feather'

co = require './color'
ss = require './style'

PageStart = require './page/start'
PageStartSite = require './page/start_site'
PageLog = require './page/log'
PageMore = require './page/more'
PageAbout = require './page/about'
PageAboutRight = require './page/about_right'

PageLeft = require './page/left'


ScreenStart = TabNavigator {
  start: {
    screen: PageStart
    navigationOptions: {
      tabBarVisible: false
    }
  }
  site: {
    screen: PageStartSite
    navigationOptions: {
      tabBarVisible: false
    }
  }
}, {
  swipeEnabled: false
  lazy: false
}

ScreenAbout = TabNavigator {
  about: {
    screen: PageAbout
    navigationOptions: {
      tabBarVisible: false
    }
  }
  right: {
    screen: PageAboutRight
    navigationOptions: {
      tabBarVisible: false
    }
  }
}, {
  swipeEnabled: false
  lazy: false
}


_left_icon = (icon, name) ->
  ({ tintColor, focused}) ->
    (cE icon, {
      name
      size: ss.LEFT_ICON_SIZE
      style: {
        color: tintColor
      } })

Main = DrawerNavigator {
  start: {
    screen: ({navigation}) ->
      (cE ScreenStart, {
        screenProps: {
          navigation
        } })
    navigationOptions: {
      drawerLabel: '开始'
      drawerIcon: _left_icon IconF, 'arrow-right'
    }
  }
  log: {
    screen: PageLog
    navigationOptions: {
      drawerLabel: '日志'
      drawerIcon: _left_icon IconF, 'activity'
    }
  }
  cache: {
    screen: PageMore
    navigationOptions: {
      drawerLabel: '更多'
      drawerIcon: _left_icon IconF, 'download'
    }
  }
  about: {
    screen: ({navigation}) ->
      (cE ScreenAbout, {
        screenProps: {
          navigation
        } })
    navigationOptions: {
      drawerLabel: '关于'
      drawerIcon: _left_icon IconF, 'info'
    }
  }
}, {
  drawerWidth: ss.LEFT_WIDTH
  contentComponent: PageLeft
}

module.exports = Main
