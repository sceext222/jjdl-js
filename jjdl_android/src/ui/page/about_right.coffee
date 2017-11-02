# about_right.coffee, jjdl_android/src/ui/page/

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


Page = cC {
  displayName: 'PageAboutRight'
  propTypes: {
    about_right: PropTypes.string.isRequired
    license_text: PropTypes.string.isRequired

    on_back: PropTypes.func.isRequired
  }

  _render_tech: ->
    # TODO
    (cE Text, {
      style: {
        color: co.TEXT
      } },
      'TODO'
    )

  _render_body: ->
    if @props.about_right is 'tech'
      @_render_tech()
    else  # LICENSE
      (cE Text, {
        selectable: true
        style: {
          fontSize: ss.TEXT_SIZE
          color: co.TEXT
          flex: 1
          fontFamily: 'monospace'
        } },
        @props.license_text
      )

  render: ->
    text = 'LICENSE'
    if @props.about_right is 'tech'
      text = '技术'

    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'left'
        text
        on_nav: @props.on_back
        })
      # body
      (cE FullScroll, null,
        @_render_body()
      )
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

config = require '../../config'
action = require '../../action/root'


mapStateToProps = ($$state, props) ->
  license_text = 'GNU GPLv3+'
  if $$state.getIn ['loaded', 'license']
    license_text = config.license_text

  {
    about_right: $$state.get 'about_right'
    license_text
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_back = ->
    props.navigation.goBack()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
