StateMixin =
  actions:
    vote: {}
    startVoting: {}
    finishVoting: {}

  init: ->
    @gameState = {
      name: 'none'
      currentTicketId: null
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

  onStartVoting: (id) ->
    unless id
      ticket = _.find @game.tickets, (ticket) ->
        ticket.points == null
      id = ticket.id
    if id == null
      @channel.push "state:update", { state: { current_ticket_id: null, name: 'none', votes: {} } }
    else
      @channel.push "state:update", { state: { current_ticket_id: id, name: 'voting', votes: {} } }
    @emit()

  onFinishVoting: ->
    @channel.push "state:update", { state: { name: 'finished' } }


module.exports = StateMixin
