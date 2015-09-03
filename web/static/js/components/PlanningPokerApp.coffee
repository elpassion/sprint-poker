React = require 'react'
Store = require '../stores/SocketConnectionStore'
Reflux = require 'reflux'

{ Navigation } = require 'react-router'

PlanningPokerApp = React.createClass
  mixins: [
    Reflux.connect(Store)
    Navigation
  ]

  componentDidMount: ->
    Store.Actions.connect()
    Store.Actions.setErrorCallback =>
      @transitionTo "/"

  render: ->
    <div className='main row center-xs middle-xs'>
      { if @state.errors.socket != null
        <div className="errors col-xs-12 col-md-6">{ @state.errors.socket }</div>
      }
      { this.props.children }
    </div>

module.exports = PlanningPokerApp
