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
    @userPoints = val
    @channel.push "voting_voted", {}
    @emit()

  onStartVoting: ->
    idx = _.findIndex @game.tickets, (ticket) ->
      ticket.points == null
    @channel.push "update_state", { state: { current_ticket_index: idx, name: 'voting' } }
    @emit()

  onFinishVoting: ->
    @channel.push "voting_finish", {}


module.exports = StateMixin
