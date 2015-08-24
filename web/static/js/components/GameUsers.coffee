React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameUsers = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="users-list full-width">
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
            <td className="name-column">
              {user.name}
              {if user.id == @state.game.owner.id
                <span>&nbsp;OWNER</span>
              }
              {if user.id == @state.user.id
                <span>&nbsp;YOU</span>
              }
            </td>
            { if @state.voting.curentTicket
              <td className="owner-column points">
                { @state.voting.votes[user.id] || 'waiting ...' }
              </td>
            }
          </tr>
        }
      </tbody>
    </table>

module.exports = GameUsers
