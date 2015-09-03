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
          name="game_name"
          placeholder="Enter Session Title"
          value={ @state.game.name }
          onChange={ @onChangeGameName }
          onKeyDown={ @onSubmitGameName }
          onBlur={ @onBlurGameName }
          disabled={ @props.disabled }
        />
        {if @state.errors.game.name
          <span>{ @state.errors.game.name }</span>
        }
      </label>
    </div>

module.exports = GameName
