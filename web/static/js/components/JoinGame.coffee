React = require 'react'
Reflux = require 'reflux'
Logo = require '../../assets/images/logo.png'

UserName = require './UserName'
GameName = require './GameName'
GameDeck = require './GameDeck'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

JoinGame = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  componentDidMount: ->
    Actions.join('lobby', @props.id)

  onJoinGame: (e) ->
    Actions.validateUserName()
    if _.isEmpty(@state.errors.user)
      Actions.setCurrentGame(@props.id)

    e.preventDefault()

  render: ->
    <div className="sessions col-xs-12 col-md-6">
      <img className="logo" src={Logo}></img>
      <div className="session-form-container row">
        <div className="header-text col-xs-12">
          Join session ?
        </div>
        <form className="session-form col-xs-12" onSubmit={ @onJoinGame }>
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
              <span className="simple-row">Session Owner:</span>
              <input className="simple-row full-width"
                name="game_owner"
                type="text"
                placeholder="Session Owner"
                value={ @state.game.owner.name }
                disabled
              />
            </label>
          </div>
          <GameName disabled={ true }/>
          <GameDeck disabled={ true }/>
          <UserName/>
          <button className="button full-width" type="submit">Join Session</button>
        </form>
      </div>
    </div>

module.exports = JoinGame
