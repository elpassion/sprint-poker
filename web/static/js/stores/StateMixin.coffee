StateMixin =
  actions:
    something: {}

  init: ->
    @gameState = {
      name: 'none'
      current_ticket_index: null
      votes: {}
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "state", (state) =>
        console.log(state)
        @gameState = state.state
        @emit()

module.exports = StateMixin
