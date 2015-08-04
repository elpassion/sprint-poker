import React from 'react'
import Reflux from 'reflux'

import RoomStore from '../stores/RoomStore';
import TicketsStore from '../stores/TicketsStore';
import ParticipantsStore from '../stores/ParticipantsStore';
import LobbyNavbar from './LobbyNavbar';
import TicketsList from './TicketsList';
import ParticipantsList from './ParticipantsList';
import SocketConnectionStore from '../stores/SocketConnectionStore';
import SessionStore from '../stores/SessionStore';
import SocketConnectionActions from '../actions/SocketConnectionActions';

var RoomLobby = React.createClass({
  mixins: [
    Reflux.connect(SocketConnectionStore, "socketConnectionStorage"),
    Reflux.connect(RoomStore, "roomStorage"),
    Reflux.connect(TicketsStore, "ticketsStorage"),
    Reflux.connect(ParticipantsStore, "participantsStorage")
  ],

  shouldComponentUpdate() {
    return true;
  },

  render: function () {
    return (
      <div className="session-lobby row full-width">
        <div className="session-lobby-content col-xs-12">
          <LobbyNavbar roomName={this.state.roomStorage.room.title} roomUUID={this.state.roomStorage.room.id}/>
          <div className="lobby-content row center-xs">
            <div className="lobby-container container">
              <div className="row">
                <div className="col-xs-8">
                  <TicketsList tickets={this.state.ticketsStorage.tickets}/>
                </div>
                <div className="col-xs-4">
                  <ParticipantsList participants={this.state.participantsStorage.participants} ownerId={this.state.roomStorage.room.owner_id}/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
});

export default RoomLobby;
