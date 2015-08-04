import React from 'react'

var PlanningPokerReactApp = React.createClass({
  render: function() {
    return (
      <div className='main row center-xs middle-xs'>
        { this.props.children }
      </div>
    );
  }
});

export default PlanningPokerReactApp;
