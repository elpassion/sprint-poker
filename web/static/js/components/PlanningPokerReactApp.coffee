React = require 'react'
Store = require '../stores/SocketConnectionStore'

PlanningPokerReactApp = React.createClass
  componentDidMount: ->
    Store.Actions.connect()

  render: ->
      <div className='main row center-xs middle-xs'>
        { this.props.children }
      </div>

module.exports = PlanningPokerReactApp
