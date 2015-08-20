React = require 'react'
Reflux = require 'reflux'
Store = require '../stores/SocketConnectionStore'

GameNavBar = require './GameNavBar'
GameTickets = require './GameTickets'
GameTicketsOwner = require './GameTicketsOwner'
GameUsers = require './GameUsers'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Game = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  componentDidMount: ->
    Actions.join("game:#{@props.id}")

  render: ->
    <div className="full-width">
      <div className="session-lobby row full-width">
        <div className="session-lobby-content col-xs-12">
          <GameNavBar/>
          <div className="lobby-content row center-xs">
            <div className="lobby-container container">
              <div className="row">
                <div className="col-xs-8">
                      <GameTicketsOwner/>
                </div>
                <div className="col-xs-4">
                  <GameUsers/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

module.exports = Game
