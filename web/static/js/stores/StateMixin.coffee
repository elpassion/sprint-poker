StateMixin =
  actions:
    vote: {}
    startVoting: {}
    finishVoting: {}

  init: ->
    @gameState = {
      name: 'none'
      currentTicketIndex: null
      votes: {}
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "state", (state) =>
        @gameState = state.state
        @emit()

  onVote: (val) ->
    @gameState.votes[@user.id] = val
    @channel.push "state:update:vote", { vote: { points: val } }
    @emit()

  onStartVoting: (index) ->
    unless index
      index = _.findIndex @game.tickets, (ticket) ->
        ticket.points == null
    if index == -1
      @channel.push "state:update", { state: { current_ticket_index: null, name: 'none', votes: {} } }
    else
      @channel.push "state:update", { state: { current_ticket_index: index, name: 'voting', votes: {} } }
    @emit()

  onFinishVoting: ->
    @channel.push "state:update", { state: { name: 'finished' } }


module.exports = StateMixin
