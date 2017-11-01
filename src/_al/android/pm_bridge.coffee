# pm_bridge.coffee, jjdl-js/src/_al/android/
#
# use global:
#   window


# global callback pool
_callback_pool = {
  # _id: callback function
}
_max_id = 0  # unique id counter

_etc = {
  main: null  # main function to invoke
}


# global message listener
_on_msg = (raw) ->
  msg = JSON.parse raw
  switch msg.type
    when 'args'
      _etc.main msg.payload
    when 'callback'
      _callback_pool[msg._id]?(msg)
      # clean callback pool
      Reflect.deleteProperty _callback_pool, msg._id
    #else: TODO

# add event listeners for msg recv
window.addEventListener 'message', (event) ->
  _on_msg event.data
document.addEventListener 'message', (event) ->
  _on_msg event.data


with_callback = (msg) ->
  new Promise (resolve, reject) ->
    _max_id += 1
    msg._id = _max_id

    callback = (r) ->
      # check error
      if r.error
        reject new Error(r.payload)
        return
      # OK
      resolve r.payload
    _callback_pool[msg._id] = callback
    send msg

# send with window.postMessage
send = (msg) ->
  window.postMessage JSON.stringify(msg)


set_main = (main) ->
  _etc.main = main

module.exports = {
  send

  with_callback  # async

  set_main
}
