React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Info = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  startInfo: ->
    if @state.gameState.name == 'none'
      if @state.game.tickets.length < 1
        "Wait for owner to create some tickets."
      else
        "Wait for owner to start voting."

  finishVotingInfo: ->
    if @state.gameState.name == 'voting'
      if @state.gameState.votes[@state.user.id] == undefined
        "Please select your estimation."
      else if Object.keys(@state.gameState.votes).length == @state.game.users.length
        "Wait for owner finish voting."
      else
        "Wait for all to vote."

  finalVoteInfo: ->
    if @state.gameState.name == 'review'
      "Wait for owner accept the estimation."

  render: ->
    <div className="alert alert-warning">
      { @startInfo() }
      { @finishVotingInfo() }
      { @finalVoteInfo() }
    </div>

module.exports = Info
