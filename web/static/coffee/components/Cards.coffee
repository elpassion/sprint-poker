React = require 'react'
Reflux = require 'reflux'
classNames = require 'classnames'

Store = require '../stores/Store'
Actions = Store.Actions

Cards = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onCardChange: (e) ->
    unless @props.disabled
      Actions.vote(e.target.textContent)

  render: ->
    <div className="deck">
      { for card in @state.game.deck.cards
        <div
          key={ card }
          className={classNames('card', {
            'selected': @state.gameState.votes[@state.user.id] == card,
            'disabled': @props.disabled
          })}
          onClick={ @onCardChange }
        >
          { card }
        </div>
      }
    </div>

module.exports = Cards

