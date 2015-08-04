import Reflux from 'reflux';

var NewTicketActions = Reflux.createActions({
  "createTicket": { asyncResult: true },
  "changeName": {}
});

export default NewTicketActions;
