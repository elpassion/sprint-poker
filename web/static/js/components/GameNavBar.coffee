React = require 'react'
Reflux = require 'reflux'
smallLogo = require '../../assets/images/logo_small.png'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions


GameNavBar = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  selectAllInput: (e) ->
    e.target.setSelectionRange(0, e.target.value.length)

  render: ->
    <nav className="lobby-navbar row center-xs middle-xs">
      <div className="container">
        <div className="simple-row middle-xs">
          <img className="logo" src={smallLogo} alt="Planning Poker"/>
          <div className="separator"></div>
          <div className="project-name">
            <span className="project">SESSION NAME:</span>
            <span className="name">{@state.game.name}</span>
          </div>
          <div className="invite simple-row middle-xs">
            <span className="invite-text">INVITE PEOPLE:</span>
            <div className="invite-link simple-row">
              <input onClick={@selectAllInput} value={document.URL} disabled/>
            </div>
          </div>
        </div>
      </div>
    </nav>

module.exports = GameNavBar

