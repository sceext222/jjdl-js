# start.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

# TODO


Page = cC {
  displayName: 'PageStart'
  propTypes: {
    screenProps: PropTypes.object.isRequired
    navigation: PropTypes.object.isRequired
    # TODO
  }

  _on_show_site: ->
    @props.navigation.navigate 'site'

  _on_show_log: ->
    @props.screenProps.navigation.navigate 'log'

  render: ->
    (cE View, null,
      (cE Text, null,
        'page start'
      )
      # TODO
    )
}

module.exports = Page
