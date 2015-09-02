React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameTickets = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="table">
      <caption>
        <span>
          Tickets list&nbsp;
        </span>
        <span className="counter">
          ({ @state.game.tickets.length } total)
        </span>
      </caption>
      <tbody>
        { for ticket, i in @state.game.tickets
          <tr key={ ticket.id } className={ if @state.gameState.currentTicketIndex == i then "selected"}>
            <th>
              { i + 1 }
            </th>
            <td>
              { ticket.name }
            </td>
            <td className="points text-center">
              { ticket.points }
            </td>
          </tr>
        }
      </tbody>
    </table>

module.exports = GameTickets
