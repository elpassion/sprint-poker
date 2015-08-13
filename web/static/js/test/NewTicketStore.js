import assert from 'assert'
import Reflux from 'reflux'
import NewTicketStore from '../stores/NewTicketStore'
import NewTicketActions from '../actions/NewTicketActions'

describe('NewTicketStore',()  => {
  it('should return newTicket and error when subscribed to', () => {
    assert.deepEqual(NewTicketStore.getInitialState(), { newTicket: {}, error: {} });
  });

  it('should change its state name when changing name', () => {
    NewTicketStore.onChangeName('Michal');
    assert.equal(NewTicketStore.newTicket.name, 'Michal');
  });
});
