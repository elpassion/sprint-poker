React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

GameCurrentTicket = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    ticketIdx = Object.keys(@state.game.tickets).indexOf(String(@state.gameState.currentTicketId)) + 1
    if @state.gameState.name != 'none'
      <caption className="current-ticket">
        <span className="id">{ ticketIdx }</span>
        { @state.game.tickets[@state.gameState.currentTicketId].name }
        <span className="counter">
          &nbsp;({ ticketIdx }/{ Object.keys(@state.game.tickets).length })
        </span>
      </caption>
    else
      <div/>

module.exports = GameCurrentTicket

