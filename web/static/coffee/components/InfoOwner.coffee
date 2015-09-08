React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

_ = require 'lodash'


Info = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  info: ->
    if Object.keys(@state.game.tickets).length == 0
      "Please add some tickets to the tickets list."
    else if @state.gameState.name == 'none'
      "Start voting."
    else if @state.gameState.name == 'voting'
      if Object.keys(@state.gameState.votes).length == @state.game.users.length
        "All votes collected. You can review all points."
      else
        "Vote and wait for other votes."
    else if @state.gameState.name == 'review'
      "Please select final estimation or repeat voting."

  render: ->
    if @info()
      <div className="alert alert-warning">
        { @info() }
      </div>

module.exports = Info
