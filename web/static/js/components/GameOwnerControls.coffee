React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameOwnerControls = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onFinishVotingClick: ->
    Actions.finishVoting()

  onStartVotingClick: ->
    Actions.startVoting()

  render: ->
    if @state.voting.currentTicketIndex != null
      <table className="users-list full-width">
        <tbody>
          <tr>
            <td className="name-column">
              <input type="button" value="Finish" onClick={ @onFinishVotingClick }/>
            </td>
            <td className="owner-column points">
              <select className="simple-row full-width"
                value={ @state.game.deck.id }
                onChange={ @onChangeGameDeck }
                disabled={ @props.disabled }
              >
                {
                  for card in @state.game.deck.cards
                    <option
                      value={ card }
                      key={ card }>
                      { card }
                    </option>
                }
              </select>
            </td>
          </tr>
        </tbody>
      </table>
    else
      <input type="button" value="Start" onClick={ @onStartVotingClick }/>

module.exports = GameOwnerControls


