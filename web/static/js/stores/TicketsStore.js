var Actions = require('../actions/TicketsActions');
var SocketConnectionActions = require('../actions/SocketConnectionActions');

var TicketsStore = Reflux.createStore({
  listenables: [Actions],

  init() {
    this.tickets = [];
    this.error = {};
  },

  getInitialState() {
    return this.returnData();
  },

  returnData() {
    return {
      tickets: this.tickets,
      error: this.error
    };
  },

  emitData() {
    this.trigger(this.returnData());
  },

  onSetTickets(tickets) {
    this.tickets = tickets;
    this.emitData();
  },

  onChangeName(ticketId, name) {
    var ticket = _.find(this.tickets, { id: ticketId });
    ticket.name = name;
    SocketConnectionActions.updateTicket(ticket);
  },

  onDeleteTicket(ticketId) {
    SocketConnectionActions.deleteTicket(_.find(this.tickets, { id: ticketId }));
  },

  onAddTicket(ticket) {
    this.tickets.push(ticket);
    this.emitData();
  }
});

module.exports = TicketsStore;
