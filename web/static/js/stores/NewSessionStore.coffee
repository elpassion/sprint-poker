Reflux = require 'reflux'
Actions = require '../actions/NewSessionActions'

NewSessionStore = Reflux.createStore
  listenables: [ Actions ]

  init: ->
    @title = 'Default Title'
    @userName = 'Default Nick'

  getInitialState: ->
    @getState()

  getState: ->
    title: @title
    userName: @userName

  emit: ->
    @trigger @getState

  onChangeTitle: (@title) ->
    @emit()

  onChangeUserName: (@userName) ->
    @emit()

module.exports = NewSessionStore
