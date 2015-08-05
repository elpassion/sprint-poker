import React from 'react';
import Reflux from 'reflux';
import { Navigation, Link } from 'react-router';

import NewRoomStore from '../stores/NewRoomStore';
import SessionStore from '../stores/SessionStore';
import NewRoomActions from '../actions/NewRoomActions';
import CardSetList from './CardSetList';

import logo from '../../assets/images/logo.png';

var NewRoom = React.createClass({
  mixins: [
    Reflux.connect(NewRoomStore, "newRoomStorage"),
    Reflux.connect(SessionStore, "sessionStorage"),
    Navigation
  ],

  shouldComponentUpdate: function() {
    return true;
  },

  changeTitle: function(event) {
    NewRoomActions.changeTitle(event.target.value);
  },

  createRoom: function(event) {
    NewRoomActions.createRoom(this.state.newRoomStorage.room, this.state.sessionStorage.session, (uuid) => { this.transitionTo(`rooms/${uuid}`); });
    event.preventDefault();
  },

  render: function () {
    return (
      <div className="pp-NewRoom">
        <img className="logo" src={logo}></img>
        <div className="form-container">
          <div className="header-text">
            Use online Planning Poker to easy estimate and plan tickets with your team. Your room will only be seen by those you invite.
          </div>
          <form className="room-form" onSubmit={this.createRoom}>
            <CardSetList cardSets={this.state.newRoomStorage.room.cardSets} />
            <div className="form-group">
              <label>
                  <span>Session Title:</span>
                  <input value={this.state.newRoomStorage.room.title} type="text" onChange={this.changeTitle}/>
              </label>
            </div>
            <button className="pp-button primary fluid" type="submit">Start Session</button>
          </form>
        </div>
      </div>
    );
  }
});

export default NewRoom;
