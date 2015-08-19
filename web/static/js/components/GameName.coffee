React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameName = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onChangeGameName: (e) ->
    Actions.changeGameName(e.target.value)

  onSubmitGameName: (e) ->
    if e.which == 13
      Actions.validateGameName()

  onBlurGameName: ->
    Actions.validateGameName()

  render: ->
    <div className="form-group row">
      <label className="col-xs-12 start-xs">
        <span className="simple-row">Session Title:</span>
        <input className="simple-row full-width"
          type="text"
          placeholder="Enter Session Title"
          value={ @state.game.name }
          onChange={ @onChangeGameName }
          onKeyDown={ @onSubmitGameName }
          onBlur={ @onBlurGameName }
        />
        {if @state.game.errors.name
          <span>{ @state.game.erros.name }</span>
        }
      </label>
    </div>

module.exports = GameName
