React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameNewTicketOwner = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onNewTicketChange: (e) ->
    Actions.changeNewTicketName(e.target.value)

  onNewTicketSubmit: (e) ->
    Actions.submitNewTicket()
    e.preventDefault()

  render: ->
    <tr>
      <td colSpan="4">
        <form onSubmit={ @onNewTicketSubmit }>
          <table className="full-width">
            <tr>
              <td className="index-column">
                -
              </td>
              <td className="name-column" colSpan="2">
                <input
                  name="new_ticket"
                  className="full-width"
                  type="text"
                  placeholder="enter your ticket name here"
                  value={ @state.newTicket.name }
                  onChange={ @onNewTicketChange }
                />
              </td>
              <td className="delete-column">
                <input type="submit" value="CREATE"/>
              </td>
            </tr>
          </table>
        </form>
      </td>
    </tr>

module.exports = GameNewTicketOwner

