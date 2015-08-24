VotingMixin =
  actions:
    vote: {}

  init: ->
    @voting = {
      currentTicket: null
      points: null
      votes: {}
    }

  onVote: (val) ->
    @voting.points = val
    @emit()

module.exports = VotingMixin
