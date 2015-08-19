GameMixin =
  actions:
    changeGameName: {}
    changeGameDeckId: {}
    createGame: {}
    validateGameName: { sync: true }

  init: ->
    @game = {
      errors: {}
      deck_id: 1
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "game", (game) =>
        @game = _.merge(@game, game.game)
        @createGameCallback(@game.id)
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

  onValidateGameName: ->
    @game.errors = {}

    @game.name = _.trim(@game.name)

    @game.errors.name = 'Session Title Cant be blank' if @game.name == ''
    @game.errors.name = 'Session Title is too long' if @game.name.length > 254

    @emit()

module.exports = GameMixin

