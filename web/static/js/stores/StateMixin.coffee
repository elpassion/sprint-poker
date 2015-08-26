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
        console.log(state)
        @gameState = state.state
        @emit()

  onVote: (val) ->
    @gameState.votes[@user.id] = val
    @channel.push "update_state_vote", { vote: { points: val } }
    @emit()

  onStartVoting: (idx) ->
    unless idx
      idx = _.findIndex @game.tickets, (ticket) ->
        ticket.points == null
    if idx == -1
      @channel.push "update_state", { state: { current_ticket_index: null, name: 'none', votes: {} } }
    else
      @channel.push "update_state", { state: { current_ticket_index: idx, name: 'voting', votes: {} } }
    @emit()

  onFinishVoting: ->
    @channel.push "update_state", { state: { name: 'finished' } }


module.exports = StateMixin
