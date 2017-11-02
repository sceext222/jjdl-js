# state.coffee, jjdl_android/src/

init_state = {  # with Immutable
  site: 'jjwxc'
  url: ''

  is_doing: false  # jjdl-core running
  logs: []  # all log text items

  cache_path: null  # null means cache empty
  is_cleaning: false

  # about right page, which to show
  about_right: 'tech'  # 'tech', 'license'

  # loaded flags
  loaded: {
    license: false  # assets/LICENSE
  }
}

module.exports = init_state
