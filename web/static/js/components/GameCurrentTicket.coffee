React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameCurrentTicket = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="tickets-list full-width">
      <tbody>
        { if @state.voting.currentTicketIndex != null
            <tr>
              <td>
                <table className="full-width">
                  <tr>
                    <td className="index-column">
                      { @state.voting.currentTicketIndex + 1 }
                    </td>
                    <td className="name-column">
                      { @state.game.tickets[@state.voting.currentTicketIndex].name }
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
        }
      </tbody>
    </table>

module.exports = GameCurrentTicket

