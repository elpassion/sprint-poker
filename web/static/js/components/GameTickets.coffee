React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameTickets = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="tickets-list full-width">
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
          <tr key={ ticket.id }>
            <td>
              <table className="full-width">
                <tr className={ @state.voting.current_ticket_index == i ? "selected" }>
                  <td className="index-column">
                    { i + 1 }
                  </td>
                  <td className="name-column">
                    { ticket.name }
                  </td>
                  <td className="estimation-column">
                    { ticket.points }
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        }
      </tbody>
    </table>

module.exports = GameTickets
