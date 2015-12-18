React = require 'react'
Reflux = require 'reflux'
smallLogo = require '../../assets/images/logo_small@2x.png'

Store = require '../stores/Store'
Actions = Store.Actions


GameNavBar = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  selectAllInput: (e) ->
    e.target.setSelectionRange(0, e.target.value.length)

  render: ->
    <header className="lobby-header">
      <div className="lobby-header-container container">
        <div className="lobby-header-left">
          <img className="small-logo" src={smallLogo}/>
          <span className="lobby-header-label">SESSION NAME:</span>
          <span className="lobby-header-session">{@state.game.name}</span>
        </div>
        <div className="lobby-header-right">
          <span className="lobby-header-label">INVITE PEOPLE:</span>
          <input id="game_url" className="form-control" onClick={@selectAllInput} value={document.URL} readOnly />
        </div>
      </div>
    </header>

module.exports = GameNavBar

