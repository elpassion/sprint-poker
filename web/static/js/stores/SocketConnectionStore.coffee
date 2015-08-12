Reflux     = require 'reflux'
_          = require 'lodash'
{ Router } = require 'react-router'
{ Socket } = require 'phoenix'
UserMixin  = require './UserMixin'
GameMixin  = require './GameMixin'
AuthMixin  = require './AuthMixin'

Actions = Reflux.createActions _.merge
  connect: {}
  join: {}
  UserMixin.actions
  GameMixin.actions

Store = Reflux.createStore
  mixins: [
    UserMixin
    GameMixin
    AuthMixin
  ]

  listenables: [ Actions ]

  init: ->
    @socket = new Socket("/ws")

  getInitialState: ->
    @getState()

  getState: ->
    user: @user
    game: @game

  emit: ->
    @trigger @getState()

  onJoin: (channel) ->
    @channel = @socket.channel(channel)
    @channel.join()
    @channel.on "scales", (@scales) => @emit()

    event() for event in @channelEvents

module.exports = Store
module.exports.Actions = Actions
