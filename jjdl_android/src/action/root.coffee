# root.coffee, jjdl_android/src/action/

# action types
A_SET_SITE = 'a_set_site'
A_SET_URL = 'a_set_url'

A_SET_IS_DOING = 'a_set_is_doing'
A_CLEAR_LOG = 'a_clear_log'
A_LOG = 'a_log'

A_SET_CACHE_PATH = 'a_set_cache_path'
A_SET_IS_CLEANING = 'a_set_is_cleaning'
A_SET_ABOUT_RIGHT = 'a_set_about_right'
A_SET_LOADED = 'a_set_loaded'
A_SET_PM_BRIDGE_URL = 'a_set_pm_bridge_url'
A_SET_SITE_LIST = 'a_set_site_list'


set_site = (site) ->
  {
    type: A_SET_SITE
    payload: site
  }

set_url = (url) ->
  {
    type: A_SET_URL
    payload: url
  }

set_is_doing = (doing) ->
  {
    type: A_SET_IS_DOING
    payload: doing
  }

clear_log = ->
  {
    type: A_CLEAR_LOG
  }

log = (text) ->
  {
    type: A_LOG
    payload: text
  }

set_cache_path = (cache_path) ->
  {
    type: A_SET_CACHE_PATH
    payload: cache_path
  }

set_is_cleaning = (cleaning) ->
  {
    type: A_SET_IS_CLEANING
    payload: cleaning
  }

set_about_right = (right) ->
  {
    type: A_SET_ABOUT_RIGHT
    payload: right
  }

set_loaded = (type, loaded) ->
  {
    type: A_SET_LOADED
    payload: {
      type
      loaded
    }
  }

set_pm_bridge_url = (url) ->
  {
    type: A_SET_PM_BRIDGE_URL
    payload: url
  }

set_site_list = (list) ->
  {
    type: A_SET_SITE_LIST
    payload: list
  }

module.exports = {
  A_SET_SITE
  A_SET_URL
  A_SET_IS_DOING
  A_CLEAR_LOG
  A_LOG
  A_SET_CACHE_PATH
  A_SET_IS_CLEANING
  A_SET_ABOUT_RIGHT
  A_SET_LOADED
  A_SET_PM_BRIDGE_URL
  A_SET_SITE_LIST

  set_site
  set_url
  set_is_doing
  clear_log
  log
  set_cache_path
  set_is_cleaning
  set_about_right
  set_loaded
  set_pm_bridge_url
  set_site_list
}
