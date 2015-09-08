React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

Info = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  info: ->
    if @state.gameState.name == 'none'
      if Object.keys(@state.game.tickets).length < 1
        "Wait for owner to create some tickets."
      else
        "Wait for owner to start voting."
    else if @state.gameState.name == 'voting'
      if @state.gameState.votes[@state.user.id] == undefined
        "Please select your estimation."
      else if Object.keys(@state.gameState.votes).length == @state.game.users.length
        "Wait for owner finish voting."
      else
        "Wait for all votes."
    else if @state.gameState.name == 'review'
      "Wait for owner accept the estimation."

  render: ->
    if @info()
      <div className="alert alert-warning">
        { @info() }
      </div>

module.exports = Info
