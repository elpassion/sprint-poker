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
          { @state.gameState.currentTicketId + 1 }
        </span>
        {
          ticket = _.find @state.game.tickets, (ticket) =>
            ticket.id == @state.gameState.currentTicketId
          ticket.name
        }
        <span className="counter">
          &nbsp;({ @state.gameState.currentTicketId + 1 }/{ @state.game.tickets.length })
        </span>
      </caption>
    else
      <div/>

module.exports = GameCurrentTicket

