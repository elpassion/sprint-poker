import Reflux from 'reflux'

import Actions from '../actions/NewTicketActions';
import SocketConnectionActions from '../actions/SocketConnectionActions';

var NewTicketStore = Reflux.createStore({
  listenables: [Actions],

  init() {
    this.newTicket = {};
    this.error = {};
  },

  getInitialState() {
    return this.returnData();
  },

  returnData() {
    return {
      newTicket: this.newTicket,
      error: this.error
    };
  },

  emitData() {
    this.trigger(this.returnData());
  },

  onChangeName(name) {
    this.newTicket.name = name;
    this.emitData();
  },

  onCreateTicket() {
    SocketConnectionActions.createTicket(this.newTicket, '0e72e2bd-6642-4f05-8468-8cefafd7b865');
    this.newTicket = {};
    this.emitData();
  }
});

export default NewTicketStore;
