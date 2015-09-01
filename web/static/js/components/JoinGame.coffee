React = require 'react'
Reflux = require 'reflux'
Logo = require '../../assets/images/logo.png'

UserName = require './UserName'
GameName = require './GameName'
GameDeck = require './GameDeck'
Errors = require './Errors'

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
    <div className="row col-xs-12 col-md-5 center-block">
      <div className="logo text-center">
        <img src={Logo}/>
      </div>
      <Errors/>
      <form className="form" onSubmit={ @onJoinGame }>
        <p className="text-center">
          Join session ?
        </p>
        <div className="form-group">
          <label for="game_owner">Session Owner:</label>
          <input className="form-control"
            name="game_owner"
            type="text"
            placeholder="Session Owner"
            value={ @state.game.owner.name }
            disabled
          />
        </div>
        <GameName disabled={ true }/>
        <GameDeck disabled={ true }/>
        <UserName/>
        <button className="btn btn-big-red" type="submit">Join Session</button>
      </form>
    </div>

module.exports = JoinGame
