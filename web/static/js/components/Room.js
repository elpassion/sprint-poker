var RoomStore = require('../stores/RoomStore');
var TicketsStore = require('../stores/TicketsStore');
var ParticipantsStore = require('../stores/ParticipantsStore');
var SocketConnectionStore = require('../stores/SocketConnectionStore');
var SocketConnectionActions = require('../actions/SocketConnectionActions');
var SessionStore = require('../stores/SessionStore');

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

module.exports = Room;

