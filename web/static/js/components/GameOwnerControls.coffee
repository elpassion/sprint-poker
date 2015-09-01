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
    Actions.startVoting(@state.gameState.currentTicketIndex)

  onTicketPointsChange: (e) ->
    Actions.changeTicketPoints(e.target.value)

  render: ->
    <table className="table table-striped">
      <tbody>
        <tr>
          { if @state.gameState.name == "none"
            <td><button className="btn btn-gray" onClick={ @onStartVotingClick }>START</button></td>
          }
          { if @state.gameState.name == "voting"
           <td><button className="btn btn-gray" onClick={ @onFinishVotingClick }>FINISH</button></td>
          }
          { if @state.gameState.name == "finished"
            <td><button className="btn btn-gray" onClick={ @onNextClick }>NEXT</button></td>
          }
          { if @state.gameState.name == "finished"
            <td><button className="btn btn-gray" onClick={ @onVoteAgainClick }>AGAIN</button></td>
          }
          { if @state.gameState.name == "finished"
            <td className="points">
              <select className="input-gray"
                value={ @state.game.tickets[@state.gameState.currentTicketIndex].points }
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
          }
        </tr>
      </tbody>
    </table>
module.exports = GameOwnerControls


