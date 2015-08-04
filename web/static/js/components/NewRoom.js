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
      <div className="sessions col-xs-12 col-md-6">
        <img className="logo" src={logo}></img>
        <div className="session-form-container row">
          <div className="header-text col-xs-12">
            Use online Planning Poker to easy estimate and plan tickets with your team. Your room will only be seen by those you invite.
          </div>
          <form className="session-form col-xs-12" onSubmit={this.createRoom}>
            <CardSetList cardSets={this.state.newRoomStorage.room.cardSets} />
            <div className="form-group row">
              <label className="col-xs-12 start-xs">
                  <span className="simple-row">Session Title:</span>
                  <input className="simple-row full-width" value={this.state.newRoomStorage.room.title} type="text" onChange={this.changeTitle}/>
              </label>
            </div>
            <button className="button full-width" type="submit">Start Session</button>
          </form>
        </div>
      </div>
    );
  }
});

export default NewRoom;
