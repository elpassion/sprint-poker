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

  onVote: (val) ->
    @voting.points = val
    @emit()

  onStartVoting: ->
    @voting.currentTicketIndex = _.findIndex @game.tickets, (ticket) ->
      ticket.points == null
    @emit()

module.exports = VotingMixin
