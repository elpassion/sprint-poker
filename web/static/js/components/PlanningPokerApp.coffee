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
    this.props.children

module.exports = PlanningPokerApp
