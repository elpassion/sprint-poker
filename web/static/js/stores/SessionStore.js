import Reflux from 'reflux'
import Actions from '../actions/SessionActions';

var SessionStore = Reflux.createStore({
  listenables: [Actions],

  init() {
    this.session = this.getSession() || {};
    this.error = {};
  },

  getInitialState() {
    return this.returnData();
  },

  returnData() {
    return {
      session: this.session,
      error: this.error
    };
  },

  emitData() {
    this.trigger(this.returnData());
  },

  onSetSession(session) {
    localStorage.setItem('session', JSON.stringify(session));
    this.session = session;
    this.emitData();
  },

  getSession() {
    return JSON.parse(localStorage.getItem('session'));
  }
});

export default SessionStore;
