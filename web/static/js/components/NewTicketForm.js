var NewTicketStore = require('../stores/NewTicketStore');
var NewTicketActions = require('../actions/NewTicketActions');

var NewTicketForm = React.createClass({
  mixins: [Reflux.connect(NewTicketStore, "newTicketStorage")],

  shouldComponentUpdate() {
    return true;
  },

  changeName(event) {
    NewTicketActions.changeName(event.target.value);
  },

  createTicket(event) {
    event.preventDefault();
    NewTicketActions.createTicket();
  },

  render() {
    return (
      <tr>
        <td colSpan="4">
          <form onSubmit={this.createTicket}>
            <table className="full-width">
              <tr>
                <td className="index-column">
                  I
                </td>
                <td className="name-column" colSpan="2">
                  <input onChange={this.changeName} className="full-width" type="text" value={this.state.newTicketStorage.newTicket.name} placeholder="enter your ticket name here"></input>
                </td>
                <td className="delete-column">
                  <input type="submit" value="CREATE"></input>
                </td>
              </tr>
            </table>
          </form>
        </td>
      </tr>
    );
  }
});

module.exports = NewTicketForm;

