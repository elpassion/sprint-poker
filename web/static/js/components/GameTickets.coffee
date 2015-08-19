React = require 'react'

GameTickets = React.createClass

  render: ->
    <table className="tickets-list full-width">
      <caption>
        <span>
          Tickets list&nbsp;
        </span>
        <span className="counter">
          (0 total)
        </span>
      </caption>
      <tbody>
        { for ticket in [1,2,3]
          <tr key={ ticket }>
            <td>
              <table className="full-width">
                <tr>
                  <td className="index-column">
                    { 0 }
                  </td>
                  <td className="name-column">
                    { "" }
                  </td>
                  <td className="estimation-column">
                    { "" }
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        }
      </tbody>
    </table>

module.exports = GameTickets
