DeckMixin =
  init: ->
    @decks = []

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "decks", (decks) =>
        @decks = decks["decks"]
        @emit()

module.exports = DeckMixin
