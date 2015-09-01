React = require 'react'
Reflux = require 'reflux'
Store = require '../stores/SocketConnectionStore'

GameNavBar = require './GameNavBar'
GameTickets = require './GameTickets'
GameTicketsOwner = require './GameTicketsOwner'
GameUsers = require './GameUsers'
Cards = require './Cards'
GameCurrentTicket = require './GameCurrentTicket'
GameCurrentTicketOwner = require './GameCurrentTicketOwner'
GameOwnerControls = require './GameOwnerControls'
Errors = require './Errors'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Game = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  componentDidMount: ->
    Actions.join("game:#{@props.id}")

  render: ->
    <div>
      <GameNavBar/>
      <div className="container">
        <div className="row">
          <div className="col-md-8">
            <Errors/>
            <GameCurrentTicket/>
            <Cards disabled={ @state.gameState.name != 'voting' }/>
            { if @state.user.id == @state.game.owner.id
                <GameTicketsOwner/>
              else
                <GameTickets/>
            }
          </div>
          <div className="col-md-4">
            <GameUsers/>
            { if @state.user.id == @state.game.owner.id
              <GameOwnerControls/>
            }
          </div>
        </div>
      </div>
    </div>

module.exports = Game
