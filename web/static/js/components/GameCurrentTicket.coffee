React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameCurrentTicket = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    idx = _.findIndex @state.game.tickets, (ticket) =>
      ticket.id == @state.gameState.currentTicketId
    if @state.gameState.name != 'none'
      <caption className="current-ticket">
        <span className="id">
          { idx + 1 }
        </span>
        {
          @state.game.tickets[idx].name
        }
        <span className="counter">
          &nbsp;({ idx + 1 }/{ @state.game.tickets.length })
        </span>
      </caption>
    else
      <div/>

module.exports = GameCurrentTicket

