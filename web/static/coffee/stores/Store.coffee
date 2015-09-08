Reflux     = require 'reflux'
_          = require 'lodash'
{ Router } = require 'react-router'
{ Socket } = require 'phoenix'
UserMixin  = require './UserMixin'
GameMixin  = require './GameMixin'
AuthMixin  = require './AuthMixin'
DeckMixin  = require './DeckMixin'
TicketMixin  = require './TicketMixin'
ErrorMixin  = require './ErrorMixin'
StateMixin = require './StateMixin'

Actions = Reflux.createActions _.merge
  connect: {}
  join: {}
  setCurrentGame: {}
  UserMixin.actions
  GameMixin.actions
  TicketMixin.actions
  ErrorMixin.actions
  StateMixin.actions

Store = Reflux.createStore
  mixins: [
    UserMixin
    GameMixin
    AuthMixin
    DeckMixin
    TicketMixin
    ErrorMixin
    StateMixin
  ]

  listenables: [ Actions ]

  init: ->
    @currentGame = null
    @socket = new Socket("/ws")
    @socket.onOpen (ev)  =>
      @errors.socket = null
      @emit()
    @socket.onError (ev) =>
      @errors.socket = 'Server connection error'
      @emit()

  getInitialState: ->
    @getState()

  getState: ->
    user: @user
    game: @game
    decks: @decks
    currentGame: @currentGame
    newTicket: @newTicket
    errors: @errors
    gameState: @gameState

  emit: ->
    @trigger @getState()

  onJoin: (channel, gameId) ->
    if @channel
      return if @channel.topic == channel
      @channel.leave()
      @channel = null

    @channel = @socket.channel(channel, {game_id: gameId})
    @channel.join()
    event() for event in @channelEvents

  onSetCurrentGame: (id) ->
    @currentGame = id
    @emit()

module.exports = Store
module.exports.Actions = Actions
