React = require 'react'
Reflux = require 'reflux'

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
    <tr>
      <th>
        -
      </th>
      <td>
        <input
          className="input-gray"
          id="new_ticket"
          type="text"
          placeholder="enter your ticket name here"
          value={ @state.newTicket.name }
          onChange={ @onNewTicketChange }
          onKeyDown={ @onNewTicketKeyDown }
        />
      </td>
      <td></td>
      <td className="buttons">
        <button className="btn btn-gray" onClick={ @onNewTicketSubmit }>Create</button>
      </td>
    </tr>

module.exports = GameNewTicketOwner
