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
    navigation: PropTypes.object.isRequired

    about_right: PropTypes.string.isRequired
    license_text: PropTypes.string
  }

  _on_back: ->
    @props.navigation.goBack()

  _render_tech: ->
    # TODO
    (cE Text, {
      style: {
        color: co.TEXT
      } },
      'TODO tech'
    )

  _render_license: ->
    license_text = 'GNU GPLv3+'
    if @props.license_text?
      license_text = @props.license_text

    (cE Text, {
      selectable: true
      style: {
        fontSize: ss.TEXT_SIZE
        color: co.TEXT
        flex: 1
        fontFamily: 'monospace'
      } },
      license_text
    )

  _render_body: ->
    if @props.about_right is 'tech'
      @_render_tech()
    else
      @_render_license()

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
        on_nav: @_on_back
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

action = require '../../action/root'


mapStateToProps = ($$state, props) ->
  {
    about_right: $$state.get 'about_right'
    license_text: $$state.get 'license_text'
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
