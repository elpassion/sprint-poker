React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

ErrorStore = require '../stores/ErrorStore'
ErrorActions = ErrorStore.Actions

GameDeck = React.createClass
  mixins: [
    Reflux.connect(Store)
    Reflux.connect(ErrorStore)
  ]

  onChangeGameDeck: (e) ->
    Actions.changeGameDeckId(e.target.value)

  render: ->
    <div className="form-group row">
      <label className="col-xs-12 start-xs">
        <span className="simple-row">Session Deck:</span>
          <select className="simple-row full-width" value={@state.game.deck_id} onChange={@onChangeGameDeck}>
            {
              for option in @state.decks
                <option value={option.id} key={option.id}>{option.name} ({_.take(option.cards,4).join(', ')})</option>
            }
          </select>
      </label>
    </div>

module.exports = GameDeck


