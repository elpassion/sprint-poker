ErrorMixin =
  actions:
    setErrorCallback: {}
    dissmissErrors: {}

  init: ->
    @errors = []

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "error", (error) =>
        switch error.code
          when "GAME_ERR"
            @errors.push error.message
            @currentGame = null
            @errorCallback()
            @emit()
          else console.log(error)

  onSetErrorCallback: (fn) ->
    @errorCallback = fn

  onDissmissErrors: ->
    @errors = []
    @emit()

module.exports = ErrorMixin

