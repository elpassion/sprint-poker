React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/Store'
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
    <div className={ "form-group #{if @state.errors.game.name then "has-error"}" }>
      <label htmlFor="game_name">Session Title:</label>
      <input
        className="form-control"
        type="text"
        id="game_name"
        placeholder="Enter Session Title"
        value={ @state.game.name }
        onChange={ @onChangeGameName }
        onKeyDown={ @onSubmitGameName }
        onBlur={ @onBlurGameName }
        disabled={ @props.disabled }
      />
      {if @state.errors.game.name
        <div className="error text-right">{ @state.errors.game.name }</div>
      }
    </div>

module.exports = GameName
