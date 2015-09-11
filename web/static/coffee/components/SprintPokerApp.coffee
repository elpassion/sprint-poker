React = require 'react'
Store = require '../stores/Store'
Reflux = require 'reflux'

{ Navigation } = require 'react-router'

SprintPokerApp = React.createClass
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

module.exports = SprintPokerApp
