React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/Store'
Actions = Store.Actions

GameDeck = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onChangeGameDeck: (e) ->
    Actions.changeGameDeckId(e.target.value)

  componentDidUpdate: ->
    if @state.game.deck.id == undefined && @state.decks.length != 0
      @state.game.deck.id = @state.decks[0].id

  render: ->
    <div className="form-group">
      <label htmlFor="game_deck">Session Deck:</label>
      <select
        className="form-control"
        id="game_deck"
        value={ @state.game.deck.id }
        onChange={ @onChangeGameDeck }
        disabled={ @props.disabled }
      >
        {
          for option in @state.decks
            <option
              value={ option.id }
              key={ option.id }>

              { option.name } ({ _.take(option.cards,5).join(', ') }
              { if option.cards.length > 5
                ', ...'
              }
              )
            </option>
        }
      </select>
    </div>

module.exports = GameDeck


