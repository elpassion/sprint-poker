React = require 'react'
Store = require '../stores/Store'
Reflux = require 'reflux'

{ Navigation } = require 'react-router'

Footer = require './Footer'

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
    <div>
      {this.props.children}
      <Footer />
    </div>

module.exports = SprintPokerApp
