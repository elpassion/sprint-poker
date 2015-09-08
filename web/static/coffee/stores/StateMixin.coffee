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
        @selectFinalEstimation()
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

  selectFinalEstimation: ->
    return unless @gameState.name == 'review'
    values = _.map @gameState.votes, (vote) -> vote
    uniq = _.uniq values
    if uniq.length == 1
      @game.tickets[@gameState.currentTicketId].points = uniq[0]

module.exports = StateMixin
