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

  githubBadge: ->
    '<img style="position: absolute; top: 0; right: 0; border: 0; z-index: 10000" src="https://camo.githubusercontent.com/365986a132ccd6a44c23a9169022c0b5c890c387/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png">'

  render: ->
    <div>
      <a href="https://github.com/elpassion/planning-poker" dangerouslySetInnerHTML={{__html: @githubBadge()}} />
      { this.props.children }
    </div>

module.exports = PlanningPokerApp
