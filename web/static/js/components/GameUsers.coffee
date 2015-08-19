React = require 'react'

GameUsers = React.createClass

  render: ->
    <table className="users-list full-width">
      <caption>
        <span>
          Team&nbsp;
        </span>
        <span className="counter">
          (0 Users)
        </span>
      </caption>
      <tbody>
        { for user in [1,2,3,4]
          <tr key={user}>
            <td className="name-column">
              XXX
            </td>
            <td className="owner-column">
              OWNER
            </td>
          </tr>
        }
      </tbody>
    </table>

module.exports = GameUsers
