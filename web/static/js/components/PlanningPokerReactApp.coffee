React = require 'react'
SocketConnectionActions = require '../actions/SocketConnectionActions'

PlanningPokerReactApp = React.createClass

  componentDidMount: ->
    SocketConnectionActions.connect()

  render: ->
      <div className='main row center-xs middle-xs'>
        { this.props.children }
      </div>

module.exports = PlanningPokerReactApp
