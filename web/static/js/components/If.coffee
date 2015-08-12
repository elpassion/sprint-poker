React = require 'react'

If = React.createClass
  render: ->
    if this.props.condition
      this.props.children
    else
      false

module.exports = If
