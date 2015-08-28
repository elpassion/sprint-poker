ErrorMixin =
  actions:
    setErrorCallback: {}
    dissmissErrors: {}

  init: ->
    @errors = {
      popup: []
      game: {}
      user: {}
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "error", (error) =>
        switch error.code
          when "GAME_ERR"
            @errors.popup.push error.message
            @currentGame = null
            @errorCallback()
            @emit()
          else console.log(error)

  onSetErrorCallback: (fn) ->
    @errorCallback = fn

  onDissmissErrors: ->
    @errors.popup = []
    @emit()

module.exports = ErrorMixin

