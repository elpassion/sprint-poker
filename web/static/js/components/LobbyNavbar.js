import React from 'react';

var LobbyNavbar = React.createClass({
  propTypes: {
    roomName: React.PropTypes.string.isRequired,
    roomUUID: React.PropTypes.string.isRequired
  },

  getDefaultProps: function() {
    return {
      roomName: "",
      roomUUID: ""
    };
  },

  shouldComponentUpdate: function() {
    return true;
  },

  roomUrl() {
    return `http://localhost:8000/webpack-dev-server/rooms/${this.props.roomUUID}`
  },

  render: function () {
    return (
      <nav className="lobby-navbar row center-xs middle-xs">
        <div className="container">
          <div className="simple-row middle-xs">
            <img className="logo" src="../images/logo_small.png" alt="Planning Poker"/>
            <div className="separator"></div>
            <div className="project-name">
              <span className="project">PROJECT:</span>
              <span className="name">{this.props.roomName}</span>
            </div>
            <div className="invite simple-row middle-xs">
              <span className="invite-text">INVITE PEOPLE:</span>
              <div className="invite-link simple-row">
                <span className="link">{this.roomUrl()}</span>
                <a href="#" className="addon">
                  CTRL + C
                </a>
              </div>
            </div>
          </div>
        </div>
      </nav>
    );
  }
});

export default LobbyNavbar;
