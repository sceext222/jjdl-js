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

config = require './config'
reducer = require './reducer/root'
action = require './action/root'
op = require './action/op'

Main = require './ui/main'


# redux store
store = createStore reducer, applyMiddleware(thunk)
config.store = store  # save global store

O = cC {

  componentDidMount: ->
    # init
    store.dispatch op.load_assets()
    store.dispatch op.check_cache()

  componentWillUnmount: ->
    # TODO

  render: ->
    (cE Provider, {
      store
      },
      (cE Main)
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
