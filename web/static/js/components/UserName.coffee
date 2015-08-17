React = require 'react'
Reflux  = require 'reflux'

Store = require '../stores/SocketConnectionStore'
Actions = Store.Actions

ErrorStore = require '../stores/ErrorStore'
ErrorActions = ErrorStore.Actions

UserName = React.createClass
  mixins: [
    Reflux.connect(Store)
    Reflux.connect(ErrorStore)
  ]

  onChangeUserName: (e) ->
    Actions.changeUserName(e.target.value)

  onSubmitUserName: (e) ->
    if e.which == 13
      Actions.submitUserName()

  onBlurUserName: ->
    Actions.submitUserName()

  render: ->
    <div className="form-group row">
      <label className="col-xs-12 start-xs">
        <span className="simple-row">Your Nickname:</span>
        <input className="simple-row full-width"
          type="text"
          placeholder="Enter Your Nickname"
          value={ @state.user.name }
          onChange={ @onChangeUserName }
          onKeyDown={ @onSubmitUserName }
          onBlur={ @onBlurUserName }
        />
        {if @state.errors.userName
          <span>{@state.errors.userName}</span>
        }
      </label>
    </div>

module.exports = UserName

