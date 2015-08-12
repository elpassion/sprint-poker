Reflux     = require 'reflux'
Actions    = require '../actions/SocketConnectionActions'
{ Socket } = require 'phoenix'

SocketConnection = Reflux.createStore
  listenables: [Actions]

  init: ->
    @socket = new Socket("/ws")
    @auth_token = { auth_token: localStorage.getItem('auth_token') }
    @user = {}
    @game = {}

  getInitialState: ->
    @getState()

  getState: ->
    user: @user
    game: @game

  emit: ->
    @trigger @getState()

  onConnect: ->
    @socket.connect(@auth_token)

  onJoin: (channel) ->
    @channel = @socket.channel(channel)
    @channel.join()

    @channel.on "user", (@user) => @emit()
    @channel.on "scales", (@scales) => @emit()
    @channel.on "game", (@game) =>
      console.log(@game)
      @emit()
    @channel.on "auth_token", (@auth_token) ->
      localStorage.setItem('auth_token', @auth_token['auth_token'])

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('update_user', @user)

  onChangeGameName: (name) ->
    @game.name = name
    @emit()

  onCreateGame: ->
    @channel.push('create_game', @game)

module.exports = SocketConnection
