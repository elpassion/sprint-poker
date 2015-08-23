React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Template = require '../templates/Cards.rt'

Errors = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    Template.apply(this)

module.exports = Errors

