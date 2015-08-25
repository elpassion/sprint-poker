VotingMixin =
  actions:
    vote: {}
    startVoting: {}
    finishVoting: {}

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
      @channel.on "voting_voted", (voted) =>
        @voting.votes[voted.user_id] = 'voted'
        @emit()
      @channel.on "voting_finish", () =>
        @channel.push "voting_points", { points: @voting.points }
      @channel.on "voting_points", (points) =>
        @voting.votes[points.user_id] = points.points
        @emit()


  onVote: (val) ->
    @voting.points = val
    @channel.push "voting_voted", {}
    @emit()

  onStartVoting: ->
    idx = _.findIndex @game.tickets, (ticket) ->
      ticket.points == null
    @channel.push "voting_ticket_index", { index: idx }
    @emit()

  onFinishVoting: ->
    @channel.push "voting_finish", {}

module.exports = VotingMixin
