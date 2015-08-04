import Reflux from 'reflux';

var NewRoomActions  =  Reflux.createActions({
  getRoom: { asyncResult: true },
  createRoom: { asyncResult: true },
  pickCardSet: {},
  changeTitle: {},
  changeNick: {}
});

export default NewRoomActions;
