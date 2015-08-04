import React from 'react';
import Reflux from 'reflux';

import RoomStore from '../stores/RoomStore';
import TicketsStore from '../stores/TicketsStore';
import ParticipantsStore from '../stores/ParticipantsStore';
import SocketConnectionStore from '../stores/SocketConnectionStore';
import SocketConnectionActions from '../actions/SocketConnectionActions';
import SessionStore from '../stores/SessionStore';

var Room = React.createClass({
  mixins: [
    Reflux.connect(SocketConnectionStore, "socketConnectionStorage"),
    Reflux.connect(RoomStore, "roomStorage"),
    Reflux.connect(TicketsStore, "ticketsStorage"),
    Reflux.connect(ParticipantsStore, "participantsStorage"),
    Reflux.connect(SessionStore, "sessionStorage")
  ],

  componentDidMount() {
    SocketConnectionActions.establishConnection(this.props.params.uuid, this.state.sessionStorage.session);
  },

  shouldComponentUpdate() {
    return true;
  },

  render() {
    return (
      <div className="full-width">{this.props.children}</div>
    );
  }
});

export default Room;
