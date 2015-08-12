GameMixin =
  actions:
    changeGameName: {}
    createGame: {}

  init: ->
    @game = {}

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "game", (@game) =>
        @createGameCallback(@game['id'])
        @createGameCallback = nil

  onChangeGameName: (name) ->
    @game.name = name
    @emit()

  onCreateGame: (callback) ->
    @createGameCallback = callback
    @channel.push('create_game', @game)


module.exports = GameMixin

