React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Errors = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <form>
      { for card in @state.game.deck.cards
        <label>
          <input type="radio" name="cards" value={card}/>
          &nbsp;
          <span>{card}</span>
          &nbsp;
        </label>
      }
    </form>

module.exports = Errors

