import React from 'react'

import Actions from '../actions/TicketsActions';
import NewTicketForm from './NewTicketForm';

var TicketsList = React.createClass({
  propTypes: {
    tickets: React.PropTypes.arrayOf(React.PropTypes.object).isRequired
  },

  shouldComponentUpdate() {
    return true;
  },

  preventSubmit(event) {
    event.preventDefault();
  },

  changeTicketName(event) {
    Actions.changeName(parseInt(event.target.dataset.id), event.target.value);
  },

  deleteTicket() {
    Actions.deleteTicket(parseInt(event.target.dataset.id));
  },

  isOwner() {
    return this.ownerId === this.userId;
  },

  ticketRow(ticket) {
    if(this.isOwner()) {
      return(
        <tr key={ticket.id}>
          <td>
            <form onSubmit={this.preventSubmit}>
              <table className="full-width">
                <tr>
                  <td className="index-column">
                    {ticket.id}
                  </td>
                  <td className="name-column">
                    <input className="full-width" data-id={ticket.id} onChange={this.changeTicketName} type="text" value={ticket.name}></input>
                  </td>
                  <td className="estimation-column">
                    {ticket.estimation}
                  </td>
                  <td className="delete-column">
                    <input type="button" data-id={ticket.id} onClick={this.deleteTicket} value="DELETE"></input>
                  </td>
                </tr>
              </table>
            </form>
          </td>
        </tr>
      );
    }
    else {
      return(
        <tr key={ticket.id}>
          <td>
            <table className="full-width">
              <tr>
                <td className="index-column">
                  {ticket.id}
                </td>
                <td className="name-column">
                  {ticket.name}
                </td>
                <td className="estimation-column">
                  {ticket.estimation}
                </td>
              </tr>
            </table>
          </td>
        </tr>
      );
    }
  },

  render() {
    return (
      <table className="tickets-list full-width">
        <caption>
          <span>
            Tickets list&nbsp;
          </span>
          <span className="counter">
            ({this.props.tickets.length} total)
          </span>
        </caption>
        <tbody>
          {
            this.props.tickets.map((ticket) => {
              return this.ticketRow(ticket);
            })
          }
          <NewTicketForm />
        </tbody>
      </table>
    );
  }
});

export default TicketsList;
