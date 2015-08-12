React   = require 'react'
Reflux  = require 'reflux'
Logo    = require '../../assets/images/logo.png'
Store   = require '../stores/SocketConnectionStore'
Actions = require '../actions/SocketConnectionActions'

NewGame = React.createClass

  mixins: [Reflux.connect(Store)]

  onChangeGameTitle: (e) ->
    Actions.changeGameTitle(e.target.value)

  onChangeUserName: (e) ->
    Actions.changeUserName(e.target.value)

  onSubmitUserName: (e) ->
    if e.which == 13
      Actions.submitUserName()
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
        <form className="session-form col-xs-12">
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
                <span className="simple-row">Session Title:</span>
                <input className="simple-row full-width" value={ null } type="text" onChange={ @onChangeGameTitle }/>
            </label>
          </div>
          <div className="form-group row">
            <label className="col-xs-12 start-xs">
                <span className="simple-row">Your Nickname:</span>
                <input className="simple-row full-width" value={ @state.user.name } type="text" onChange={ @onChangeUserName } onKeyDown={ @onSubmitUserName }/>
            </label>
          </div>
          <button className="button full-width" type="submit">Start Session</button>
        </form>
      </div>
    </div>

module.exports = NewGame
