Reflux = require 'reflux'

Actions = Reflux.createActions
  setGameNameError: {}
  setUserNameError: {}

Store = Reflux.createStore
  listenables: [ Actions ]

  init: ->
    @errors =
      gameName: false
      userName: false

  getInitialState: ->
    @getState()

  getState: ->
    errors: @errors

  emit: ->
    console.log @getState()
    @trigger @getState()

  onSetGameNameError: (condition, message) ->
    @errors['gameName'] = if condition
                            message
                          else
                            false
    @emit()

  onSetUserNameError: (condition, message) ->
    @errors['userName'] = if condition
                            message
                          else
                            false
    @emit()

module.exports = Store
module.exports.Actions = Actions

