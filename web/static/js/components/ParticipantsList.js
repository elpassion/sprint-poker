var ParticipantsList = React.createClass({
  propTypes: {
    participants: React.PropTypes.arrayOf(React.PropTypes.object).isRequired,
    ownerId: React.PropTypes.number.isRequired
  },

  shouldComponentUpdate() {
    return true;
  },

  render() {
    let isPlural = () => (this.props.participants.length !== 1) ? 's' : '';
    return (
      <table className="users-list full-width">
        <caption>
          <span>
            Team&nbsp;
          </span>
          <span className="counter">
            ({this.props.participants.length} user{isPlural()})
          </span>
        </caption>
        <tbody>
          {
            this.props.participants.map((participant) => {
              if (participant.id === this.props.ownerId) {
                return (
                  <tr key={participant.id} className="owner-row">
                    <td className="name-column">
                    {participant.name}
                    </td>
                    <td className="owner-column">
                      OWNER
                    </td>
                  </tr>
                );
              }
              else {
                return (
                  <tr key={participant.uuid}>
                    <td className="name-column" colSpan="2">
                      {participant.name}
                    </td>
                  </tr>
                );
              }
            })
          }
        </tbody>
      </table>
    );
  }
});

module.exports = ParticipantsList;

