React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameUsers = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="table table-striped">
      <caption>
        <span>
          Team&nbsp;
        </span>
        <span className="counter">
          ({@state.game.users.length} Users)
        </span>
      </caption>
      <tbody>
        { for user in @state.game.users
          <tr key={user.id}>
            <td>
                {user.name}
                {if user.id == @state.game.owner.id
                  <span className="label label-default pull-right">OWNER</span>
                }
                {if user.id == @state.user.id
                  <span className="label label-primary pull-right">YOU</span>
                }
                {if user.state == 'disconnected'
                  <span className="label label-danger pull-right">DISCONNECTED</span>
                }
            </td>
            { if @state.gameState.name != 'none'
              <td className="points text-center">
                { @state.gameState.votes[user.id] || 'waiting ...' }
              </td>
            }
          </tr>
        }
      </tbody>
    </table>

module.exports = GameUsers
