# start_site.coffee, jjdl_android/src/ui/page/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
} = require 'react-native'

Top = require '../sub/top'
FullScroll = require '../sub/full_scroll'
ItemRight = require '../sub/item_right'


Page = cC {
  displayName: 'PageStartSite'
  propTypes: {
    site: PropTypes.string.isRequired
    site_list: PropTypes.array.isRequired

    on_back: PropTypes.func.isRequired
    on_change_site: PropTypes.func.isRequired
  }

  _render_one_site: (site, is_check) ->
    (cE ItemRight, {
      key: site

      type: 'check'
      text: site
      is_check
      on_press: =>
        @props.on_change_site site
      })

  _render_site_list: ->
    o = []
    for i in @props.site_list
      is_check = false
      if i is @props.site
        is_check = true

      o.push @_render_one_site(i, is_check)
    o

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE Top, {
        type: 'left'
        text: 'Site'
        on_nav: @props.on_back
        })
      # body
      (cE FullScroll, null,
        @_render_site_list()
      )
    )
}


# connect for redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../../action/root'
config = require '../../config'


mapStateToProps = ($$state, props) ->
  {
    site: $$state.get 'site'
    site_list: config.SITE_LIST
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_back = ->
    props.navigation.goBack()
  o.on_change_site = (site) ->
    dispatch action.set_site(site)
    props.navigation.goBack()
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
