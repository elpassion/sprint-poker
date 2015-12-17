React = require 'react'
Reflux = require 'reflux'
classNames = require 'classnames'

Store = require '../stores/Store'
Actions = Store.Actions

GameTickets = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="table">
      <caption className="table-caption">
        <span>
          Tickets list&nbsp;
        </span>
        <span className="counter">
          ({ Object.keys(@state.game.tickets).length } total)
        </span>
      </caption>
      <tbody>
        { for ticketId, ticket of @state.game.tickets
          <tr key={ ticket.id } className={ classNames({ 'selected': @state.gameState.currentTicketId == ticket.id }) }>
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
