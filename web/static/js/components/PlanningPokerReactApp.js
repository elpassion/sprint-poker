import React from 'react'

class PlanningPokerReactApp extends React.Component {
  render() {
    return (
      <div className='main row center-xs middle-xs'>
        { this.props.children }
      </div>
    )
  }
}

export default PlanningPokerReactApp
