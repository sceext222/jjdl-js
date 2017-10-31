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

reducer = require './reducer/root'
action = require './action/root'

Main = require './ui/main'


# redux store
store = createStore reducer, applyMiddleware(thunk)

O = cC {
  # TODO

  render: ->
    (cE Provider, {
      store
      },
      (cE Main)
    )
}

init = ->
  # TODO
  () =>
    O

module.exports = {
  store
  O

  init
}
