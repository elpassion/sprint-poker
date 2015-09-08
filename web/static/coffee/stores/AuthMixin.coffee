AuthMixin =
  init: ->
    @authToken = { auth_token: localStorage.getItem('auth_token') }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "auth_token", (@authToken) =>
        localStorage.setItem('auth_token', @authToken['auth_token'])

  onConnect: ->
    @socket.connect(@authToken)

module.exports = AuthMixin
