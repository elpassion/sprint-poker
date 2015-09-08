React = require 'react'
Reflux  = require 'reflux'

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
    <div className={ "form-group #{if @state.errors.user.name then "has-error"}" }>
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

