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
            </td>
            <td className="owner-column">
              {if user.id == @state.game.owner.id
                "OWNER"
              }
              {if user.id == @state.user.id
                "YOU"
              }
            </td>
          </tr>
        }
      </tbody>
    </table>

module.exports = GameUsers
