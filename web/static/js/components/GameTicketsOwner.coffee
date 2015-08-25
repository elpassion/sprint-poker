React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
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
              <form>
                <table className="full-width">
                  <tr className={ if @state.voting.currentTicketIndex == i then "selected"}>
                    <td className="index-column">
                      { i + 1 }
                    </td>
                    <td className="name-column">
                      <input
                        className="full-width"
                        type="text"
                        data-id={ ticket.id }
                        value={ ticket.name }
                        onChange={ @onChangeTicketName }
                        onKeyDown={ @onSubmitTicketName }
                        onBlur={ @onBlurTicketName }
                      />
                    </td>
                    <td className="estimation-column">
                      { ticket.points }
                    </td>
                    <td className="delete-column">
                      <input type="button" data-id={ticket.id} value="DELETE" onClick={ @onDeleteTicket }/>
                    </td>
                  </tr>
                </table>
              </form>
            </td>
          </tr>
        }
        <GameNewTicketOwner/>
      </tbody>
    </table>

module.exports = GameTickets
