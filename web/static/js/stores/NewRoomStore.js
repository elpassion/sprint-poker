import Reflux from 'reflux';
import superagent from 'superagent';
import NewRoomActions from '../actions/NewRoomActions';

var NewRoomStore = Reflux.createStore({
  listenables: [NewRoomActions],

  init() {
    this.newRoom = {
      cardSets: [{id: 0, picked: true, values: ["1", "2", "3", "5", "8", "13"], name: "Fibonacci"}],
      title: "",
      nick: ""
    };
    this.error = {};
  },

  getInitialState() {
    return this.returnData();
  },

  returnData() {
    return {
      room: this.newRoom,
      error: this.error
    };
  },

  emitData() {
    this.trigger(this.returnData());
  },

  onPickCardSet(pickedCardSet) {
    _.forEach(this.newRoom.cardSets, function(cardSet) { cardSet.picked = false; });
    _.find(this.newRoom.cardSets, { id: pickedCardSet.id }).picked = true;
    this.emitData();
  },

  onChangeTitle(title) {
    this.newRoom.title = title;
    this.emitData();
  },

  onCreateRoom(room, session, transition) {
    superagent.post('http://localhost:4000/api/rooms')
      .send({ room: { title: room.title, owner_id: session.id } })
      .set('Accept', 'application/json')
      .end((error, response) => {
        if (error) {
          NewRoomActions.createRoom.failed(response);
        } else {
          NewRoomActions.createRoom.completed(response, transition);
        }
      });
  },

  onCreateRoomCompleted(response, transition) {
    var room = JSON.parse(response.text);
    if (transition) { transition(room.uuid); }
  },

  onCreateRoomFailed(error) {
    this.error = error;
    this.emitData();
  }
});

export default NewRoomStore;
