React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/Store'
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
    Actions.startVoting(@state.gameState.currentTicketId)

  onTicketPointsChange: (e) ->
    Actions.changeTicketPoints(e.target.value)

  render: ->
    <div>
      { if @state.gameState.name == "review"
        <table className="table">
          <tbody>
              <tr>
                <td>Final estimation</td>
                <td className="points">
                  <select className="input-gray"
                    value={ @state.game.tickets[@state.gameState.currentTicketId].points }
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
      }
      { if @state.gameState.name == "none"
        <button className="btn btn-gray-border" onClick={ @onStartVotingClick }>Start Voting</button>
      }
      { if @state.gameState.name == "voting"
        <button className="btn btn-gray-border" onClick={ @onFinishVotingClick }>Review Points</button>
      }
      { if @state.gameState.name == "review"
        <button className="btn btn-gray-border" onClick={ @onNextClick }>Next Ticket</button>
      }
      { if @state.gameState.name == "review"
        <button className="btn btn-gray-border" onClick={ @onVoteAgainClick }>Vote Again</button>
      }
  </div>

module.exports = GameOwnerControls


