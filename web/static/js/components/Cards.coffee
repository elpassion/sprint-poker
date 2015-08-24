React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Errors = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onCardChange: (e) ->
    Actions.vote(e.target.value)

  render: ->
    <div className="full-width">
      <form>
        { for card in @state.game.deck.cards
          <label key={ card }>
            <input
              type="radio"
              name="cards"
              value={ card }
              onChange={ @onCardChange }
              selected={ @state.voting.points == card }
              disabled={ @state.voting.currentTicketIndex == null }
            />
            &nbsp;
            <span>{ card }</span>
            &nbsp;
          </label>
        }
      </form>
    </div>

module.exports = Errors

