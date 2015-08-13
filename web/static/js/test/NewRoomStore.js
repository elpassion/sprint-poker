import assert from 'assert'
import Reflux from 'reflux'
import NewRoomStore from '../stores/NewRoomStore'
import NewRoomActions from '../actions/NewRoomActions'
import sinon from 'sinon'

describe('NewTicketStore',()  => {
  it('should return newTicket and error when subscribed to', () => {
    assert.deepEqual(NewRoomStore.getInitialState(), { newTicket: {}, error: {} });
  });

  it('should change its state name when changing name', () => {
    NewRoomActions.changeTitle('Michal');
    console.log(NewRoomActions);
    assert.equal(NewRoomStore.newRoom.title, 'Michal');
  });
});
