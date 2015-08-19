React = require 'react'

GameNavBar = require './GameNavBar'

Store = require '../stores/SocketConnectionStore'

Game = React.createClass

  render: ->
    <div className="full-width">
      <div className="session-lobby row full-width">
        <div className="session-lobby-content col-xs-12">
          <GameNavBar/>
          <div className="lobby-content row center-xs">
            <div className="lobby-container container">
              <div className="row">
                <div className="col-xs-8">
                  <!-- TicketsList -->
                </div>
                <div className="col-xs-4">
                  <!-- ParticipantsList -->
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

module.exports = Game
