React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

ErrorStore = require '../stores/ErrorStore'
ErrorActions = ErrorStore.Actions

GameName = React.createClass
  mixins: [
    Reflux.connect(Store)
    Reflux.connect(ErrorStore)
  ]

  onChangeGameName: (e) ->
    Actions.changeGameName(e.target.value)

  render: ->
    <div className="form-group row">
      <label className="col-xs-12 start-xs">
        <span className="simple-row">Session Title:</span>
        <input className="simple-row full-width"
          type="text"
          placeholder="Enter Session Title"
          value={ @state.game.name }
          onChange={ @onChangeGameName }
        />
        {if @state.errors.gameName
          <span>{@state.errors.gameName}</span>
        }
      </label>
    </div>

module.exports = GameName
