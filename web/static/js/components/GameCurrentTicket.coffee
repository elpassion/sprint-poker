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
        { if @state.gameState.name != 'none'
            <tr>
              <td>
                <table className="full-width">
                  <tr>
                    <td className="index-column">
                      { @state.gameState.current_ticket_index + 1 }
                    </td>
                    <td className="name-column">
                      { @state.game.tickets[@state.gameState.current_ticket_index].name }
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
        }
      </tbody>
    </table>

module.exports = GameCurrentTicket

