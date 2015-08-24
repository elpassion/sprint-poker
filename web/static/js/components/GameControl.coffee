React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

GameControl = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <table className="tickets-list full-width">
      <tbody>
          <tr>
            <td>
              <table className="full-width">
                <tr>
                  <td className="index-column">
                    1
                  </td>
                  <td className="name-column">
                    nejs
                  </td>
                  <td className="delete-column">
                    <input type="button" value="PREVIOUS" onClick={ null }/>
                  </td>
                  <td className="delete-column">
                    <input type="button" value="NEXT" onClick={ null }/>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
      </tbody>
    </table>

module.exports = GameControl

