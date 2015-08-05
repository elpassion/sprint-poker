import React from 'react'

class PlanningPokerReactApp extends React.Component {
  render() {
    return (
      <div className='pp-App'>
        { this.props.children }
      </div>
    );
  }
}

export default PlanningPokerReactApp;
