React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

Errors = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onDissmissErrors: ->
    Actions.dissmissErrors()

  render: ->
    <div>
      { if @state.errors.socket != null && @state.errors.socket != undefined
        <div className="alert alert-danger">
          { @state.errors.socket}
        </div>
      }
      { if @state.errors.popup.length > 0
        <div className="alert alert-danger alert-dismissible">
          <button type="button" className="close" onClick={ @onDissmissErrors }>
            <span aria-hidden="true">&times;</span>
          </button>
          <ul>
            { for error, i in @state.errors.popup
              <li key={ i }>
                { error }
              </li>
            }
          </ul>
        </div>
      }
    </div>

module.exports = Errors
