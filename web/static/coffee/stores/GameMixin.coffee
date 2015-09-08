GameMixin =
  actions:
    changeGameName: {}
    changeGameDeckId: {}
    createGame: {}
    validateGameName: { sync: true }

  init: ->
    @game = {
      users: []
      tickets: []
      owner: {}
      deck: {}
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
    @channel.push('game:create', @game)

  onChangeGameDeckId: (deck_id) ->
    @game.deck.id = deck_id
    @emit()

  onValidateGameName: ->
    @errors.game = {}

    @game.name = _.trim(@game.name)

    @errors.game.name = "Session Title can`t be blank" if @game.name == ''
    @errors.game.name = 'Session Title is too long' if @game.name.length > 100

    @emit()


module.exports = GameMixin

