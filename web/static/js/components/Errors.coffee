React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Errors = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onDissmissErrors: ->
    Actions.dissmissErrors()

  render: ->
    if @state.errors.popup.length > 0
      <div className="session-form-container row">
        <ul>
          { for error in @state.errors.popup
            <li>
              { error }
            </li>
          }
        </ul>
        <input type="button" value="X" onClick={ @onDissmissErrors }/>
      </div>
    else
      <div/>

module.exports = Errors
