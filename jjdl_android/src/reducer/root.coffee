# root.coffee, jjdl_android/src/reducer/

Immutable = require 'immutable'

state = require '../state'
ac = require '../action/root'

_check_init = ($$state) ->
  $$o = $$state
  if ! $$o?
    $$o = Immutable.fromJS state
  $$o

reducer = ($$state, action) ->
  $$o = _check_init $$state
  switch action.type
    when ac.A_SET_SITE
      $$o = $$o.set 'site', action.payload
    when ac.A_SET_URL
      $$o = $$o.set 'url', action.payload
    when ac.A_SET_IS_DOING
      $$o = $$o.set 'is_doing', action.payload
    when ac.A_CLEAR_LOG
      $$o = $$o.update 'logs', ($$) ->
        $$.clear()
    when ac.A_LOG
      $$o = $$o.update 'logs', ($$) ->
        $$.push action.payload
    when ac.A_SET_CACHE_PATH
      $$o = $$o.set 'cache_path', action.payload
    when ac.A_SET_IS_CLEANING
      $$o = $$o.set 'is_cleaning', action.payload
    when ac.A_SET_ABOUT_RIGHT
      $$o = $$o.set 'about_right', action.payload
    when ac.A_SET_LOADED
      $$o = $$o.setIn ['loaded', action.payload.type], action.payload.loaded
    when ac.A_SET_PM_BRIDGE_URL
      $$o = $$o.set 'pm_bridge_url', action.payload
    when ac.A_SET_SITE_LIST
      $$o = $$o.set 'site_list', Immutable.fromJS(action.payload)
  $$o

module.exports = reducer
