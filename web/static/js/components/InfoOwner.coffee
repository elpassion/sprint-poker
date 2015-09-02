React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

_ = require 'lodash'


Info = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  addTicketsInfo: ->
    if @state.game.tickets.length == 0
      "Please add some tickets to the tickets list."

  votingInfo: ->
    if @state.gameState.name == 'voting'
      if Object.keys(@state.gameState.votes).length == @state.game.users.length
        "All votes collected. You can review all points."
      else
        "Wait for other votes."


  finalEstimationInfo: ->
    if @state.gameState.name == 'review'
      "Please select final estimation or repeat voting."

  render: ->
    <div className="alert alert-warning">
      { @addTicketsInfo() }
      { @votingInfo() }
      { @finalEstimationInfo() }
    </div>

module.exports = Info
