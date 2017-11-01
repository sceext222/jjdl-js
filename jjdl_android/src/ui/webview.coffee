# webview.coffee, jjdl_android/src/ui/

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  View
  WebView
} = require 'react-native'

config = require '../config'


Page = cC {
  displayName: 'PageWebview'
  propTypes: {
    show_webview: PropTypes.bool.isRequired
    # children
    on_message: PropTypes.func.isRequired
    on_error: PropTypes.func.isRequired
  }

  postMessage: (text) ->
    @_webview.postMessage text

  injectJavaScript: (text) ->
    @_webview.injectJavaScript text

  _on_message: (event) ->
    @props.on_message event.nativeEvent.data, this

  _render_webview: ->
    if @props.show_webview
      (cE WebView, {
        source: {
          html: config.pm_bridge_html
        }
        onError: @props.on_error
        onMessage: @_on_message

        domStorageEnabled: false
        javaScriptEnabled: true
        mixedContentMode: 'always'

        ref: (it) =>
          @_webview = it
        # special style
        style: {
          height: 1
          backgroundColor: 'rgb(0, 0, 250)'  # FIXME strange BUG
        }
      })

  render: ->
    (cE View, {
      style: {
        flex: 1
      } },
      (cE View, {
        style: {
          flex: 1
        } },
        @props.children
      )
      # a hidden webview
      (cE View, {
        style: {  # special style
          height: 1
          backgroundColor: 'rgb(250, 0, 0)'
        } },
        @_render_webview()
      )
    )
}

# connect to redux
{ connect } = require 'react-redux'
Immutable = require 'immutable'

action = require '../action/root'

pm_bridge = require '../pm_bridge'


mapStateToProps = ($$state, props) ->
  show_webview = false
  if $$state.get 'is_doing'
    show_webview = true

  {
    show_webview
  }

mapDispatchToProps = (dispatch, props) ->
  o = Object.assign {}, props
  o.on_message = (raw, that) ->
    pm_bridge.on_message raw, that
  o.on_error = (e) ->
    text = "unknow WebView ERROR: #{e}  #{e.stack}"
    dispatch action.log(text)
  o

module.exports = connect(mapStateToProps, mapDispatchToProps)(Page)
