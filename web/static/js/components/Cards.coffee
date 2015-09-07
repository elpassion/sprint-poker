React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

Errors = React.createClass
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
          className={"card #{if @state.gameState.votes[@state.user.id] == card then "selected" } #{if @props.disabled then "disabled"}"}
          onClick={ @onCardChange }
        >
          { card }
        </div>
      }
    </div>

module.exports = Errors

