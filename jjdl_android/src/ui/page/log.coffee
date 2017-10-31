# log.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  Text
} = require 'react-native'

Top = require '../sub/top'


Page = cC {
  displayName: 'PageLog'
  propTypes: {
    # TODO
  }

  render: ->
    (cE View, null,
      (cE Top, {
        type: 'right'
        text: '日志'
        on_nav: () -> null
        })
      # TODO body
      (cE Text, null,
        'page log'
      )
      # TODO
    )
}

module.exports = Page
