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
      <table className="table table-striped">
        <tbody>
          <tr>
            <th>
              { @state.gameState.currentTicketIndex + 1 }
            </th>
            <td>
              { @state.game.tickets[@state.gameState.currentTicketIndex].name }
            </td>
          </tr>
        </tbody>
      </table>
    else
      <div/>

module.exports = GameCurrentTicket

