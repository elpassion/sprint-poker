React = require 'react'
Reflux = require 'reflux'
classNames = require 'classnames'

Store = require '../stores/Store'
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

  onNewTicketKeyDown: (e) ->
    if e.which == 13
      Actions.submitNewTicket()
      e.preventDefault()

  render: ->
    ticketError = @state.newTicket.errors.empty || @state.newTicket.errors.tooLong

    <tr>
      <th>
        -
      </th>
      <td>
        <div className={ classNames('table-input', { 'has-error': ticketError }) }>
          <input
            className="form-control"
            id="new_ticket"
            type="text"
            placeholder="Enter your ticket name here..."
            value={ @state.newTicket.name }
            onChange={ @onNewTicketChange }
            onKeyDown={ @onNewTicketKeyDown }
          />
          {if ticketError
            <span className="error">{ticketError}</span>
          }
        </div>
      </td>
      <td></td>
      <td className="buttons">
        <button className="btn btn-gray" onClick={ @onNewTicketSubmit }>Create</button>
      </td>
    </tr>

module.exports = GameNewTicketOwner
