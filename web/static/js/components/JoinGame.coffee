React = require 'react'
Reflux = require 'reflux'
Logo = require '../../assets/images/logo.png'

UserName = require './UserName'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

JoinGame = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  componentDidMount: ->
    Actions.join('lobby')

  onJoinGame: (e) ->
    Actions.validateUserName()
    if _.isEmpty(@state.user.errors)
      Actions.setCurrentGame(@props.id)

    e.preventDefault()

  render: ->
    <div className="sessions col-xs-12 col-md-6">
      <img className="logo" src={Logo}></img>
      <div className="session-form-container row">
        <div className="header-text col-xs-12">
          Join game ?
        </div>
        <form className="session-form col-xs-12" onSubmit={ @onJoinGame }>
          <UserName/>
          <button className="button full-width" type="submit">Join Session</button>
        </form>
      </div>
    </div>

module.exports = JoinGame
