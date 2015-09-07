React   = require 'react'
Reflux  = require 'reflux'
_       = require 'lodash'
Logo    = require '../../assets/images/logo_beta.png'
{ Navigation } = require 'react-router'

GameName = require './GameName'
UserName = require './UserName'
GameDeck = require './GameDeck'
Errors = require './Errors'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

NewGame = React.createClass
  mixins: [
    Reflux.connect(Store)
    Navigation
  ]

  onCreateGame: (e) ->
    Actions.submitUserName()
    Actions.validateGameName()
    Actions.validateUserName()

    if _.isEmpty(@state.errors.user) && _.isEmpty(@state.errors.game)
      Actions.createGame (id) =>
        Actions.setCurrentGame(id)
        @transitionTo "/games/#{id}"

    e.preventDefault()

  componentDidMount: ->
    Actions.join('lobby')

  render: ->
    <div className="container">
      <div className="row col-xs-12 col-md-5 center-block">
        <div className="logo text-center">
          <img src={Logo}/>
        </div>
        <Errors/>
        <form className="form" onSubmit={ @onCreateGame }>
          <p className="text-center">
            Use online Planning Poker to easy estimate and plan tickets with your team. Your room will only be seen by those you invite.
          </p>
          <GameName/>
          <GameDeck/>
          <UserName/>
          <button className="btn btn-big-red" type="submit">Start Session</button>
        </form>
      </div>
    </div>

module.exports = NewGame
