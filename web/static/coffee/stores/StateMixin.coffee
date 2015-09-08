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
      if ticket
        id = ticket.id

    if id
      @channel.push "state:update", { state: { current_ticket_id: id, name: 'voting', votes: {} } }
    else
      @channel.push "state:update", { state: { current_ticket_id: null, name: 'none', votes: {} } }
    @emit()

  onFinishVoting: ->
    @channel.push "state:update", { state: { name: 'review' } }


module.exports = StateMixin
