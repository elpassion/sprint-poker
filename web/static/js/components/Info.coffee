React = require 'react'
Reflux = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

Info = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  render: ->
    <div className="alert alert-warning">
      To bedzie info
    </div>

module.exports = Info
