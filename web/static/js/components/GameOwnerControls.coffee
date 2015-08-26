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

  onNextClick: ->
    Actions.startVoting()

  onVoteAgainClick: ->
    Actions.startVoting(@state.gameState.current_ticket_index)

  onTicketPointsChange: (e) ->
    Actions.changeTicketPoints(e.target.value)

  render: ->
    <table className="users-list full-width">
      <tbody>
        <tr>
          <td className="name-column">
            { if @state.gameState.name == "none"
              <input type="button" value="Start" onClick={ @onStartVotingClick }/>
            }
            { if @state.gameState.name == "voting"
              <input type="button" value="Finish" onClick={ @onFinishVotingClick }/>
            }
            { if @state.gameState.name == "finished"
              <input type="button" value="Next" onClick={ @onNextClick }/>
            }
            { if @state.gameState.name == "finished"
              <input type="button" value="Vote Again" onClick={ @onVoteAgainClick }/>
            }
          </td>
          <td className="name-column">
            { if @state.gameState.name == "finished"
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
            }
          </td>
        </tr>
      </tbody>
    </table>

module.exports = GameOwnerControls


