React = require 'react'
Reflux  = require 'reflux'
classNames = require 'classnames'

Store = require '../stores/Store'
Actions = Store.Actions

UserName = React.createClass
  mixins: [
    Reflux.connect(Store)
  ]

  onChangeUserName: (e) ->
    Actions.changeUserName(e.target.value)

  onSubmitUserName: (e) ->
    if e.which == 13
      Actions.validateUserName()
      Actions.submitUserName()

  onBlurUserName: ->
    Actions.validateUserName()
    Actions.submitUserName()

  render: ->
    <div className={ classNames('form-group', { 'has-error': @state.errors.user.name }) }>
      <label htmlFor="user_name">Your Nickname:</label>
      <input
        className="form-control"
        type="text"
        id="user_name"
        placeholder="Enter Your Nickname"
        value={ @state.user.name }
        onChange={ @onChangeUserName }
        onKeyDown={ @onSubmitUserName }
        onBlur={ @onBlurUserName }
      />
      {if @state.errors.user.name
        <div className="error text-right">{ @state.errors.user.name }</div>
      }
    </div>

module.exports = UserName

