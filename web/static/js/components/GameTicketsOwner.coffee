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
          <tr key={ticket}>
            <td>
              <form>
                <table className="full-width">
                  <tr>
                    <td className="index-column">
                      {0}
                    </td>
                    <td className="name-column">
                      <input className="full-width" type="text"/>
                    </td>
                    <td className="estimation-column">
                      {0}
                    </td>
                    <td className="delete-column">
                      <input type="button" value="DELETE"/>
                    </td>
                  </tr>
                </table>
              </form>
            </td>
          </tr>
        }
        <tr>
          <td colSpan="4">
            <form>
              <table className="full-width">
                <tr>
                  <td className="index-column">
                    -
                  </td>
                  <td className="name-column" colSpan="2">
                    <input className="full-width" type="text" placeholder="enter your ticket name here"/>
                  </td>
                  <td className="delete-column">
                    <input type="submit" value="CREATE"></input>
                  </td>
                </tr>
              </table>
            </form>
          </td>
        </tr>
      </tbody>
    </table>

module.exports = GameTickets
