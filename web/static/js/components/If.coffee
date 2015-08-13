React = require 'react'

If = React.createClass
  render: ->
    if @props.condition
      @props.children
    else
      false

module.exports = If
