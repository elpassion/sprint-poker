React = require 'react'
Reflux = require 'reflux'
Logo = require '../../assets/images/logo@2x.png'

UserName = require './UserName'
GameName = require './GameName'
GameDeck = require './GameDeck'
Errors = require './Errors'

Store = require '../stores/Store'
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
    <div className="container">
      <div className="row col-xs-12 col-md-5 center-block">
        <div className="text-center">
          <img className="logo" src={Logo}/>
        </div>
        <Errors/>
        <form className="form" onSubmit={ @onJoinGame }>
          <p className="text-center">
            Join session ?
          </p>
          <div className="form-group">
            <label htmlFor="game_owner">Session Owner:</label>
            <input className="form-control"
              id="game_owner"
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
    </div>

module.exports = JoinGame
