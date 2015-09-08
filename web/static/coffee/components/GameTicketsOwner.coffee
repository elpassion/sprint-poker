React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

GameNewTicketOwner = require './GameNewTicketOwner'

GameTickets = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onDeleteTicket: (e) ->
    Actions.deleteTicket(e.target.dataset.id)
    e.preventDefault()

  onChangeTicketName: (e) ->
    Actions.changeTicketName(e.target.dataset.id, e.target.value)

  onSubmitTicketName: (e) ->
    if e.which == 13
      Actions.submitTicketName(e.target.dataset.id, e.target.value)
      e.preventDefault()

  onBlurTicketName: (e) ->
    Actions.submitTicketName(e.target.dataset.id, e.target.value)

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
          <tr key={ ticket.id } className={ if @state.gameState.currentTicketId == ticket.id then "selected" }>
            <th>
              { Object.keys(@state.game.tickets).indexOf(ticketId) + 1 }
            </th>
            <td>
              <input
                className="input-gray"
                type="text"
                data-id={ ticket.id }
                value={ ticket.name }
                onChange={ @onChangeTicketName }
                onKeyDown={ @onSubmitTicketName }
                onBlur={ @onBlurTicketName }
              />
            </td>
            <td className="points text-center">
              { ticket.points }
            </td>
            <td className="buttons">
              <button className="btn btn-gray" data-id={ticket.id} onClick={ @onDeleteTicket } disabled={ if @state.gameState.currentTicketId == ticket.id then true }>Delete</button>
            </td>
          </tr>
        }
        <GameNewTicketOwner/>
        </tbody>
      </table>

module.exports = GameTickets
