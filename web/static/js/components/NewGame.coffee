React   = require 'react'
Reflux  = require 'reflux'
_       = require 'lodash'
Logo    = require '../../assets/images/logo.png'
If      = require './If'
{ Navigation } = require 'react-router'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

NewGame = React.createClass
  mixins: [
    Reflux.connect(Store)
    Navigation
  ]

  onChangeGameName: (e) ->
    Actions.changeGameName(e.target.value)

  onChangeUserName: (e) ->
    Actions.changeUserName(e.target.value)

  onSubmitUserName: (e) ->
    if e.which == 13
      Actions.submitUserName()

  onBlurUserName: ->
    Actions.submitUserName()

  onCreateGame: (e) ->
    gameName = _.trim(@state.game.name)
    userName = _.trim(@state.user.name)

    @setState
      errors:
        gameName: (gameName == '')
        userName: (userName == '')

    if gameName != '' && userName != ''
      Actions.createGame (id) =>
        @transitionTo "/games/#{id}"

    e.preventDefault()

  componentDidMount: ->
    Actions.join('lobby')

  getInitialState: ->
    errors:
      gameName: false
      userName: false

  render: ->
    <div className="sessions col-xs-12 col-md-6">
      <img className="logo" src={Logo}></img>
      <div className="session-form-container row">
        <div className="header-text col-xs-12">
          Use online Planning Poker to easy estimate and plan tickets with your team. Your room will only be seen by those you invite.
        </div>
        <form className="session-form col-xs-12" onSubmit={ @onCreateGame }>
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
              <span className="simple-row">Session Title:</span>
              <input className="simple-row full-width"
                type="text"
                placeholder="Enter Session Title"
                value={ @state.game.name }
                onChange={ @onChangeGameName }
              />
              <If condition={@state.errors.gameName}>
                <span>Session Title can't be blank</span>
              </If>
            </label>
          </div>
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
              <span className="simple-row">Session Deck:</span>
                <select className="simple-row full-width" value="1">
                  {
                    for option in @state.decks
                      <option value={option.id} key={option.id}>{option.name} ({_.take(option.cards,4).join(', ')})</option>
                  }
                </select>
            </label>
          </div>
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
              <span className="simple-row">Your Nickname:</span>
              <input className="simple-row full-width"
                type="text"
                placeholder="Enter Your Nickname"
                value={ @state.user.name }
                onChange={ @onChangeUserName }
                onKeyDown={ @onSubmitUserName }
                onBlur={ @onBlurUserName }
              />
              <If condition={@state.errors.userName}>
                <span>Your Nickname can't be blank</span>
              </If>
            </label>
          </div>
          <button className="button full-width" type="submit">Start Session</button>
        </form>
      </div>
    </div>

module.exports = NewGame
