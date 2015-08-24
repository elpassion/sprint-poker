VotingMixin =
  actions:
    vote: {}
    startVoting: {}

  init: ->
    @voting = {
      currentTicketIndex: null
      points: null
      votes: {}
    }

    @channelEvents ||= []
    @channelEvents.push =>
      @channel.on "voting_ticket_index", (idx) =>
        @voting.currentTicketIndex = idx.index
        @emit()


  onVote: (val) ->
    @voting.points = val
    @emit()

  onStartVoting: ->
    idx = _.findIndex @game.tickets, (ticket) ->
      ticket.points == null
    @channel.push "voting_ticket_index", { index: idx }
    @emit()

module.exports = VotingMixin
