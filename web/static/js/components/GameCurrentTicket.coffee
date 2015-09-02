React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameCurrentTicket = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    if @state.gameState.name != 'none'
      <caption className="current-ticket">
        <span className="id">
          { @state.gameState.currentTicketIndex + 1 }
        </span>
        { @state.game.tickets[@state.gameState.currentTicketIndex].name }
        <span className="counter">
          &nbsp;({ @state.gameState.currentTicketIndex + 1 }/{ @state.game.tickets.length })
        </span>
      </caption>
    else
      <div/>

module.exports = GameCurrentTicket

