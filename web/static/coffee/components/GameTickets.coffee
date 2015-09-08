React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
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
          ({ Object.keys(@state.game.tickets).length } total)
        </span>
      </caption>
      <tbody>
        { for ticketId, ticket of @state.game.tickets
          <tr key={ ticket.id } className={ if @state.gameState.currentTicketId == ticket.id then "selected"}>
            <th>
              { Object.keys(@state.game.tickets).indexOf(ticketId) + 1 }
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
