StateMixin =
  actions:
    vote: {}
    startVoting: {}
    finishVoting: {}

  init: ->
    @gameState = {
      name: 'none'
      current_ticket_index: null
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

  onStartVoting: (idx) ->
    unless idx
      idx = _.findIndex @game.tickets, (ticket) ->
        ticket.points == null
    if idx == -1
      @channel.push "state:update", { state: { current_ticket_index: null, name: 'none', votes: {} } }
    else
      @channel.push "state:update", { state: { current_ticket_index: idx, name: 'voting', votes: {} } }
    @emit()

  onFinishVoting: ->
    @channel.push "state:update", { state: { name: 'finished' } }


module.exports = StateMixin
