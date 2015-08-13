React   = require 'react'
Reflux  = require 'reflux'
_       = require 'lodash'
Logo    = require '../../assets/images/logo.png'
{ Navigation } = require 'react-router'

GameName = require './GameName'
UserName = require './UserName'
GameDeck = require './GameDeck'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

ErrorStore = require '../stores/ErrorStore'
ErrorActions = ErrorStore.Actions

NewGame = React.createClass
  mixins: [
    Reflux.connect(Store)
    Reflux.connect(ErrorStore)
    Navigation
  ]

  onCreateGame: (e) ->
    gameName = _.trim(@state.game.name)
    userName = _.trim(@state.user.name)

    ErrorActions.setGameNameError(gameName == '', 'Session Title cant be blank')
    ErrorActions.setUserNameError(userName == '', 'Your Nickname Cant be blank')

    if gameName != '' && userName != ''
      Actions.createGame (id) =>
        @transitionTo "/games/#{id}"

    e.preventDefault()

  componentDidMount: ->
    Actions.join('lobby')

  render: ->
    <div className="sessions col-xs-12 col-md-6">
      <img className="logo" src={Logo}></img>
      <div className="session-form-container row">
        <div className="header-text col-xs-12">
          Use online Planning Poker to easy estimate and plan tickets with your team. Your room will only be seen by those you invite.
        </div>
        <form className="session-form col-xs-12" onSubmit={ @onCreateGame }>
          <GameName/>
          <GameDeck/>
          <UserName/>
          <button className="button full-width" type="submit">Start Session</button>
        </form>
      </div>
    </div>

module.exports = NewGame
