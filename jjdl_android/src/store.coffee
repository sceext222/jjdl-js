# store.coffee, jjdl_android/src/

{
  createStore
  applyMiddleware
} = require 'redux'
{ default: thunk } = require 'redux-thunk'

{ Provider } = require 'react-redux'

{ createElement: cE } = require 'react'
cC = require 'create-react-class'
PropTypes = require 'prop-types'

{
  PermissionsAndroid
} = require 'react-native'

config = require './config'
reducer = require './reducer/root'
action = require './action/root'
op = require './action/op'

Main = require './ui/main'
MainWebview = require './ui/webview'


# redux store
store = createStore reducer, applyMiddleware(thunk)
config.store = store  # save global store


_check_permissions = ->
  # storage
  try
    if ! await PermissionsAndroid.check PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE
      await PermissionsAndroid.request PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE, {
        title: '丁丁下载 需要 访问存储权限'
        message: '用于保存下载的文件.'
      }
  catch e
    # FIXME ignore all errors


O = cC {

  componentDidMount: ->
    # init
    store.dispatch op.load_assets()
    store.dispatch op.check_cache()
    # android permissions
    await _check_permissions()

  componentWillUnmount: ->
    # TODO

  render: ->
    (cE Provider, {
      store
      },
      (cE MainWebview, null,
        (cE Main)
      )
    )
}

init = ->
  () =>
    O

module.exports = {
  store
  O

  init
}
