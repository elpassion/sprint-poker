GameMixin =
  actions:
    changeGameName: {}
    changeGameDeckId: {}
    createGame: {}

  init: ->
    @game = {
      deck_id: 1
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "game", (game) =>
        @game = game["game"]
        @createGameCallback(@game['id'])
        @createGameCallback = nil

  onChangeGameName: (name) ->
    @game.name = name
    @emit()

  onCreateGame: (callback) ->
    @createGameCallback = callback
    @channel.push('create_game', @game)

  onChangeGameDeckId: (deck_id) ->
    @game.deck_id = deck_id
    @emit()

module.exports = GameMixin

