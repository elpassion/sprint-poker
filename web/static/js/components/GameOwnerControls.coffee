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

  onTicketPointsChange: (e) ->
    Actions.changeTicketPoints(e.target.value)

  render: ->
    if @state.gameState.name != "none"
      <table className="users-list full-width">
        <tbody>
          <tr>
            <td className="name-column">
              <input type="button" value="Finish" onClick={ @onFinishVotingClick }/>
            </td>
            <td className="owner-column points">
              <select className="simple-row full-width"
                value={ @state.game.tickets[@state.gameState.current_ticket_index].points }
                onChange={ @onTicketPointsChange }
                disabled={ @props.disabled }
              >
                <option value="" key=""> - </option>
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


