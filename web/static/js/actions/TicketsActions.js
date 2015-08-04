import Reflux from 'reflux'

var TicketsActions = Reflux.createActions({
  changeName: {},
  deleteTicket: { asyncResult: true },
  addTicket: {},
  setTickets: {}
});

export default TicketsActions;
