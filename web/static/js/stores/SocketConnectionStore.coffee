Reflux     = require 'reflux'
Actions    = require '../actions/SocketConnectionActions'
{ Socket } = require 'phoenix'

SocketConnection = Reflux.createStore
  listenables: [Actions]

  init: ->
    @socket = new Socket("/ws")
    @auth_token = { auth_token: localStorage.getItem('auth_token') }
    @user = {}

  getInitialState: ->
    @getState()

  getState: ->
    user: @user

  emit: ->
    @trigger @getState()

  onConnect: ->
    @socket.connect(@auth_token)
    @socket.onOpen (ev) ->
      console.log("OPEN", ev)
    @socket.onError (ev) ->
      console.log("ERROR", ev)
    @socket.onClose (ev) ->
      console.log("CLOSE", ev)

  onJoin: (channel) ->
    @channel = @socket.channel(channel)

    @channel
      .join()
      .receive "ignore", ->
        console.log("auth error")
      .receive "ok", ->
        console.log("Join #{channel} ok")

    @channel.on "user", (@user) =>
      @emit()
      console.log("user", @user)
    @channel.on "scales", (@scales) ->
      console.log("scales", @scales)
    @channel.on "game", (@game) ->
      console.log("game", @game)
    @channel.on "auth_token", (@auth_token) ->
      localStorage.setItem('auth_token', @auth_token['auth_token'])

  onChangeUserName: (name) ->
    @user.name = name
    @emit()

  onSubmitUserName: ->
    @channel.push('update_user', @user)

  onChangeGameTitle: (name) ->
    console.log(name)

module.exports = SocketConnection
