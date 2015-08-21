React = require 'react'
Store = require '../stores/SocketConnectionStore'
{ Navigation } = require 'react-router'

PlanningPokerApp = React.createClass
  mixins: [
    Navigation
  ]

  componentDidMount: ->
    Store.Actions.connect()
    Store.Actions.setErrorCallback =>
      @transitionTo "/"

  render: ->
      <div className='main row center-xs middle-xs'>
        { this.props.children }
      </div>

module.exports = PlanningPokerApp
