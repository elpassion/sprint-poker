GameMixin =
  actions:
    changeGameName: {}
    changeGameDeckId: {}
    createGame: {}
    validateGameName: { sync: true }

  init: ->
    @game = {
      errors: {}
      users: []
      tickets: []
      owner: {}
      deck: {
        id: 1
      }
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "game", (game) =>
        @game = game.game
        if @createGameCallback
          @createGameCallback(@game.id)
          @createGameCallback = null
        @emit()

  onChangeGameName: (name) ->
    @game.name = name
    @emit()

  onCreateGame: (callback) ->
    @createGameCallback = callback
    @channel.push('create_game', @game)

  onChangeGameDeckId: (deck_id) ->
    @game.deck.id = deck_id
    @emit()

  onValidateGameName: ->
    @game.errors = {}

    @game.name = _.trim(@game.name)

    @game.errors.name = 'Session Title Cant be blank' if @game.name == ''
    @game.errors.name = 'Session Title is too long' if @game.name.length > 100

    @emit()


module.exports = GameMixin

